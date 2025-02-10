//
//  InfoView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            VStack {
                Image(.infoBg)
                    .resizable()
                    .scaledToFit()
            }.padding()
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
                        
                    }.padding()
                }
                Spacer()
            }
        }.background(
            Image(.bgSN)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 4)
            
        )
    }
}

#Preview {
    InfoView()
}
