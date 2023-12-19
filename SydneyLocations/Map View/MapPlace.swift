import CoreLocation
import Foundation

struct MapPlace: Identifiable, Equatable {
    static let Sydney = MapPlace(
        id: UUID(),
        name: "Sydney",
        latitude: -33.865143,
        longitude: 151.209900,
        description: "Sydney is one the largest cities of Australia."
    )
    
    static let BondiBeach = MapPlace(
        id: UUID(),
        name: "Bondi Beach",
        latitude: -33.889967,
        longitude: 151.276440,
        description: "Bondi Beach is a popular beach and the name of the surrounding suburb in Sydney, New South Wales, Australia."
    )
    
    let id: UUID
    let name: String
    let latitude: Double
    let longitude: Double
    let description: String?
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
