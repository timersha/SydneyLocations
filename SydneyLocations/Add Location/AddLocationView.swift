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
            .ignoresSafeArea()
            .overlay(alignment: .center) {
                Image(systemName: "mappin")
                    .resizable()
                    .offset(y: -20)
                    .frame(width: 15, height: 40)
                    .symbolRenderingMode(.multicolor)
                    .foregroundStyle(.red, .white)
                    .shadow(color: .black.opacity(0.7), radius: 3)
            }
            .onChange(of: region) { region in
                viewModel.onRegionUpdate(region: region)
            }
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
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.red)
                    .cornerRadius(8)
            }
        }
        
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                viewModel.onCancelTap()
            } label: {
                Text("Cancel")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .semibold))
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(.red)
                    .cornerRadius(8)
            }
        }
    }
}
