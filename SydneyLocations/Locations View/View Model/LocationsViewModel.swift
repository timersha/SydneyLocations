import Foundation

final class LocationsViewModel {
    @Published var displayItems = [any ViewGeneratable]()
    private let factory: LocationsItemsFactoryProtocol.Type
    private let fileService: FileServiceProtocol.Type
    private let parser: Parsable.Type
    weak var delegate: LocationsViewItemsDelegate?
    
    
    init(
        delegate: LocationsViewItemsDelegate? = nil,
        fileService: FileServiceProtocol.Type = FileService.self,
        factory: LocationsItemsFactoryProtocol.Type = LocationsItemsFactory.self,
        parser: Parsable.Type = ParserService.self
    ) {
        self.delegate = delegate
        self.fileService = fileService
        self.factory = factory
        self.parser = parser
        readPlaces()
    }
    
    private func readPlaces() {
        guard let locationsData: Data = fileService.defaultLocationsData(),
              let locations = parser.parse(data: locationsData, to: Locations.self),
              let itemLocations: [Location] = locations.locations else {
            return
        }
        
        let mapLocations = factory.makeLocationItems(models: itemLocations, delegate: self)
        displayItems = mapLocations
    }
}

// MARK: - LocationsViewModelProtocol

extension LocationsViewModel: LocationsViewModelProtocol {
    func onLocationAppear(model: any ViewGeneratable) {
        debugPrint("onLocationAppear \(model)")
    }
}

// MARK: - LocationsViewItemsDelegate

extension LocationsViewModel: LocationsViewItemsDelegate {
    func didTapItem(model: Location) {
        delegate?.didTapItem(model: model)
    }
}
