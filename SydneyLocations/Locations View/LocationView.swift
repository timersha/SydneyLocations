import SwiftUI

struct LocationView: View {
    let item: LocationItem
    var body: some View {
        Text(item.name)
            .font(.system(size: 17))
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 4)
            .onTapGesture {
                item.onTap()
            }
    }
}
