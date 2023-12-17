import Foundation

protocol LocationsViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get }
    
    func onLocationAppear(model: any ViewGeneratable)
}
