import SwiftUI
import MapKit

struct AddLocationView<ViewModel: AddLocationViewProtocol>: View {
    @StateObject var viewModel: ViewModel
    @State var region: MKCoordinateRegion
    var body: some View {
        NavigationView {
            Map(
                coordinateRegion: $region,
                interactionModes: viewModel.interactionModes,
                showsUserLocation: viewModel.showsUserLocation
            )
            .overlay(alignment: .center) {
                Image(systemName: "mappin")
                    .resizable()
                    .frame(width: 15, height: 40)
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.red, .white)
                    .shadow(color: .black.opacity(0.7), radius: 3)
            }
            .onChange(of: region) { region in
                debugPrint("new location: \(region.center.latitude) \(region.center.longitude)")
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Add Locations")
            .font(.system(size: 17, weight: .semibold))
            .toolbar {
                makeToolBar()
            }
        }
    }

    @ToolbarContentBuilder
    private func makeToolBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.addLocation()
            } label: {
                Text("Add")
                    .font(.system(size: 14, weight: .semibold))
            }
        }
    }
}
