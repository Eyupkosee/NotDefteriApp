//
//  LoginView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
     
    var body: some View {
        ZStack {
            // Arka plan
            BackgroundTheme()
            
            // İçerik
            VStack {
                Spacer()
                
                // Logo veya Başlık
                Text("Not Defteri")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                // Login form
                VStack(spacing: 20) {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(8)
                    }
                    
                    // Email alanı
                    TextField("Email Adresi", text: $viewModel.email)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Password alanı
                    SecureField("Şifre", text: $viewModel.password)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Login button
                    Button {
                        viewModel.login()
                    } label: {
                        Text("Giriş Yap")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Hesap oluştur
                VStack(spacing: 10) {
                    Text("Hesabın yok mu?")
                        .foregroundColor(.white)
                    
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Hesap Oluştur")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LoginView()
}
