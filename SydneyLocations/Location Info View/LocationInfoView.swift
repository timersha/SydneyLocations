import SwiftUI

struct LocationInfoView<ViewModel: LocationInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.displayItems, id: \.hashValue) { item in
                    item.view()
                        .listRowSeparator(.hidden)
                        .onAppear {
                            viewModel.onLocationAppear(model: item)
                        }
                }
            }
            .background(Color.white)
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Location information")
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
                viewModel.onCloseTap()
            } label: {
                Text("Close")
            }
        }
    }
}
