//
//  CoinsBg.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//


import SwiftUI

struct CoinsBg: View {
    @StateObject var user = UserCoins.shared
    var body: some View {
        ZStack {
            Image(.coinsBgSN)
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 102:51)
                .padding(DeviceInfo.shared.deviceType == .pad ? 10:5)
            HStack {
                Spacer()
                Text("\(user.coins)")
                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                    .foregroundStyle(.yellow)
            }.padding(.trailing, DeviceInfo.shared.deviceType == .pad ? 52:26)
        }.frame(width: DeviceInfo.shared.deviceType == .pad ? 240:117)
    }
}

#Preview {
    CoinsBg()
}
