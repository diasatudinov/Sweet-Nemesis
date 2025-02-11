//
//  AppLinks.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 11.02.2025.
//



import SwiftUI

class AppLinks {
    
    static let shared = AppLinks()
    
    static let winStarData = "https://sweetnemesis.xyz/get"
    
    @AppStorage("finalUrl") var finalURL: URL?
    
    
}
