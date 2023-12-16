import CoreLocation
import Foundation

struct MapPlace: Identifiable, Equatable {
    static let Sydney = MapPlace(
        name: "Sydney",
        latitude: -33.865143,
        longitude: 151.209900
    )
    
    let id = UUID().uuidString
    let name: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: latitude, longitude: longitude)
    }
}
