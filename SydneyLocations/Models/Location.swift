import Foundation

struct Location: Codable {
    let name: String
    let latitude: Double // -33.850750
    let longitude: Double // 151.276440

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lng"
    }
}
