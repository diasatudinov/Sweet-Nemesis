import SwiftUI

struct CellView2: View {
    var state: CellState
    var hasCat: Bool
    var isAllowed: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black, lineWidth: 1)
                .frame(width: 40, height: 40)
                .background(
                    Circle().fill(state == .blocked ? Color.gray : Color.white)
                )
            if hasCat {
                Text("😺")
                    .font(.system(size: 24))
            } else if isAllowed && state == .empty {
                // Выделяем допустимые для хода клетки (опционально)
                Circle()
                    .stroke(Color.green, lineWidth: 2)
                    .frame(width: 40, height: 40)
            }
        }
    }
}