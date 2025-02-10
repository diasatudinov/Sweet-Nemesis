import SwiftUI

struct CellView: View {
    var state: CellState
    var hasCat: Bool
    var body: some View {
        ZStack {
            if state == .blocked {
                Image(.obstacle1)
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
                Image(.sweet1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
            }
        }
    }
}