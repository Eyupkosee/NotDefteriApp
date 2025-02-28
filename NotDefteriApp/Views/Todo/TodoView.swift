//
//  TodoView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI
import FirebaseAuth

struct TodoView: View {
    
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan
                BackgroundTheme()
                
                VStack {
                    
                    Text("Notlarım")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .italic()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: AddTodoView()) {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.medium)
                                .padding(10)
                                .foregroundColor(.cyan)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        
    }
}

#Preview {
    TodoView()
}
