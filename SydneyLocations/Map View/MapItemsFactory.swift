import CoreLocation
import Foundation
import MapKit

protocol MapItemsFactoryProtocol {
    static func makeMapItems(models: [Location]) -> [MapPlace]

    static func makeCenter(place: MapPlace) -> CLLocationCoordinate2D

    static func makeRegion(place: MapPlace) -> MKCoordinateRegion
}

enum MapItemsFactory {}

// MARK: - MapItemsFactoryProtocol

extension MapItemsFactory: MapItemsFactoryProtocol {
    
    static func makeMapItems(models: [Location]) -> [MapPlace] {
        models.map {
            MapPlace(
                name: $0.name,
                latitude: $0.latitude,
                longitude: $0.longitude,
                description: $0.descriptionText
            )
        }
    }

    static func makeCenter(place: MapPlace) -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )
    }
    
    static func makeRegion(place: MapPlace) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: makeCenter(place: place),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
}
