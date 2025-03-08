//
//  RegisterViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage = ""
    
    init(){
        
    }
    
    func register(){
        guard validate() else{
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                    guard let self = self else { return }
                    
                    if let error = error {
                        self.errorMessage = error.localizedDescription
                        return
                    }
                    
                    guard let userId = result?.user.uid else {
                        self.errorMessage = "Kullanıcı oluşturulurken bir hata oluştu."
                        return
                    }
                    
                    self.insertUserRecor(id: userId)
        }
    }
    
    
    private func insertUserRecor(id: String){
        let newUser = User(id: id, name: name, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
        
    }
    
    
    private func validate() -> Bool {
            let trimmedName = name.trimmingCharacters(in: .whitespaces)
            let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
            let trimmedPassword = password.trimmingCharacters(in: .whitespaces)
            
            // Boş alan kontrolü
            guard trimmedName.count >= 3 else {
                errorMessage = "Lütfen geçerli bir isim girin."
                return false
            }
            
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
