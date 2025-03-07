//
//  ForgotPasswordViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 8.03.2025.
//

import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var errorMessage = ""
    
    init(){}
    
    
    func sendPasswordResetEmail() {
        guard validate() else {
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
            if let error = error {
                // Firebase hata kodlarını kontrol et
                self?.handleResetPasswordError(error: error)
            } else {
                // Başarı mesajı göster
                self?.errorMessage = "Şifre sıfırlama e-postası gönderildi. Lütfen e-postanızı kontrol edin."
            }
        }
    }
    
    /// Kullanıcıdan alınan e-posta adresinin doğruluğunu kontrol eder
    private func validate() -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedEmail.isEmpty else {
            errorMessage = "E-posta alanı boş bırakılamaz."
            return false
        }
        
        guard trimmedEmail.contains("@") && trimmedEmail.contains(".") else {
            errorMessage = "Lütfen geçerli bir e-posta adresi girin."
            return false
        }
        
        return true
    }
    
    /// Firebase hata mesajlarını işler ve kullanıcıya uygun bir hata mesajı gösterir
    private func handleResetPasswordError(error: Error) {
        let errorCode = (error as NSError).code
        
        switch errorCode {
        case AuthErrorCode.invalidEmail.rawValue:
            errorMessage = "Geçersiz e-posta adresi. Lütfen doğru bir e-posta girin."
        case AuthErrorCode.userNotFound.rawValue:
            errorMessage = "Bu e-posta adresi ile kayıtlı bir hesap bulunamadı."
        default:
            errorMessage = "Şifre sıfırlama işlemi sırasında bir hata oluştu. Lütfen tekrar deneyin."
        }
    }
    
    
}

