//
//  TextBg.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 11.02.2025.
//


import SwiftUI

struct TextWithBg: View {
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom(Fonts.regular.rawValue, size: textSize))
                .foregroundStyle(.mainYellow)
                .textCase(.uppercase)
                .padding(.vertical)
                .frame(width: DeviceInfo.shared.deviceType == .pad ? 500:248)
                .background(
                    Color.mainRed
                )
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.mainYellow, lineWidth: DeviceInfo.shared.deviceType == .pad ? 2:1)
                )
        }
    }
}

#Preview {
    TextWithBg(text: "Select", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32)
}
