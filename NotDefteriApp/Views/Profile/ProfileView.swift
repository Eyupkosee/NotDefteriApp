//
//  ProfileView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 3.03.2025.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var viewModel: ProfileViewModel 
    @State private var showLogoutAlert = false
    
    
    var body: some View {
        ZStack {
            // Arka plan
            BackgroundTheme()
            
            // İçerik
            VStack(spacing: 20) {
                
                Text("Not Defteri")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("textViewColor"))
                    .italic()
                    .padding(.top, 10)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Button(action: {
                    }) {
                        Text("Bana Mail Yaz")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 36)
                            .padding()
                            .background(Color("textViewColor"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    
                    NavigationLink(destination: ChangePasswordView()) {
                        Text("Şifre Değiştir")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 36)
                            .padding()
                            .background(Color("textViewColor"))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .buttonStyle(PlainButtonStyle()) 
                    
                    // Dark Mode Toggle
                    Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(height: 36)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("Çıkış Yap")
                            .font(.headline)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 36)
                            .padding()
                            .background(Color("textViewColor"))
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

