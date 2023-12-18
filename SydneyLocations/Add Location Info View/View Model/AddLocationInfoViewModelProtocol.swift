import Foundation

protocol AddLocationInfoViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get set }
    
    func onSaveTap()
}
