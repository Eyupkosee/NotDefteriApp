//
//  BackgroundTheme.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI


struct BackgroundTheme: View {
    var body: some View {
        ZStack {
            // Arka plan gradyanı
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "7FA1C3"),
                    Color(hex: "6482AD")
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Dekoratif yapraklar
            GeometryReader { geometry in
                ZStack {
                    // Sol üst dekoratif element
                    Circle()
                        .fill(Color(hex: "FFFBFA").opacity(0.3))
                        .frame(width: 200, height: 200)
                        .offset(x: -100, y: -100)
                    
                    // Sağ alt dekoratif element
                    Circle()
                        .fill(Color(hex: "FFFBFA").opacity(0.3))
                        .frame(width: 200, height: 200)
                        .offset(x: geometry.size.width - 100, y: geometry.size.height - 100)
                }
            }
        }
    }
}



#Preview {
    BackgroundTheme()
}
