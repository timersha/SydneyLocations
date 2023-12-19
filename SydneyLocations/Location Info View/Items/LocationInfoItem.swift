import SwiftUI

struct LocationInfoItem: ViewGeneratable {
    let id = UUID()
    let text: String
    let onTap: () -> Void
    
    // MARK: - ViewGeneratable
    
    func view() -> AnyView {
        LocationInfoItemView(model: self).anyView()
    }
    
    @ViewBuilder
    func view(proxy: ScrollViewProxy) -> AnyView {
        LocationInfoItemView(model: self).anyView()
    }
}
