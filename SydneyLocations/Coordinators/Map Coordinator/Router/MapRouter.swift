import SwiftUI

protocol MapRouterable {
    var rootView: AnyView { get }
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
    let content: () -> Content
    
    var body: some View {
        NavigationStack(path: $state.path) {
            content()
                .sheet(
                    item: $state.presentedItem,
                    content: factory.makeSheet
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
    
}
