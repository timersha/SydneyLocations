import Foundation

protocol AddLocationInfoViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get set }
    var isSaveDisabled: Bool { get set }
    
    func onSaveTap()
}
