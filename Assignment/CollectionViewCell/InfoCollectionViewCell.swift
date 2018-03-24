import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var infodescriptionLabel: UILabel!
    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    
    func updateColor(color: UIColor) {
        self.backgroundColor = color
    }
}
