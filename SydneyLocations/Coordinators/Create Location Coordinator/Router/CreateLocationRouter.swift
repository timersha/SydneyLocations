import SwiftUI

protocol CreateLocationRouterable {
    var rootView: AnyView { get }
    
    func showAddLocationInfo(delegate: AddLocationInfoDelegate?)
    func showSelectLocation(delegate: SelectLocationDelegate?)
    func dismissFullCover()
    func dismissSheet()
}

struct CreateLocationRouter<
    Content: View,
    State: CreateLocationRouterStatable,
    Factory: ViewsBaseFactoryProtocol
>: View {
    @ObservedObject var state: State
    let factory: Factory.Type
    var content: Content
    var rootView: AnyView {
        self.anyView()
    }
    
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

// MARK: - CreateLocationRouterable

extension CreateLocationRouter: CreateLocationRouterable {
    func showAddLocationInfo(delegate: AddLocationInfoDelegate?) {
        state.path.append(
            BaseContentLink.addLocationInfo(delegate)
        )
    }
    
    func showSelectLocation(delegate: SelectLocationDelegate?) {
        state.fullCoverItem = BaseFullCoverLink.selectLocation(delegate)
    }
    
    func dismissFullCover() {
        state.fullCoverItem = nil
    }
    
    func dismissSheet() {
        state.presentedItem = nil
    }
}
