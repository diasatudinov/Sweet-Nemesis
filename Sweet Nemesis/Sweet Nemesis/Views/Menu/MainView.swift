//
//  MainView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 11.02.2025.
//


import SwiftUI

struct MainView: View {
    @State private var showCatch = false
    @State private var showEscape = false
    @State private var showInfo = false
    @State private var showShop = false
    @State private var showSettings = false
    
    @StateObject var settingsVM = SettingsViewModel()
    @StateObject var shopVM = ShopViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    ZStack {
                        
                            VStack {
                                HStack {
                                    Button {
                                        showSettings = true
                                    } label: {
                                        ZStack {
                                            Image(.settingsIconSN)
                                                .resizable()
                                                .scaledToFit()
                                            
                                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                                    }
                                    Spacer()
                                    
                                    CoinsBg()
                                }.padding()
                                
                                
                                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15) {
                                    
                                    Button {
                                        showCatch = true
                                    } label: {
                                        TextWithBg(text: "Catch", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "catchIconSN")
                                    }
                                    
                                    Button {
                                        showEscape = true
                                    } label: {
                                        TextWithBg(text: "Escape", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "escapeIconSN")
                                    }
                                    
                                    Button {
                                        showInfo = true
                                    } label: {
                                        TextWithBg(text: "Info", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "infoIconSN")
                                    }
                                    
                                    Button {
                                        showShop = true
                                    } label: {
                                        TextWithBg(text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "shopIconSN")
                                    }
                                    
                                    
                                }
                                Spacer()
                            }
                        
                    }.ignoresSafeArea(edges: .bottom)
                } else {
                    ZStack {
                        
                        VStack {
                            HStack {
                                Button {
                                    showSettings = true
                                } label: {
                                    ZStack {
                                        Image(.settingsIconSN)
                                            .resizable()
                                            .scaledToFit()
                                        
                                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                                }
                                Spacer()
                                
                                CoinsBg()
                            }
                            
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                                
                                HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                                    Button {
                                        showCatch = true
                                    } label: {
                                        TextWithBg(text: "Catch", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "catchIconSN")
                                    }
                                    
                                    
                                    Button {
                                        showEscape = true
                                    } label: {
                                        TextWithBg(text: "Escape", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "escapeIconSN")
                                    }
                                    
                                }
                                
                                HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                                    Button {
                                        showInfo = true
                                    } label: {
                                        TextWithBg(text: "Info", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "catchIconSN")
                                    }
                                    
                                    Button {
                                        showShop = true
                                    } label: {
                                        TextWithBg(text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24, image: "shopIconSN")
                                    }
                                }
                              
                            }
                            Spacer()
                        }
                            
                        
                        
                    }
                }
            }
            .background(
                Image(.bgSN)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 4)
                
            )
            .onAppear {
                if settingsVM.musicEnabled {
                    SongsManager.shared.playBackgroundMusic()
                }
            }
            .onChange(of: settingsVM.musicEnabled) { enabled in
                if enabled {
                    SongsManager.shared.playBackgroundMusic()
                } else {
                    SongsManager.shared.stopBackgroundMusic()
                }
            }
            .fullScreenCover(isPresented: $showCatch) {
                OriginalGameView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showEscape) {
                ReversedGame(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showInfo) {
                InfoView()
            }
            .fullScreenCover(isPresented: $showShop) {
                ShopView(shopVM: shopVM)
            }
            .fullScreenCover(isPresented: $showSettings) {
                SettingsView(settings: settingsVM)
            }
            
        }
    }
}

#Preview {
    MainView()
}
