import SwiftUI

struct LocationInfoItemView: View {
    let model: LocationInfoItem
    
    var body: some View {
        Text(model.text)
            .lineLimit(.zero)
            .font(.system(size: 17))
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .onTapGesture {
                model.onTap()
            }
    }
}
