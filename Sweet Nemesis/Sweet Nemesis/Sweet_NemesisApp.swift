//
//  Sweet_NemesisApp.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 09.02.2025.
//

import SwiftUI

@main
struct Sweet_NemesisApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            FirstView()
        }
    }
}
