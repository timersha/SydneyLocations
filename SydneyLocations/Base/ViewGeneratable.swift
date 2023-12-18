import SwiftUI

protocol ViewGeneratable: Equatable, Hashable, Identifiable {
    var id: UUID { get }
    
    @ViewBuilder
    func view() -> AnyView
    
    @ViewBuilder
    func view(proxy: ScrollViewProxy) -> AnyView
}

extension ViewGeneratable {
    
    @ViewBuilder
    func view() -> AnyView {
        EmptyView().anyView()
    }
    
    @ViewBuilder
    func view(proxy: ScrollViewProxy) -> AnyView {
        EmptyView().anyView()
    }

    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Equatable
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
