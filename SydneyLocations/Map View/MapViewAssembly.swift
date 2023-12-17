import Foundation
import SwiftUI

enum MapViewAssembly {
    static func build(delegate: MapViewModelDelegate?) -> some View {
        let region = MapItemsFactory.makeRegion(place: .Sydney)
        let viewModel = MapViewModel(
            region: region,
            delegate: delegate
        )
        let view = MapView(viewModel: viewModel)
        return view
    }
}
