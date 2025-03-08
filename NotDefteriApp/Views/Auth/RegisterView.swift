//
//  RegisterView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            // Arka plan teması
            BackgroundTheme()
            
            // İçerik
            VStack {
                // Başlık
                Text("Not Defteri")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                
                Text("Hesap Oluştur")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                // Kayıt formu
                VStack(spacing: 20) {
                    // Ad Soyad alanı
                    
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(8)
                    }
                    
                    TextField("Ad ve Soyad", text: $viewModel.name)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Email alanı
                    TextField("Email", text: $viewModel.email)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    // Şifre alanı
                    SecureField("Şifre", text: $viewModel.password)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Kayıt butonu
                    Button {
                        viewModel.register()
                    } label: {
                        Text("Hesap Oluştur")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.top, 10)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // Geri dönme butonu
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Giriş Sayfasına Dön")
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                }
            }
            .hideKeyboardWhenTappedAround()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    RegisterView()
}
