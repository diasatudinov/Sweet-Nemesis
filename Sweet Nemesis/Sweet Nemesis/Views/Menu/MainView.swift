import SwiftUI

struct MainView: View {
    @State private var showGames = false
    @State private var showInfo = false
    @State private var showSettings = false
    
    @StateObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Spacer()
                
                if geometry.size.width < geometry.size.height {
                    // Вертикальная ориентация
                    ZStack {
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                
                                Image(.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                
                                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15) {
                                    
                                    Button {
                                        showGames = true
                                    } label: {
                                        TextBg(text: "Games", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                    }
                                    
                                    Button {
                                        showInfo = true
                                    } label: {
                                        TextBg(text: "Info", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                    }
                                    
                                    Button {
                                        showSettings = true
                                    } label: {
                                        TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                    }
                                    
                                    
                                }
                                VStack {
                                    Image(.lady1Position)
                                        .resizable()
                                        .scaledToFit()
                                }
                            }
                            Spacer()
                        }
                    }.ignoresSafeArea(edges: .bottom)
                } else {
                    ZStack {
                        HStack {
                            VStack {
                                Spacer()
                                Image(.lady1Position)
                                    .resizable()
                                    .scaledToFit()
                            }.ignoresSafeArea(edges: [.horizontal, .bottom])
                        VStack {
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15) {
                                Image(.logo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                
                                Button {
                                    showGames = true
                                } label: {
                                    TextBg(text: "Games", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                }
                                
                                
                                Button {
                                    showInfo = true
                                } label: {
                                    TextBg(text: "Info", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                }
                                
                                
                                
                                Button {
                                    showSettings = true
                                } label: {
                                    TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                }
                                
//                                if DeviceInfo.shared.deviceType == .pad {
//                                    Spacer()
//                                }
                            }
                            
                        }
                            VStack {
                                Spacer()
                                Image(.lady1Position)
                                    .resizable()
                                    .scaledToFit()
                                    .opacity(0)
                            }
                        }
                        
                    }
                }
            }
            .background(
                Image(.bg)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
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
            .fullScreenCover(isPresented: $showGames) {
                GamesView(settingsVM: settingsVM)
            }
            .fullScreenCover(isPresented: $showInfo) {
                InfoView()
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