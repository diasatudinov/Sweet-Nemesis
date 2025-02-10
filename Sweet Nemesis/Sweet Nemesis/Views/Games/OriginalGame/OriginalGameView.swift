//
//  OriginalGameView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//

import SwiftUI

struct OriginalGameView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var game = GameModel()
    @State private var pauseShow: Bool = false

    var body: some View {
        ZStack {
            ZStack {
                Image(.boardBg)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 550, height: 352)
                VStack(spacing: 4) {
                    ForEach(0..<game.rows, id: \.self) { row in
                        HStack(spacing: 4) {
                            if row % 2 != 0 {
                                Spacer().frame(width: 20)
                            }
                            ForEach(0..<game.cols, id: \.self) { col in
                                CellView(state: game.board[row][col],
                                         hasCat: (game.catPosition.row == row && game.catPosition.col == col))
                                .onTapGesture {
                                    game.tapCell(at: col, row: row)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            
            VStack {
                HStack {
                    Button {
                        pauseShow = true
                    } label: {
                        ZStack {
                            Image(.pauseSN)
                                .resizable()
                                .scaledToFit()
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                    
                    CoinsBg()
                    
                }.padding([.leading, .top])
                
                Spacer()
            }
            
            if pauseShow {
                ZStack {
                    Color.black
                        .opacity(0.5).ignoresSafeArea()
                    VStack {
                        Image(.pauseText)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                GameTextBg(text: "Menu", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                            }
                            
                            Button {
                                pauseShow = false
                            } label: {
                                GameTextBg(text: "Resume", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                            }
                        }
                    }
                }
            }
            
            
            if game.gameOver {
                ZStack {
                    Color.black
                        .opacity(0.5).ignoresSafeArea()
                    if game.gameWon {
                        VStack {
                            Image(.winText)
                                .resizable()
                                .scaledToFit()
                            Button {
                                game.resetGame()
                            } label: {
                                GameTextBg(text: "Next", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                            }
                        }
                    } else {
                        VStack {
                            Image(.loseTextSN)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                            
                            HStack {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    GameTextBg(text: "Menu", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                                }
                                
                                Button {
                                    game.resetGame()
                                } label: {
                                    GameTextBg(text: "Retry", textSize: 32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                                }
                            }
                        }
                    }
                }
            }
            
        }.background(
            Image(.bgSN)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 4)
            
        )
    }
}

#Preview {
    OriginalGameView()
}

struct TextWithBorder: View {
    let text: String
    let font: Font
    let textColor: Color
    let borderColor: Color
    let borderWidth: CGFloat

    var body: some View {
        ZStack {
            Text(text)
                .font(font)
                .foregroundColor(textColor)
                .glowBorder(color: borderColor, lineWidth: 5)
            
            
        }
    }
}

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int
    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }
    
    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        self.modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
