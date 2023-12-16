import MapKit

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        lhs.center.latitude == rhs.center.latitude &&
        lhs.center.longitude == rhs.center.longitude
    }
    
    var coordinate: CLLocationCoordinate2D {
        .init(latitude: center.latitude, longitude: center.longitude)
    }
}
