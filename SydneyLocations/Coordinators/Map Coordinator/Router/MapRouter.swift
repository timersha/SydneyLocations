import SwiftUI

protocol MapRouterable {
    var rootView: AnyView { get }
    
    func showLocationsList()
    func showLocationDetails(model: LocationInfo, delegate: LocationInfoViewModelDelegate?)
    func showAddLocation(delegate: AddLocationDelegate?)
    func dismissFullCover()
    func dismissSheet()
}

struct MapRouter<
    Content: View,
    State: MapRouterStatable,
    Factory: ViewsBaseFactoryProtocol
>: View {
    
    var rootView: AnyView {
        self.anyView()
    }
    
    @ObservedObject var state: State
    let factory: Factory.Type
    var content: Content
    
    var body: some View {
        NavigationStack(path: $state.path) { // .animation(.linear(duration: 0))
            content
                .sheet(
                    item: $state.presentedItem,
                    content: factory.makeSheet
                )
                .fullScreenCover(
                    item: $state.fullCoverItem,
                    content: factory.makeFullCover
                )
                .navigationDestination(
                    for: BaseContentLink.self,
                    destination: factory.makeContent
                )
        }
    }
}

// MARK: - MapRouterable

extension MapRouter: MapRouterable {
    func showLocationsList() {
        state.path.append(
            BaseContentLink.locationsList
        )
    }
    
    func showLocationDetails(model: LocationInfo, delegate: LocationInfoViewModelDelegate?) {
        state.presentedItem = BaseSheetLink.locationInfo(model, delegate)
    }
    
    func showAddLocation(delegate: AddLocationDelegate?) {
        state.fullCoverItem = BaseFullCoverLink.addLocation(delegate)
    }
    
    func dismissFullCover() {
        state.fullCoverItem = nil
    }
    
    func dismissSheet() {
        state.presentedItem = nil
    }
}
