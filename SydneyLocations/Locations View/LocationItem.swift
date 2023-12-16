import SwiftUI

struct LocationItem: ViewGeneratable {
    let id = UUID()
    let name: String
    let onTap: () -> Void
    
    // MARK: - ViewGeneratable
    
    func view() -> AnyView {
        LocationView(item: self).anyView()
    }
}
