import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infodescriptionLabel: UILabel!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoImageView: AsyncImageView!
    var infoModel : Info? {
        didSet {
            self.infoTitleLabel.text = nil
            self.infodescriptionLabel.text = nil
            self.infoImageView.reset()
            if let infoModel = infoModel {
                self.infoTitleLabel.text = infoModel.title
                if let description = infoModel.description{
                    self.infodescriptionLabel.text = description
                    setupInfoImage()
                }
				infoTitleLabel.backgroundColor = UIColor.red
				infodescriptionLabel.backgroundColor = UIColor.green
            }
        }
    }
    
    func setupInfoImage(){
        if let propertyImageUrl = infoModel?.imageHref{
            // Call the method to load images asynchronously
            infoImageView.loadImage(urlString: propertyImageUrl)
        }
    }
}
