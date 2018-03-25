import UIKit

private enum InfoViewConstant {
    static let imageViewHeight: CGFloat = 185
    static let padding: CGFloat = 8
    static let descriptionFont: UIFont = UIFont.systemFont(ofSize: 17)
    static let totalPredefinedHeight: CGFloat =  {
        return InfoViewConstant.imageViewHeight + InfoViewConstant.padding * 4
    }()
}

class InfoViewController: UIViewController {
    let cellIndentifier = "Cell"
    var canadaInfo : CanadaInfo? = nil
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        infoCollectionView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let flowLayout = infoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }

    func loadData(pullToRefresh: Bool = false) {
        if !pullToRefresh {
            // start Loading indicator
            startLoadingIndicator()
        }
        // Fetch data from the API
        NetworkDataLoader().loadResult { result in
            switch result {
            case let .success(canadaInfo):
                self.canadaInfo = canadaInfo
                DispatchQueue.main.async {
                    self.title = canadaInfo.title
                    self.refreshControl.endRefreshing()
                    self.activityIndicator.stopAnimating()
                    self.infoCollectionView.reloadData()
                }
                // We had handle the error more precisely rather then just printing to console.
            // The specific type of error can generate specific error for the user
            case let .failure(error) : print(error)
            }
        }
    }
    
    func startLoadingIndicator() {
        // start activity spinner
        view.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadData(pullToRefresh: true)
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let info = canadaInfo?.rows[indexPath.item]
        let descriptionSize = info?.description?.size(font: InfoViewConstant.descriptionFont, maxSize: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let totalHeight: CGFloat = InfoViewConstant.totalPredefinedHeight + (descriptionSize?.height ?? 0) + InfoViewConstant.padding
        return CGSize(width: UIScreen.main.bounds.width, height: totalHeight)
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return canadaInfo?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier,
                                                      for: indexPath) as! InfoCollectionViewCell
        let info = canadaInfo?.rows[indexPath.item]
        cell.infoModel = info
        return cell
    }
}
