import CoreData
import Foundation

private extension String {
    static let entityName = "SydneyLocation"

    static let id = "id"
    static let descriptionText = "descriptionText"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let name = "name"
}

extension CoreDataService {
    
    private func makeLocations(sLocations: [SydneyLocation]) -> [Location] {
        let locations: [Location] = sLocations.compactMap {
            guard let name = $0.name, let id = $0.id else {
                return nil
            }
            return Location(
                id: id,
                name: name,
                latitude: $0.latitude,
                longitude: $0.longitude,
                descriptionText: $0.descriptionText
            )
        }
        return locations
    }
    
    // MARK: - GET
    
    func getLocations() async -> [Location] {
        
        let context = newTaskContext(
            name: "GetLocations",
            author: "\(#function)"
        )
        
        let sydneyLocations: [SydneyLocation] = await context.perform {
            let fetchRequest = NSFetchRequest<SydneyLocation>(entityName: .entityName)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: .name, ascending: true)]
            return (try? context.fetch(fetchRequest)) ?? []
        }
        
        let locations: [Location] = makeLocations(sLocations: sydneyLocations)
        
        return locations
    }
    
    func getLocation(byId id: UUID) async -> [Location] {
        
        let context = newTaskContext(
            name: "GetLocationById",
            author: "\(#function)"
        )
        
        let sydneyLocations: [SydneyLocation] = await context.perform {
            let fetchRequest = NSFetchRequest<SydneyLocation>(entityName: .entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            return (try? context.fetch(fetchRequest)) ?? []
        }
        
        let locations: [Location] = makeLocations(sLocations: sydneyLocations)
        
        return locations
    }
    
    // MARK: - CREATE
    
    func create(location: Location) async {
        await createLocation(
            id: location.id ?? UUID(),
            name: location.name,
            latitude: location.latitude,
            longitude: location.longitude,
            descriptionText: location.descriptionText ?? ""
        )
    }
    
    func createLocation(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        descriptionText: String
    ) async {
        
        let context = newTaskContext(
            name: "CreateLocation",
            author: "\(#function)"
        )
        
        await context.perform {
            let sLocation = NSEntityDescription.insertNewObject(
                forEntityName: .entityName,
                into: context
            )
            sLocation.setValue(id, forKey: .id)
            sLocation.setValue(name, forKey: .name)
            sLocation.setValue(latitude, forKey: .latitude)
            sLocation.setValue(longitude, forKey: .longitude)
            sLocation.setValue(descriptionText, forKey: .descriptionText)
            try? context.save()
        }
    }
    
    // MARK: - UPDATE
    
    func update(location: Location) async {
        guard let id = location.id else { return }
        await updateLocation(
            id: id,
            name: location.name,
            latitude: location.latitude,
            longitude: location.longitude,
            descriptionText: location.descriptionText ?? ""
        )
    }
    
    func updateLocation(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        descriptionText: String
    ) async {
        
        let context = newTaskContext(
            name: "UpdateLocation",
            author: "\(#function)"
        )
        
        await context.perform {
            let fetchRequest = NSFetchRequest<SydneyLocation>(entityName: .entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            let sydneyLocations: [SydneyLocation] = (try? context.fetch(fetchRequest)) ?? []
            
            guard let model = sydneyLocations.first else { return }
            
            model.setValue(name, forKey: .name)
            model.setValue(latitude, forKey: .latitude)
            model.setValue(longitude, forKey: .longitude)
            model.setValue(descriptionText, forKey: .descriptionText)
            try? context.save()
        }
    }
    
    // MARK: - DELETE
    
    func deleteLocation(byId id: UUID) async {
        
        let context = newTaskContext(
            name: "DeleteWalletNetById",
            author: "\(#function)"
        )
        
        await context.perform {
            let fetchRequest = NSFetchRequest<SydneyLocation>(entityName: .entityName)
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            let result: [SydneyLocation]? = try? context.fetch(fetchRequest)
            result?.forEach {
                debugPrint("sLocation \(String(describing: $0.name))")
            }
            result?.forEach(context.delete)
            try? context.save()
        }
    }
    
    @discardableResult
    func deleteAllLocations() async -> Bool? {
        
        let context = newTaskContext(
            name: "DeleteAllLocations",
            author: "\(#function)"
        )
        
        let result = await context.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: .entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeStatusOnly
            let result = try? context.execute(batchDeleteRequest)
            try? context.save()
            let success = (result as? NSBatchDeleteResult)?.result as? Bool
            return success
        }
        return result
    }
}
