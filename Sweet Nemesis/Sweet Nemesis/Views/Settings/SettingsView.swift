

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
                        
                        Image(.settingsBg)
                            .resizable()
                            .scaledToFit()
                        
                        VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 24:6) {
                            
                            Text("Settings")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 80:40))
                                .textCase(.uppercase)
                                .foregroundStyle(.white)
                            
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 16:4)  {
                                
                                Text("Music")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64:32))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.white)
                                
                                    Button {
                                        withAnimation {
                                            settings.musicEnabled.toggle()
                                        }
                                    } label: {
                                        if settings.musicEnabled {
                                            Image(.onSN)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 104:52)
                                        } else {
                                            Image(.offSN)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 104:52)
                                        }
                                    }
                                
                            }
                            
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 16:4)  {
                                
                                Text("Vibration")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 64 :32))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.white)
                                
                                
                                    Button {
                                        withAnimation {
                                            settings.soundEnabled.toggle()
                                        }
                                    } label: {
                                        if settings.soundEnabled {
                                            Image(.onSN)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 104:52)
                                        } else {
                                            Image(.offSN)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 104:52)
                                        }
                                    }
                                    
                            }
                            Button {
                                rateUs()
                            } label: {
                                ZStack {
                                    Image(.rateUsBg)
                                        .resizable()
                                        .scaledToFit()
                                    Text("Rate us")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                        .foregroundStyle(.white)
                                        .textCase(.uppercase)
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 88:44)
                                    
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
                
                VStack {
                    ZStack {
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                ZStack {
                                    Image(.backSN)
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
                Image(.bgSN)
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
