import Foundation

protocol MapViewModelDelegate: AnyObject {
    func createLocation(didAddLocation: @escaping () -> Void)

    func showLocationsList()
    
    func showLocationDetails(place: MapPlace)
}
