import Foundation.NSURL

// Model object to populate Info table view controller
struct CanadaInfo: Decodable {
    let title: String
    var rows: [Info]
    
    enum CodingKeys: String, CodingKey {
        case title
        case rows
    }
}

