//
//  ChangePasswordViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 7.03.2025.
//

import Foundation
import FirebaseAuth

class ChangePasswordViewModel: ObservableObject {
    @Published var oldPassword = ""
    @Published var newPassword = ""
    @Published var newPasswordConfirm = ""
    
    @Published var errorMessage = ""
    init(){}
    
    
    func changePassword() {
        guard validate() else {
            return
        }
        
        guard let user = Auth.auth().currentUser, let email = user.email else {
            errorMessage = "Kullanıcı bulunamadı."
            return
        }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: oldPassword)
        
        user.reauthenticate(with: credential) { [weak self] (result, error) in
            if let error = error {
                self?.errorMessage = "Kimlik doğrulama başarısız."

                return
            }
            
            user.updatePassword(to: self?.newPassword ?? "") { error in
                if let error = error {
                    self?.errorMessage = "Parola güncelleme başarısız."
                } else {
                    self?.errorMessage = "Parola başarıyla güncellendi."
                }
            }
        }
        
    }
        
        
        private func validate() -> Bool {
            let trimmedOldPassword = oldPassword.trimmingCharacters(in: .whitespaces)
            let trimmedNewPassword = newPassword.trimmingCharacters(in: .whitespaces)
            let trimmedNewPasswordConfirm = newPasswordConfirm.trimmingCharacters(in: .whitespaces)
            
            guard trimmedOldPassword.count >= 6 &&  trimmedNewPassword.count >= 6 && trimmedNewPasswordConfirm.count >= 6 else{
                errorMessage = "Şifre 6 haneden küçük olamaz."
                return false
            }
            
            guard trimmedNewPassword == trimmedNewPasswordConfirm else {
                errorMessage = "Yeni şifre ve şifre tekrarı aynı olmalıdır."
                return false
            }
            
            guard trimmedOldPassword != trimmedNewPassword else {
                errorMessage = "Yeni şifre eski şifreyle aynı olamaz."
                return false
            }
            
            return true
        }
        
    }
