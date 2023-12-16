import Foundation

struct Locations: Codable {
    let locations: [Location]?
    let lastUpdateDate: String? // "2016-12-01T06:52:08Z"
    
    enum CodingKeys: String, CodingKey {
        case locations
        case lastUpdateDate = "updated"
    }
}
