import SwiftUI

struct LocationsView<ViewModel: LocationsViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.displayItems, id: \.hashValue) { item in
                    item.view()
//                        .listRowBackground(Color.white)
                        .listRowSeparator(.hidden)
                        .onAppear {
                            viewModel.onLocationAppear(model: item)
                        }
                }
            }
            .background(Color.white)
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Sydney Locations List")
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
                viewModel.onCloseTap()
            } label: {
                Image(systemName: "xmark")
            }
        }
    }
}
