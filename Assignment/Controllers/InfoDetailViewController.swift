import UIKit

class InfoDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var infoImageView: AsyncImageView!
    
    var infoModel : Info?

    func setupInfoImage(){
        if let propertyImageUrl = infoModel?.imageHref{
            // Call the method to load images asynchronously
            infoImageView.loadImage(urlString: propertyImageUrl)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setting up the navigation controllers 
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func updateView() {
        if let infoModel = infoModel {
            self.title = infoModel.title
            if let description = infoModel.description{
                self.descriptionLabel.text = description
                setupInfoImage()
            }
        }
    }
}
