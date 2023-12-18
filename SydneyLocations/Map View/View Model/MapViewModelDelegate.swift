import Foundation

protocol MapViewModelDelegate: AnyObject {
    func createLocation()

    func showLocationsList()
    
    func showLocationDetails(place: MapPlace)
}
