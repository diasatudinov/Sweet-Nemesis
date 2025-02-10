class CatEscapeGameModel: ObservableObject {
    let rows = 7
    let cols = 11
    let initialBlockedCells = 35
    
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
            if randomRow == catPosition.row && randomCol == catPosition.col {
                continue
            }
            if board[randomRow][randomCol] == .empty {
                board[randomRow][randomCol] = .blocked
                blockedCount += 1
            }
        }
    }
    
    
    func neighborOffsets(forRow row: Int) -> [(dx: Int, dy: Int)] {
        if row % 2 == 0 {
            return [(-1, 0), (-1, -1), (0, -1), (1, 0), (0, 1), (-1, 1)]
        } else {
            return [(-1, 0), (0, -1), (1, -1), (1, 0), (1, 1), (0, 1)]
        }
    }
    
    func allowedMoves(from pos: (col: Int, row: Int)) -> [(col: Int, row: Int)] {
        var moves: [(col: Int, row: Int)] = []
        let offsets = neighborOffsets(forRow: pos.row)
        for offset in offsets {
            let newPos = (col: pos.col + offset.dx, row: pos.row + offset.dy)
            if isValid(newPos) && board[newPos.row][newPos.col] == .empty {
                moves.append(newPos)
            }
        }
        return moves
    }
    
    func isValid(_ pos: (col: Int, row: Int)) -> Bool {
        return pos.col >= 0 && pos.col < cols && pos.row >= 0 && pos.row < rows
    }
    
    func isEdge(_ pos: (col: Int, row: Int)) -> Bool {
        return pos.col == 0 || pos.col == cols - 1 || pos.row == 0 || pos.row == rows - 1
    }
    
    func moveCat(to pos: (col: Int, row: Int)) {
        guard !gameOver else { return }
        let allowed = allowedMoves(from: catPosition)
        if allowed.contains(where: { $0 == pos }) {
            catPosition = pos
            
            if isEdge(catPosition) {
                gameOver = true
                gameWon = true
            }
            
            addRandomBlockedCell()
            
            if allowedMoves(from: catPosition).isEmpty {
                gameOver = true
                gameWon = false
            }
        }
    }
    
    func addRandomBlockedCell() {
            var emptyCells: [(col: Int, row: Int)] = []
            for r in 0..<rows {
                for c in 0..<cols {
                    if board[r][c] == .empty && !(r == catPosition.row && c == catPosition.col) {
                        emptyCells.append((col: c, row: r))
                    }
                }
            }
            if let pos = emptyCells.randomElement() {
                board[pos.row][pos.col] = .blocked
            }
        }
}