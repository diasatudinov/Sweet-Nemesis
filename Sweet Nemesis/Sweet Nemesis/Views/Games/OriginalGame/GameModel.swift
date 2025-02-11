//
//  GameModel.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//


import SwiftUI
import AVFoundation

enum CellState {
    case empty, blocked
}

class GameModel: ObservableObject {
    let rows = 7
    let cols = 11
    let initialBlockedCells = 15
    
    @Published var board: [[CellState]]
    @Published var catPosition: (col: Int, row: Int)

    @Published var gameOver: Bool = false
    @Published var gameWon: Bool = false
    
    
    
    init() {
        board = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        catPosition = (col: cols / 2, row: rows / 2)
        resetGame()
    }
    
    func resetGame() {
        board = Array(repeating: Array(repeating: .empty, count: cols), count: rows)
        catPosition = (col: cols / 2, row: rows / 2)
        gameOver = false
        gameWon = false
        
        var blockedCount = 0
        while blockedCount < initialBlockedCells {
            let randomRow = Int.random(in: 0..<rows)
            let randomCol = Int.random(in: 0..<cols)
            // Не блокируем клетку, где находится смайлик
            if randomRow == catPosition.row && randomCol == catPosition.col {
                continue
            }
            if board[randomRow][randomCol] == .empty {
                board[randomRow][randomCol] = .blocked
                blockedCount += 1
            }
        }
    }
    
  
    func tapCell(at col: Int, row: Int) {
        guard !gameOver else { return }
        if board[row][col] == .blocked { return }
        // Игрок не может закрашивать клетку, где находится смайлик.
        if catPosition.col == col && catPosition.row == row { return }
        board[row][col] = .blocked
        moveCat()
    
    }
    
    
    
    func moveCat() {
        if isEdge(col: catPosition.col, row: catPosition.row) {
            gameOver = true
            gameWon = false
            return
        }
        let movesWithDir = availableMovesWithDirections(from: catPosition)
        if movesWithDir.isEmpty {
            gameOver = true
            gameWon = true
            
            UserCoins.shared.updateUserCoins(for: 10)
            
            return
        }
        for move in movesWithDir {
            if isEdge(col: move.position.col, row: move.position.row) {
                catPosition = move.position
                gameOver = true
                gameWon = false
                return
            }
        }
        
        var bestMove: (col: Int, row: Int)? = nil
        var bestDistance = Int.max
        var fallback: [(col: Int, row: Int)] = []
        for move in movesWithDir {
            let distance = getDistance(from: move.position, direction: move.direction)
            if distance == -1 {
                fallback.append(move.position)
            } else if distance < bestDistance {
                bestDistance = distance
                bestMove = move.position
            }
        }
        if bestMove == nil, let randomFallback = fallback.randomElement() {
            bestMove = randomFallback
        }
        if let move = bestMove {
            catPosition = move
        }
        if isEdge(col: catPosition.col, row: catPosition.row) {
            gameOver = true
            gameWon = false
        }
    }

    func neighborOffsets(forRow row: Int) -> [(dx: Int, dy: Int)] {
        if row % 2 == 0 {
            // Чётный ряд: соседние клетки смещаются так:
            //  ←, ↖, ↗, →, ↘, ↙
            return [(-1, 0), (-1, -1), (0, -1), (1, 0), (0, 1), (-1, 1)]
        } else {
            // Нечётный ряд: смещения немного другие
            return [(-1, 0), (0, -1), (1, -1), (1, 0), (1, 1), (0, 1)]
        }
    }
    

    func availableMovesWithDirections(from pos: (col: Int, row: Int)) -> [(position: (col: Int, row: Int), direction: Int)] {
        var moves: [(position: (col: Int, row: Int), direction: Int)] = []
        let offsets = neighborOffsets(forRow: pos.row)
        for (index, offset) in offsets.enumerated() {
            let newPos = (col: pos.col + offset.dx, row: pos.row + offset.dy)
            if isValid(col: newPos.col, row: newPos.row) && board[newPos.row][newPos.col] == .empty {
                moves.append((position: newPos, direction: index))
            }
        }
        return moves
    }
    
    func isValid(col: Int, row: Int) -> Bool {
        return col >= 0 && col < cols && row >= 0 && row < rows
    }
    
    func isEdge(col: Int, row: Int) -> Bool {
        return col == 0 || col == cols - 1 || row == 0 || row == rows - 1
    }
    
    func neighbor(from pos: (col: Int, row: Int), direction: Int) -> (col: Int, row: Int) {
        let offsets = neighborOffsets(forRow: pos.row)
        let offset = offsets[direction]
        return (col: pos.col + offset.dx, row: pos.row + offset.dy)
    }
    
    func getDistance(from pos: (col: Int, row: Int), direction: Int) -> Int {
        if !isValid(col: pos.col, row: pos.row) {
            return 0
        }
        if board[pos.row][pos.col] == .blocked {
            return -1
        }
        if isEdge(col: pos.col, row: pos.row) {
            return 1
        }
        let nextPos = neighbor(from: pos, direction: direction)
        let distance = getDistance(from: nextPos, direction: direction)
        if distance == -1 {
            return -1
        }
        return distance + 1
    }
}
