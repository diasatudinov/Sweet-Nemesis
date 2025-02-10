import SwiftUI

struct CoinsBg: View {
    @StateObject var user = UserCoins.shared
    @State var coins: String
    var body: some View {
        HStack(spacing: 4) {
            Image(.coinIcon)
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 60:30)
                .padding(DeviceInfo.shared.deviceType == .pad ? 10:5)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 1)
                )
            Text("\(user.coins)")
                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                .foregroundStyle(.yellow)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 12:6)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 1)
                )
        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 400:200)
    }
}

#Preview {
    CoinsBg(coins: "100")
}