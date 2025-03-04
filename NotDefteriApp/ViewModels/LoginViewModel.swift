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
            
        Auth.auth().signIn(withEmail: email, password: password)
        
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
    
    
}
