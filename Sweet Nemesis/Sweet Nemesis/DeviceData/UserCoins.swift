import SwiftUI

class UserCoins: ObservableObject {
    static let shared = UserCoins()
    
    @AppStorage("coins") var storedCoins: Int = 100
    @Published var coins: Int = 100
    
    @AppStorage("experience") var storedXP: Int = 0
    @Published var xp: Int = 0
    
    @AppStorage("level") var storedLevel: Int = 1
    @Published var level: Int = 1
    init() {
        coins = storedCoins
        xp = storedXP
        level = storedLevel
    }
    
    func updateUserCoins(for coins: Int) {
        self.coins += coins
        storedCoins = self.coins
    }
    
    func minusUserCoins(for coins: Int) {
        self.coins -= coins
        if self.coins < 0 {
            self.coins = 0
        }
        storedCoins = self.coins
        
    }
    
    func updateUserXP() {
        self.xp += 66
        
        if self.xp > 99 {
            level += 1
            storedLevel = level
            self.xp = 0
        }
        storedXP = self.xp
    }
    
}