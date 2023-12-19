import CoreLocation
import Foundation

struct MapPlace: Identifiable, Equatable {
    static let Sydney = MapPlace(
        id: UUID(),
        name: "Sydney",
        latitude: -33.865143,
        longitude: 151.209900,
        description: "Sydney is the capital of the Australia."
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
