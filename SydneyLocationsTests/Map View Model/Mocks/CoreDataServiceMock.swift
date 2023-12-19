import Foundation
@testable import SydneyLocations

final class CoreDataServiceMock: CoreDataServiceProtocol {
    
    var isGetLocationsCalled: Bool = false
    var getLocationsResponse = [SydneyLocations.Location]()
    
    var isGetLocationByIdCalled: Bool = false
    var getLocationByIdResponse = [SydneyLocations.Location]()
    
    var isCreateLocation: Bool = false
    var isCreateLocationWithDataCalled: Bool = false
    var isUpdateLocationCalled: Bool = false
    var isUpdateLocationCalledWithData: Bool = false
    var isDeleteLocationByIdCalled: Bool = false
    
    var isDeleteAllLocationsCalled: Bool = false
    var deleteAllLocationsResult: Bool = true
    
    func getLocations() async -> [SydneyLocations.Location] {    
        isGetLocationsCalled = true
        return getLocationsResponse
    }
    
    func getLocation(byId id: UUID) async -> [SydneyLocations.Location] {
        isGetLocationByIdCalled = true
        return getLocationByIdResponse
    }
    
    func create(location: SydneyLocations.Location) async {
        isCreateLocation = true
    }
    
    func createLocation(id: UUID, name: String, latitude: Double, longitude: Double, descriptionText: String) async {
        isCreateLocationWithDataCalled = true
    }
    
    func update(location: SydneyLocations.Location) async {
        isUpdateLocationCalled = true
    }
    
    func updateLocation(id: UUID, name: String, latitude: Double, longitude: Double, descriptionText: String) async {
        isUpdateLocationCalledWithData = true
    }
    
    func deleteLocation(byId id: UUID) async {
        isDeleteLocationByIdCalled = true
    }
    
    func deleteAllLocations() async -> Bool? {
        isDeleteAllLocationsCalled = true
        return deleteAllLocationsResult
    }
}
