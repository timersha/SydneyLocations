import MapKit
import SwiftUI

struct MapView<ViewModel: MapViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            Map(
                coordinateRegion: $viewModel.region,
                interactionModes: viewModel.interactionModes,
                showsUserLocation: viewModel.showsUserLocation,
                annotationItems: [viewModel.place]
            ) { place in
                MapAnnotation(
                    coordinate: .init(latitude: place.latitude, longitude: place.longitude),
                    anchorPoint: CGPoint(x: 0.1, y: 0.1)
                ) {
                    Text(Image(systemName: "mappin.circle.fill"))
                        .foregroundColor(.red)
                        .font(.system(size: 30, weight: .regular))
                        .onTapGesture {
                            viewModel.didTapAnnotation()
                        }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Sydney Locations")
            .font(.system(size: 17, weight: .semibold))
            .toolbar {
                makeToolBar()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func makeToolBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                viewModel.addLocation()
            } label: {
                Image(systemName: "plus")
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.showList()
            } label: {
                Image(systemName: "list.bullet")
            }
        }
    }
}

