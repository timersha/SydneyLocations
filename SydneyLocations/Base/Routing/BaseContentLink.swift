import SwiftUI

enum BaseContentLink: Hashable, Identifiable {
    
    case map
    
    var id: String {
        String(describing: self)
    }
    
    static func == (lhs: BaseContentLink, rhs: BaseContentLink) -> Bool {
        rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
