import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack(spacing: 0)  {
                    Spacer()
                    ZStack {
                        HStack(spacing: 0) {
                            
                            VStack {
                                Spacer()
                                Image(.lady1Position)
                                    .resizable()
                                    .scaledToFit()
                            }.ignoresSafeArea(edges: [.horizontal, .bottom])
                            
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15) {
                                
                                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15)  {
                                    
                                    Text("Music")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                    HStack(spacing:DeviceInfo.shared.deviceType == .pad ? 40: 20) {
                                        Text("Off")
                                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.yellow)
                                        Button {
                                            withAnimation {
                                                settings.musicEnabled.toggle()
                                            }
                                        } label: {
                                            if settings.musicEnabled {
                                                Image(.onLLG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                            } else {
                                                Image(.offLLG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                            }
                                        }
                                        
                                        Text("On")
                                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.yellow)
                                    }
                                    
                                }
                                
                                VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15)  {
                                    
                                    Text("Vibration")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64 :32))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                    
                                    HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
                                        Text("Off")
                                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.yellow)
                                        Button {
                                            withAnimation {
                                                settings.soundEnabled.toggle()
                                            }
                                        } label: {
                                            if settings.soundEnabled {
                                                Image(.onLLG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                            } else {
                                                Image(.offLLG)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                            }
                                        }
                                        
                                        Text("on")
                                            .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                            .textCase(.uppercase)
                                            .foregroundStyle(.yellow)
                                    }
                                }
                                Button {
                                    rateUs()
                                } label: {
                                    
                                    Text("RATE US")
                                        .font(.custom(Fonts.regular.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                        .padding(.vertical, DeviceInfo.shared.deviceType == .pad ? 16:8)
                                        .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 80:40)
                                        .background(
                                            Color.loaderBg
                                        )
                                        .cornerRadius(20)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.yellow, lineWidth: 1)
                                        )
                                }
                                
                            }.padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
                                .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 40:20)
                                .frame(width: DeviceInfo.shared.deviceType == .pad ?600:300)
                                .background(
                                    Color.mainRed
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.yellow, lineWidth: 1)
                                )
                            VStack {
                                Spacer()
                                Image(.lady1Position)
                                    .resizable()
                                    .scaledToFit()
                            }.ignoresSafeArea(edges: [.horizontal, .bottom]).opacity(0)
                        }.frame(height: geometry.size.height * 0.87)
                        
                    }
                    
                }
                
                VStack {
                    ZStack {
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                ZStack {
                                    Image(.backLLG)
                                        .resizable()
                                        .scaledToFit()
                                    
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                                
                            }
                            Spacer()
                        }.padding([.leading, .top])
                    }
                    Spacer()
                }
                
            }.background(
                Image(.bg)
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
            )
        }
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView(settings: SettingsViewModel())
}
