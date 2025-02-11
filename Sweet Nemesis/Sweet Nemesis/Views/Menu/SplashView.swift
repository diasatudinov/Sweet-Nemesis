//
//  SplashView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 11.02.2025.
//

import SwiftUI

struct SplashView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    ZStack {
                        VStack(spacing: 5) {
                            TextWithBorder(text: "Loading...", font: .custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ?  64:32), textColor: .red, borderColor: .white, borderWidth: 2)
                                .textCase(.uppercase)
                            HStack {
                                Spacer()
                                ZStack {
                                    Image(.loadingBgSN)
                                        .resizable()
                                        .scaledToFit()
                                    
                                    Image(.loader)
                                        .resizable()
                                        .scaledToFit()
                                        .mask(alignment: .leading) {
                                            Rectangle()
                                                .frame(width: (geometry.size.width * progress))
                                                .animation(.easeInOut, value: progress)
                                        }
                                    
                                }.frame(height: DeviceInfo.shared.deviceType == .pad ? 76:38)
                                Spacer()
                            }
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, DeviceInfo.shared.deviceType == .pad ? 50:25)
                }
            }.background(
                Image(.bgSN)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 4)
                
            )
            .onAppear {
                startTimer()
            }
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        progress = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.07, repeats: true) { timer in
            if progress < 1 {
                progress += DeviceInfo.shared.deviceType == .pad ? 0.005:0.003
            } else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    SplashView()
}
