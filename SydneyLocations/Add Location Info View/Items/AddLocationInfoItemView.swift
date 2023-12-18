import SwiftUI

struct AddLocationInfoItemView: View {
    
    @StateObject var model: AddLocationInfoItem
    @State var proxy: ScrollViewProxy
    
    var body: some View {
        TextField(
            model.placeholder,
            text: $model.text,
            axis: .vertical
        )
        .font(.system(size: 17))
        .foregroundColor(.black)
        .onChange(of: model.text) { value in
            proxy.scrollTo(model.id, anchor: .bottom)
        }
        .id(model.id)
    }
}
