import SwiftUI

enum BaseFullCoverLink: Hashable, Identifiable {
    
    case selectLocation(SelectLocationDelegate?)
    case custom(AnyView)

    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: BaseFullCoverLink, rhs: BaseFullCoverLink) -> Bool {
        rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
