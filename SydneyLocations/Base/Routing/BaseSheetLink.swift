import SwiftUI

enum BaseSheetLink: Hashable, Identifiable {
    
    case locationInfo(LocationInfo,LocationInfoViewModelDelegate?)
    case locationsList(LocationsViewItemsDelegate?)
    
    var id: String {
        String(reflecting: self)
    }
    
    static func == (lhs: BaseSheetLink, rhs: BaseSheetLink) -> Bool {
        rhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
