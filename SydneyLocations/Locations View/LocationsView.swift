import SwiftUI

struct LocationsView<ViewModel: LocationsViewModelProtocol>: View {

    @StateObject var viewModel: ViewModel

    var body: some View {
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
        .navigationBarTitle("Sydney Locations List")
        .font(.system(size: 17, weight: .semibold))
        .toolbarRole(.editor)
    }
}
