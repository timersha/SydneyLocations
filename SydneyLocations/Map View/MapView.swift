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
                annotationItems: viewModel.places
            ) { place in
                MapAnnotation(
                    coordinate: place.coordinate,
                    anchorPoint: CGPoint(x: 0.1, y: 0.1)
                ) {
                    Image(systemName: "mappin.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .red)
                        .shadow(color: .black.opacity(0.7), radius: 3)
                        .onTapGesture {
                            viewModel.didTapAnnotation(place: place)
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
                viewModel.createLocation()
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

