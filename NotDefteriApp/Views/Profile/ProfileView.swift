//
//  ProfileView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    var body: some View {
        Button {
            do {
                try Auth.auth().signOut()
                // Oturum kapatma işlemi başarılı oldu
            } catch let error {
                // Hata durumunda burası çalışacak
                print("Oturum kapatma hatası: \(error.localizedDescription)")
            }
            
        } label: {
            Text("Çık")
        }
    }
}

#Preview {
    ProfileView()
}
