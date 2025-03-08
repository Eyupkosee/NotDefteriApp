//
//  InfoCard.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 8.03.2025.
//

import SwiftUI

struct InfoCard: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Text(value)
                .font(.title)
                .bold()
                .foregroundColor(.mint)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .background(Color.black.opacity(0.2))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    InfoCard(title: "tamamlanan", value: "2")
}
