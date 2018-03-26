import Foundation
import UIKit

class AsyncImageView: UIView {
    let canvas: UIImageView = UIImageView()
    let imageCache = NSCache<NSString , UIImage>()
    var imageUrlString : String?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addSubview(canvas)
        canvas.contentMode = .scaleAspectFit
        canvas.translatesAutoresizingMaskIntoConstraints = false
        canvas.clipsToBounds = true
        let topConstraint = NSLayoutConstraint(item: canvas,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: canvas,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: canvas,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: canvas,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: 0)
        addConstraints([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        layoutIfNeeded()
    }
    
    func reset() {
        canvas.image = nil
    }
    
    // function to asynchronously load images inside the imageview
    // if the image is present inside the local cache then no need to fetch from the internet
    // if the call could not be completed then insert a default image for broken link
    // If the app extends in functionality, this method can be moved to a separate extension to make it accessible through out the app
    func loadImage(urlString: String){
        
        imageUrlString = urlString
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            DispatchQueue.main.async {
                self.canvas.image = imageFromCache
                self.canvas.clipsToBounds = true
            }
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    // if the request could not load then show a broken url image
                    self.canvas.image = #imageLiteral(resourceName: "placeholder")
                }
                return
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                DispatchQueue.main.async {
                    if let imageToBeStoredInCache = UIImage(data: data){
                        if self.imageUrlString == urlString{
                            self.canvas.image = imageToBeStoredInCache
                            self.canvas.clipsToBounds = true
                        }
                        self.imageCache.setObject(imageToBeStoredInCache, forKey: urlString as NSString)
                    }
                }
            }else{
                DispatchQueue.main.async {
                    self.canvas.image = #imageLiteral(resourceName: "placeholder")
                    self.canvas.clipsToBounds = true
                }
            }
        }).resume()
    }
}

