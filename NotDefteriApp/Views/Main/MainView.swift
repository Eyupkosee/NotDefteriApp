//
//  MainView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        NavigationView {
            if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                TabView{
                   // TodoView(userId: viewModel.currentUserId)
                    TodoView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                            
                        }
                    ProfileView()
                        .tabItem {
                            Label("Profile", systemImage: "person.circle")
                        }
                }
            }else{
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
