import Foundation

protocol MapViewModelDelegate: AnyObject {
    func addLocation()

    func showLocationsList()
    
    func showLocationDetails()
}
