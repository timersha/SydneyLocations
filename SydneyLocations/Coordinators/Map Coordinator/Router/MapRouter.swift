import SwiftUI

protocol MapRouterable {
    var rootView: AnyView { get }

    func routePath() -> Binding<NavigationPath>
    func presentedItem() -> Binding<BaseSheetLink?>
    func fullCoverItem() -> Binding<BaseFullCoverLink?>
    func showLocationsList(delegate: LocationsViewItemsDelegate?)
    func showLocationDetails(model: LocationInfo, delegate: LocationInfoViewModelDelegate?)
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
    
    func routePath() -> Binding<NavigationPath> {
        $state.path
    }
    
    func presentedItem() -> Binding<BaseSheetLink?> {
        $state.presentedItem
    }
    
    func fullCoverItem() -> Binding<BaseFullCoverLink?> {
        $state.fullCoverItem
    }
    
    func showLocationsList(delegate: LocationsViewItemsDelegate?) {
        state.path.append(
            BaseContentLink.locationsList(delegate)
        )
    }
    
    func showLocationDetails(model: LocationInfo, delegate: LocationInfoViewModelDelegate?) {
        state.presentedItem = BaseSheetLink.locationInfo(model, delegate)
    }
    
    func dismissFullCover() {
        state.fullCoverItem = nil
    }
    
    func dismissSheet() {
        state.presentedItem = nil
    }
}
