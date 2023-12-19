import SwiftUI

struct LocationInfoView<ViewModel: LocationInfoViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    @FocusState var focusedWord: Bool
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(viewModel.displayItems, id: \.hashValue) { item in
                        item.view(proxy: proxy)
                            .listRowSeparator(.hidden)
                            .focused($focusedWord)
                            .onAppear {
                                viewModel.onLocationAppear(model: item)
                            }
                    }
                }
                .background(Color.white)
                .listStyle(.plain)
                .scrollDismissesKeyboard(.interactively)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitle("Location information")
                .font(.system(size: 17, weight: .semibold))
                .toolbar {
                    makeToolBar()
                }
            }
        }
    }
    
    @ToolbarContentBuilder
    private func makeToolBar() -> some ToolbarContent {
        if !viewModel.isEditEnabled {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.onSaveTap()
                } label: {
                    Text("Save")
                        .disabled(viewModel.isSaveDisabled)
                }
            }
        }
        
        if viewModel.isEditEnabled {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.isEditEnabled = false
                    viewModel.onEditTap()
                } label: {
                    Text("Edit")
                }
            }
        }
    }
}
