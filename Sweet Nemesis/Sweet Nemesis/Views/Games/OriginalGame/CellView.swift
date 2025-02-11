//
//  CellView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//


import SwiftUI

struct CellView: View {
    @StateObject var shopVM = ShopViewModel()
    var state: CellState
    var hasCat: Bool
    var body: some View {
        ZStack {
            if state == .blocked {
                Image(shopVM.currentObstacle?.design ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 80:40, height: DeviceInfo.shared.deviceType == .pad ? 80:40)
            } else {
                Image(.emptyCell)
                    .resizable()
                    .scaledToFit()
                    .frame(width:DeviceInfo.shared.deviceType == .pad ? 80:40, height: DeviceInfo.shared.deviceType == .pad ? 80:40)
            }
            
            if hasCat {
                Image(shopVM.currentSweet?.design ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 80:40, height: DeviceInfo.shared.deviceType == .pad ? 80:40)
                
            }
        }
    }
}
