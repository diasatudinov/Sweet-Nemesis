//
//  ContentView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 09.02.2025.
//

import SwiftUI


struct ContentView: View {
    @StateObject var game = CatEscapeGameModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 4) {
                ForEach(0..<game.rows, id: \.self) { row in
                    HStack(spacing: 4) {
                        if row % 2 != 0 {
                            Spacer().frame(width: 20)
                        }
                        ForEach(0..<game.cols, id: \.self) { col in
                            let cellPos = (col: col, row: row)
                            // Определяем, является ли клетка допустимым ходом для кота.
                            let allowed = game.allowedMoves(from: game.catPosition).contains { $0 == cellPos }
                            CellView2(state: game.board[row][col],
                                     hasCat: (game.catPosition.row == row && game.catPosition.col == col),
                                     isAllowed: allowed)
                            .onTapGesture {
                                game.moveCat(to: cellPos)
                            }
                        }
                    }
                }
            }
            .padding()
            
        }
    }
}

#Preview {
    ContentView()
}
