import SwiftUI

enum BaseContentLink: Hashable, Identifiable {
    
    case map(MapViewModelDelegate?)
    case locationsList(LocationsViewItemsDelegate?)
    
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
