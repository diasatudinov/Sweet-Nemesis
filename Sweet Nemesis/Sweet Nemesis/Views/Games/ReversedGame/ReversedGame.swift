//
//  ReversedGame.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//

import SwiftUI
import AVFoundation

struct ReversedGame: View {
    @State private var pauseShow: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @StateObject var game = CatEscapeGameModel()
    
    @ObservedObject var settingsVM: SettingsViewModel
    @State private var audioPlayer: AVAudioPlayer?
    var body: some View {
        ZStack {
            ZStack {
                Image(.boardBg)
                    .resizable()
                    .scaledToFit()
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 1100:550, height: DeviceInfo.shared.deviceType == .pad ? 704:352)
                VStack {
                    VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 8:4) {
                        ForEach(0..<game.rows, id: \.self) { row in
                            HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 8:4) {
                                if row % 2 != 0 {
                                    Spacer().frame(width: DeviceInfo.shared.deviceType == .pad ? 40:20)
                                }
                                ForEach(0..<game.cols, id: \.self) { col in
                                    let cellPos = (col: col, row: row)
                                    let allowed = game.allowedMoves(from: game.catPosition).contains { $0 == cellPos }
                                    CellView2(state: game.board[row][col],
                                              hasCat: (game.catPosition.row == row && game.catPosition.col == col),
                                              isAllowed: allowed)
                                    .onTapGesture {
                                        if settingsVM.soundEnabled {
                                            playSound(named: "popSN")
                                        }
                                        game.moveCat(to: cellPos)
                                        
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                    
                }
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
                                GameTextBg(text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                            }
                            
                            Button {
                                pauseShow = false
                            } label: {
                                GameTextBg(text: "Resume", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
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
                                GameTextBg(text: "Next", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
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
                                    GameTextBg(text: "Menu", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
                                }
                                
                                Button {
                                    game.resetGame()
                                } label: {
                                    GameTextBg(text: "Retry", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32, height: DeviceInfo.shared.deviceType == .pad ? 240:119)
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
    
    func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ReversedGame(settingsVM: SettingsViewModel())
}
