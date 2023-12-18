import Foundation

struct Locations: Codable {
    let locations: [Location]?
    let lastUpdateDate: String?
    
    enum CodingKeys: String, CodingKey {
        case locations
        case lastUpdateDate = "updated"
    }
}
