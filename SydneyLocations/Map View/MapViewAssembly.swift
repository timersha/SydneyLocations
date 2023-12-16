import Foundation
import SwiftUI

enum MapViewAssembly {
    static func build() -> some View {
        let region = MapItemsFactory.makeRegion(
            place: .Sydney,
            latMeters: 650.0,
            lonMeters: 650.0
        )
        let viewModel = MapViewModel(region: region)
        let view = MapView(viewModel: viewModel)
        return view
    }
}
