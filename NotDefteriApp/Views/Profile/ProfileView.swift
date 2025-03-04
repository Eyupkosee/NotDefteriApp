//
//  ProfileView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 3.03.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var showLogoutAlert = false
    
    
    var body: some View {
        ZStack {
            // Arka plan
            BackgroundTheme()
            
            // İçerik
            VStack(alignment: .leading, spacing: 20) {
                
                // Merhaba, currentUser.name yazan kısım
                Text("Merhaba, ")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Button(action: {
                    }) {
                        Text("Bana Mail Yaz")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    
                    Button(action: {
                        
                    }) {
                        Text("Şifre Değiştir")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("Çıkış Yap")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(title: Text("Çıkış Yap"), message: Text("Çıkış yapmak istediğinizden emin misiniz?"), primaryButton: .destructive(Text("Evet")) {
                            do {
                                try Auth.auth().signOut()
                            } catch let error {
                                print("Oturum kapatma hatası: \(error.localizedDescription)")
                            }
                        }, secondaryButton: .cancel())
                    }

                    
                    
                    
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}
#Preview {
    ProfileView()
}

