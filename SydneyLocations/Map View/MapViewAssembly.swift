import Foundation
import SwiftUI

enum MapViewAssembly {
    static func build() -> some View {
        let region = MapItemsFactory.makeRegion(place: .Sydney)
        let viewModel = MapViewModel(region: region)
        let view = MapView(viewModel: viewModel)
        return view
    }
}
