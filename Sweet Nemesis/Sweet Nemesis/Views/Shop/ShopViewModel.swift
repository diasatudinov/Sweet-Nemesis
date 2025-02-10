//
//  ShopViewModel.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 10.02.2025.
//


import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var sweets: [Item] = [
        Item(name: "candy", design: "sweet1", price: 0),
        Item(name: "Ice cream", design: "sweet2", price: 100),
        Item(name: "Chocolate", design: "sweet3", price: 200),

    ]
    
    @Published var obstacles: [Item] = [
        Item(name: "lemon", design: "obstacle1", price: 0),
        Item(name: "apple", design: "obstacle2", price: 100),
        Item(name: "watermelon ", design: "obstacle3", price: 200),

    ]
    
    @Published var boughtItems: [String] = ["candy", "lemon"] {
        didSet {
            saveItems()
        }
    }
    
    
    @Published var currentSweet: Item? {
        didSet {
            saveSweet()
        }
    }
    
    @Published var currentObstacle: Item? {
        didSet {
            saveObstacle()
        }
    }
    
    init() {
        loadObstacle()
        loadSweet()
        loadItems()
    }
    
    private let userDefaultsObstacleKey = "boughtObstacle"
    private let userDefaultsSweetKey = "boughtSweet"
    private let userDefaultsItemsKey = "boughtItemArray"
    
    func saveSweet() {
        if let currentItem = currentSweet {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsSweetKey)
            }
        }
    }
    
    func loadSweet() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsSweetKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentSweet = loadedItem
        } else {
            currentSweet = sweets[0]
            print("No saved data found")
        }
    }
    
    func saveObstacle() {
        if let currentItem = currentObstacle {
            if let encodedData = try? JSONEncoder().encode(currentItem) {
                UserDefaults.standard.set(encodedData, forKey: userDefaultsObstacleKey)
            }
        }
    }
    
    func loadObstacle() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsObstacleKey),
           let loadedItem = try? JSONDecoder().decode(Item.self, from: savedData) {
            currentObstacle = loadedItem
        } else {
            currentObstacle = obstacles[0]
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
