import Foundation

struct Location: Codable {
    let id: UUID?
    let name: String
    let latitude: Double
    let longitude: Double
    let descriptionText: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude = "lat"
        case longitude = "lng"
        case descriptionText
    }
}
