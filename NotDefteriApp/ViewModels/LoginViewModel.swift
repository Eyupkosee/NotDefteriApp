//
//  LoginViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import Foundation
import FirebaseAuth

class  LoginViewModel: ObservableObject{
    
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    
    init() {
        
    }
    
    func login(){
        guard validate() else{
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                // Hata varsa, Firebase'den gelen hatayı göster
                self?.handleLoginError(error: error)
            } else {
                // Başarılı giriş işlemi (başka işlemler ekleyebilirsin)
                self?.errorMessage = "" // Hata mesajını sıfırla
            }
        }
    }
    
    private func validate() -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        let trimmedPassword = password.trimmingCharacters(in: .whitespaces)
        
        
        
        // Email formatı kontrolü
        guard trimmedEmail.contains("@") && trimmedEmail.contains(".") else {
            errorMessage = "Lütfen geçerli bir e-posta adresi girin."
            return false
        }
        
        // Şifre uzunluğu kontrolü
        guard trimmedPassword.count >= 6 else {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }
        
        return true
    }
    
    
    private func handleLoginError(error: Error) {
            // Firebase'den gelen hata kodunu kontrol et
            let errorCode = (error as NSError).code
            switch errorCode {
            case AuthErrorCode.wrongPassword.rawValue:
                errorMessage = "Hatalı şifre, lütfen tekrar deneyin."
            case AuthErrorCode.invalidEmail.rawValue:
                errorMessage = "Geçersiz e-posta adresi, lütfen kontrol edin."
            case AuthErrorCode.userNotFound.rawValue:
                errorMessage = "Kullanıcı bulunamadı, kaydolmayı deneyin."
            default:
                errorMessage = "Giriş yapılırken bir hata oluştu. Lütfen tekrar deneyin."
            }
        }
    
    
}
