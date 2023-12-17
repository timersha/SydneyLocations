import Foundation

protocol LocationInfoViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get set }
    
    func onLocationAppear(model: any ViewGeneratable)
    func onCloseTap()
}

protocol LocationInfoViewModelDelegate: AnyObject {
    func onCloseTap()
}

protocol LocationInfoItemDelegate {
    func didTapOn(item: LocationInfo, type: LocationInfoItemType)
}

final class LocationInfoViewModel {
    @Published var displayItems = [any ViewGeneratable]()
    private let model: LocationInfo
    private let factory: LocationInfoItemsFactoryProtocol.Type
    weak var delegate: LocationInfoViewModelDelegate?
    
    init(
        model: LocationInfo,
        delegate: LocationInfoViewModelDelegate? = nil,
        factory: LocationInfoItemsFactoryProtocol.Type = LocationInfoItemsFactory.self
    ) {
        self.model = model
        self.delegate = delegate
        self.factory = factory
        makeItems()
    }
    
    private func makeItems() {
        let items = factory.makeInofItems(model: model, delegate: self)
        displayItems = items
    }
}

// MARK: - LocationInfoViewModelProtocol

extension LocationInfoViewModel: LocationInfoViewModelProtocol {
    func onLocationAppear(model: any ViewGeneratable) {
        debugPrint("onLocationAppear \(model)")
    }
    
    func onCloseTap() {
        delegate?.onCloseTap()
    }
}

// MARK: - LocationInfoItemDelegate

extension LocationInfoViewModel: LocationInfoItemDelegate {
    func didTapOn(item: LocationInfo, type: LocationInfoItemType) {
        debugPrint("didTapOn: \(item)")
    }
}
