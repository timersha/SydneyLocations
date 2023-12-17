import SwiftUI

struct AddLocationInfoView<ViewModel: AddLocationInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var focusedWord: Bool
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.displayItems, id: \.hashValue) { item in
                        item.view()
                            .listRowSeparator(.hidden)
                            .focused($focusedWord)
//                            .onChange(of: item.text) { _ in
//                                proxy.scrollTo(3, anchor: .bottom)
//                            }
//                            .id(3)
                    }
                }
                .scrollDismissesKeyboard(.immediately)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("New location information")
                .font(.system(size: 17, weight: .semibold))
                .toolbar {
                    makeToolBar()
                }
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
            }
        }
    }
}
