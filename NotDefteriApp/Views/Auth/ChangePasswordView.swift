//
//  ChangePasswordView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 7.03.2025.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject var viewModel = ChangePasswordViewModel()
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
                
                Text("Şifreyi Sıfırla")
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
                    
                    // eski şifre Şifre alanı
                    SecureField("Mevcut Şifre", text: $viewModel.oldPassword)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // yeni Şifre alanı
                    SecureField("Yeni Şifre", text: $viewModel.newPassword)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // yeni Şifre onay alanı
                    SecureField("Yeni Şifre Onayla", text: $viewModel.newPasswordConfirm)
                        .padding()
                        .background(Color("textViewColor"))
                        .cornerRadius(8)
                        .foregroundColor(.black)
                    
                    // Kayıt butonu
                    Button {
                        viewModel.changePassword()
                    } label: {
                        Text("ŞİFREYİ GÜNCELLE")
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
                        Text("Profil Sayfasına Dön")
                    }
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
        .hideKeyboardWhenTappedAround()
    }
}

#Preview {
    ChangePasswordView()
}
