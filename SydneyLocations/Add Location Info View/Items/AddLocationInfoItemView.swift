import SwiftUI

struct AddLocationInfoItemView: View {
    
    let model: AddLocationInfoItem
    
    var body: some View {
        TextField(
            model.placeholder,
            text: model.text,
            axis: .vertical
        )
        .font(.system(size: 17))
        .foregroundColor(.black)
    }
}
