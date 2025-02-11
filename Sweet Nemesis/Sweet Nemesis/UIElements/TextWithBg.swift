import SwiftUI

struct TextWithBg: View {
    var text: String
    var textSize: CGFloat
    var image: String
    var body: some View {
        ZStack {
            Image(.textBg)
                .resizable()
                .scaledToFit()
            VStack(spacing: 0) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                
                TextWithBorder(text: text, font: .custom(Fonts.bold.rawValue, size: textSize), textColor: .red, borderColor: .white, borderWidth: 2)
                    .textCase(.uppercase)
            }.padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 32: 16)
        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 200:120)
    }
}

#Preview {
    TextWithBg(text: "Select", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, image: "catchIconSN")
}
