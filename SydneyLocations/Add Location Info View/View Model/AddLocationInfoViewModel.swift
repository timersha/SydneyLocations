import Combine
import SwiftUI

final class AddLocationInfoViewModel: AddLocationInfoItemDelegate {
    var name: String
    var description: String
    var namePublisher: AnyPublisher<String,Never>?
    var descriptionPublisher: AnyPublisher<String,Never>?
    
    @Published var displayItems = [any ViewGeneratable]()
    @Published var isSaveDisabled: Bool = false
    private let factory: AddLocationInfoItemFactoryProtocol.Type
    weak var delegate: AddLocationInfoDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    init(
        name: String = "",
        description: String = "",
        delegate: AddLocationInfoDelegate? = nil,
        factory: AddLocationInfoItemFactoryProtocol.Type = AddLocationInfoItemFactory.self
    ) {
        self.name = name
        self.description = description
        self.delegate = delegate
        self.factory = factory
        makeItems()
        bindInputs()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    private func makeItems() {
        let items = factory.makeItems(delegate: self)
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
                debugPrint("name: \(nameText)")
                debugPrint("description: \(descriptionText)")
                self?.name = nameText
                self?.description = descriptionText
                self?.isSaveDisabled = nameText.isEmpty || descriptionText.isEmpty
            }.store(in: &cancellables)
    }
}

// MARK: - AddLocationInfoViewModelProtocol

extension AddLocationInfoViewModel: AddLocationInfoViewModelProtocol {
    func onSaveTap() {
        guard !name.isEmpty, !description.isEmpty else {
            return
        }
        delegate?.onSaveTap(name: name, description: description)
    }
}
