import Foundation
import CoreLocation
import MapKit
@testable import SydneyLocations

enum MapItemsFactoryMock: MapItemsFactoryProtocol {
    
    static var isMakeMapItemsCalled: Bool = false
    static var makeMapItemsResult = [SydneyLocations.MapPlace]()
    
    static var isMakeCenterCalled: Bool = false
    static var makeCenterResult = CLLocationCoordinate2D(
        latitude: .zero,
        longitude: .zero
    )
    
    static var isMakeRegionCalled: Bool = false
    static var makeRegionResult = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: .zero,
            longitude: .zero
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    static func makeMapItems(models: [SydneyLocations.Location]) -> [SydneyLocations.MapPlace] {
        isMakeMapItemsCalled = true
        return makeMapItemsResult
    }
    
    static func makeCenter(place: SydneyLocations.MapPlace) -> CLLocationCoordinate2D {
        isMakeCenterCalled = true
        return makeCenterResult
    }
    
    static func makeRegion(place: SydneyLocations.MapPlace) -> MKCoordinateRegion {
        isMakeRegionCalled = true
        return makeRegionResult
    }
}
