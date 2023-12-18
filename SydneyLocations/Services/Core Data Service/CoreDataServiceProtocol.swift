import Foundation

protocol CoreDataServiceProtocol {
    
    // MARK: - GET
    
    func getLocations() async -> [Location]
    
    func getLocation(byId id: UUID) async -> [Location]
    
    // MARK: - CREATE
    
    @discardableResult
    func create(location: Location) async -> Bool?
    
    @discardableResult
    func createLocation(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        descriptionText: String
    ) async -> Bool?
    
    // MARK: - UPDATE
    
    func update(location: Location) async
    
    func updateLocation(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        descriptionText: String
    ) async
    
    // MARK: - DELETE
    
    func deleteLocation(byId id: UUID) async
    
    @discardableResult
    func deleteAllLocations() async -> Bool?
}
