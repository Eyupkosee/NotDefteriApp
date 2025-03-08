//
//  ProfileViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 6.03.2025.
//

import Foundation
import SwiftUI

class ProfileViewModel : ObservableObject {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    
    func toggleDarkMode() {
        isDarkMode.toggle()
    }
}


