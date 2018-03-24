import UIKit

class InfoViewController: UIViewController {
    let cellIndentifier = "Cell"

    @IBOutlet weak var infoCollectionView: UICollectionView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.refresh(_:)),
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
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
    }
}

extension InfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier,
                                                      for: indexPath) as! InfoCollectionViewCell
        (indexPath.item % 2 == 0) ? cell.updateColor(color: UIColor.blue) : cell.updateColor(color: UIColor.red)
        
        return cell
    }
}
