import SwiftUI

struct AddLocationInfoView<ViewModel: AddLocationInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var focusedWord: Bool
    
    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(viewModel.displayItems, id: \.hashValue) { item in
                    item.view(proxy: proxy)
                        .listRowSeparator(.hidden)
                        .focused($focusedWord)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("New location information")
            .font(.system(size: 17, weight: .semibold))
            .toolbarRole(.editor)
            .toolbar {
                makeToolBar()
            }
            .overlay(alignment: .center) {
                ProgressView()
                    .opacity(viewModel.loaderOpactiy)
            }
        }
    }
    
    @ToolbarContentBuilder
    private func makeToolBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button {
                viewModel.onSaveTap()
            } label: {
                Text("Save")
            }.disabled(viewModel.isSaveDisabled)
        }
    }
}
