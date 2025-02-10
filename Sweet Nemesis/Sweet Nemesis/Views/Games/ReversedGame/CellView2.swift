//
//  CellView2.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//


import SwiftUI

struct CellView2: View {
    @StateObject var shopVM = ShopViewModel()
    var state: CellState
    var hasCat: Bool
    var isAllowed: Bool
    
    var body: some View {
        ZStack {
            if state == .blocked {
                Image(shopVM.currentObstacle?.design ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else {
                Image(.emptyCell)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            }
            
            if hasCat {
                Image(shopVM.currentSweet?.design ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
            } else if isAllowed && state == .empty {
                // Выделяем допустимые для хода клетки (опционально)
                Circle()
                    .stroke(Color.green, lineWidth: 2)
                    .frame(width: 40, height: 40)
            }
        }
    }
}
