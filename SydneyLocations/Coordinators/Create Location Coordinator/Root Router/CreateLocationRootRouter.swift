import SwiftUI

protocol CreateLocationRootRouterable {
    func presentRoot(view: AnyView, delegate: SelectLocationDelegate?)
    func dismissFullCover()
}

final class CreateLocationRootRouter<State: CreateLocationRootRouterStatble> {
    
    @Published var state: State
    
    init(state: State) {
        self.state = state
    }
}

// MARK: - CreateLocationRootRouterable

extension CreateLocationRootRouter: CreateLocationRootRouterable {
    func presentRoot(
        view: AnyView,
        delegate: SelectLocationDelegate?
    ) {
        state.fullCoverItem = BaseFullCoverLink.custom(view)
    }
    
    func dismissFullCover() {
        state.fullCoverItem = nil
    }
}

