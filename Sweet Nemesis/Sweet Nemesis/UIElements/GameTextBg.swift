//
//  GameTextBg.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//

import SwiftUI

struct GameTextBg: View {
    var text: String
    var textSize: CGFloat
    var height: CGFloat
    var body: some View {
        ZStack {
            Image(.gameTextBg)
                .resizable()
                .scaledToFit()
            TextWithBorder(text: text, font: .custom(Fonts.bold.rawValue, size: textSize), textColor: .red, borderColor: .white, borderWidth: 1)
                .textCase(.uppercase)
            
//            Text(text)
//                .font(.custom(Fonts.bold.rawValue, size: textSize))
//                .foregroundStyle(.yellow)
//                .textCase(.uppercase)
//                .padding(.vertical)
                
                
        }.frame(height: height)
    }
}

#Preview {
    GameTextBg(text: "Menu", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
}
