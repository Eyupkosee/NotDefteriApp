//
//  ForgotPasswordView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 8.03.2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
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
                
                Text("Şifremi Unuttum")
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
                            .background(Color("textViewColor"))
                            .cornerRadius(8)
                    }
                    
                    // Email alanı
                    TextField("Email Adresi", text: $viewModel.email)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Kayıt butonu
                    Button {
                        viewModel.sendPasswordResetEmail()
                    } label: {
                        Text("Devam Et")
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
                        Text("Geri Dön")
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
    ForgotPasswordView()
}
