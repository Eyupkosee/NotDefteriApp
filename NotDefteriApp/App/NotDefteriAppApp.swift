//
//  NotDefteriAppApp.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct NotDefteriAppApp: App {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    init(){
        FirebaseApp.configure()
        NotificationManager.shared.requestPermission()
        NotificationManager.shared.scheduleNotifications()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
                .preferredColorScheme(viewModel.isDarkMode ? .dark : .light)
        }
    }
}

