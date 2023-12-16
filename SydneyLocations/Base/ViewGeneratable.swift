import SwiftUI

protocol ViewGeneratable: Equatable, Hashable, Identifiable {
    var id: UUID { get }
    @ViewBuilder
    func view() -> AnyView
}

extension ViewGeneratable {

    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Equatable
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
