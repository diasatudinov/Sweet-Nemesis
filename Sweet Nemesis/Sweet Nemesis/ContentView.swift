//
//  ContentView.swift
//  Sweet Nemesis
//
//  Created by Dias Atudinov on 09.02.2025.
//

import SwiftUI


struct ContentView: View {
    @State private var progress: CGFloat = 0.0
        
        var body: some View {
            VStack(spacing: 30) {
                GeometryReader { geometry in
                    Image("exampleImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        
                }
                .frame(height: 300)
                
                Slider(value: $progress, in: 0...1)
                    .padding(.horizontal, 40)
                
                Text("Progress: \(String(format: "%.2f", progress))")
                    .font(.headline)
            }
            .padding()
        }
    }

#Preview {
    ContentView()
}
