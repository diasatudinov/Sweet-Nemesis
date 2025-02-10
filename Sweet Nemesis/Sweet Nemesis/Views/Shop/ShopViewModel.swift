import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var shopItems: [Item] = [
        Item(name: "Creators of beauty", design: "type1", price: 0),
        Item(name: "Musical heaven", design: "type2", price: 100),
        Item(name: "World classic", design: "type3", price: 200),

    ]
    
    @Published var boughtItems: [String] = ["Creators of beauty"] {
        didSet {
            saveItems()
        }
    }
    
    
    @Published var currentItem: Item? {
        didSet {
            saveTeam()
        }
    }
    
    init() {
        loadTeam()
        loadItems()
    }
    
    private let userDefaultsTeamKey = "boughtItem"
    private let userDefaultsItemsKey = "boughtItemArray"
    
    func saveTeam() {
        if let currentItem = currentItem {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsTeamKey)
            }
        }
    }
    
    func loadTeam() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTeamKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentItem = loadedItem
        } else {
            currentItem = shopItems[0]
            print("No saved data found")
        }
    }
    
    func saveItems() {
        
        if let encodedData = try? JSONEncoder().encode(boughtItems) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsItemsKey)
        }
        
    }
    
    func loadItems() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsItemsKey),
           let loadedItem = try? JSONDecoder().decode([String].self, from: savedData) {
            boughtItems = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
}

struct Item: Codable, Hashable {
    var id = UUID()
    var name: String
    var design: String
    var price: Int
}