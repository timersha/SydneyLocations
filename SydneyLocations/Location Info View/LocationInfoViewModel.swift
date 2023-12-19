import Combine
import Foundation

protocol LocationInfoViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get set }
    var isSaveDisabled: Bool { get }
    var isEditEnabled: Bool { get set }
    
    func onLocationAppear(model: any ViewGeneratable)
    func onSaveTap()
    func onEditTap()
}

protocol LocationInfoViewModelDelegate: AnyObject {
    func onSaveTap(
        locationInfo: LocationInfo,
        saveCompletion: @escaping () -> Void
    )
}

protocol LocationInfoItemDelegate {
    func didTapOn(item: LocationInfo, type: LocationInfoItemType)
}

final class LocationInfoViewModel {
    var name: String
    var description: String
    var namePublisher: AnyPublisher<String,Never>?
    var descriptionPublisher: AnyPublisher<String,Never>?
    
    @Published var displayItems = [any ViewGeneratable]()
    @Published var isSaveDisabled: Bool = false
    @Published var isEditEnabled: Bool = true
    private var model: LocationInfo
    private let factory: LocationInfoItemsFactoryProtocol.Type
    private let editFactory: AddLocationInfoItemFactoryProtocol.Type
    private var cancellables = Set<AnyCancellable>()
    weak var delegate: LocationInfoViewModelDelegate?
    
    init(
        model: LocationInfo,
        delegate: LocationInfoViewModelDelegate? = nil,
        factory: LocationInfoItemsFactoryProtocol.Type = LocationInfoItemsFactory.self,
        editFactory: AddLocationInfoItemFactoryProtocol.Type = AddLocationInfoItemFactory.self
    ) {
        self.name = model.name
        self.description = model.description
        self.model = model
        self.delegate = delegate
        self.factory = factory
        self.editFactory = editFactory
        makeItems()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func makeItems() {
        let items = factory.makeInofItems(model: model, delegate: self)
        displayItems = items
    }
    
    private func bindInputs() {
        guard let nPublisher = namePublisher,
              let dPublisher = descriptionPublisher else {
            return
        }
        Publishers
            .CombineLatest(dPublisher, nPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] descriptionText, nameText in
                self?.name = nameText
                self?.description = descriptionText
                self?.isSaveDisabled = nameText.isEmpty || descriptionText.isEmpty
            }.store(in: &cancellables)
    }
}

// MARK: - LocationInfoViewModelProtocol

extension LocationInfoViewModel: LocationInfoViewModelProtocol {
    func onLocationAppear(model: any ViewGeneratable) {}
    
    func onSaveTap() {
        let locationInfo = LocationInfo(
            id: model.id,
            name: name,
            latitude: model.latitude,
            longitude: model.longitude,
            description: description
        )
        model = locationInfo
        delegate?.onSaveTap(locationInfo: locationInfo) { [weak self] in
            guard let self = self else { return }
            debugPrint("Did Update LocationInfo: \(locationInfo)")
            Task {
                await MainActor.run {
                    self.isEditEnabled = true
                    self.makeItems()
                }
            }
        }
    }

    func onEditTap() {
        let items = editFactory.makeItems(delegate: self)
        displayItems = items
        bindInputs()
    }
}

// MARK: - LocationInfoItemDelegate

extension LocationInfoViewModel: LocationInfoItemDelegate {
    func didTapOn(item: LocationInfo, type: LocationInfoItemType) {
        debugPrint("didTapOn: \(item)")
    }
}

// MARK: - AddLocationInfoItemDelegate

extension LocationInfoViewModel: AddLocationInfoItemDelegate {}
