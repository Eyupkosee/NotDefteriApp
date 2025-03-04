//
//  AddTodoViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 28.02.2025.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class AddTodoViewModel : ObservableObject {
    
    @Published var title: String = ""
    @Published var detail: String = ""
    @Published var imageData : Data?
    @Published var category : TaskCategory = .iş
    @Published var tint : String = "taskColor1"
    @Published var dueDate = Date()
    
   

    
    init() {}

    func save() {
        guard canSave else { return }
        guard let uId = Auth.auth().currentUser?.uid else { return }
        
        let newId = UUID().uuidString
        
        // Resim varsa Firebase'e yükleyelim
        if let imageData = imageData {
            uploadImageToFirebase(imageData: imageData) { imageUrl in
                // imageData'yı UIImage'a dönüştürme işlemi
                let newItem = Task(id: newId, title: self.title, detail: self.detail, image: UIImage(data: imageData), dueDate: self.dueDate.timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: false, tint: self.tint, category: self.category)
                
                
                
                // Firebase'e kaydetme işlemi
                let db = Firestore.firestore()
                
                db.collection("users")
                    .document(uId)
                    .collection("todos")
                    .document(newId)
                    .setData(newItem.asDictionary())
            }
        } else {
            // Resim yoksa, imageData'yı nil bırakıyoruz
            let newItem = Task(
                id: newId,
                title: self.title,
                detail: self.detail,
                image: nil,  // Resim yoksa image nil
                dueDate: self.dueDate.timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: false,
                tint: self.tint,
                category: self.category
            )
            
            // Firebase'e kaydetme işlemi
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(uId)
                .collection("todos")
                .document(newId)
                .setData(newItem.asDictionary())
        }
    }

    
    var canSave: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        return true
    }
    
    
    func uploadImageToFirebase(imageData: Data, completion: @escaping (String?) -> Void) {
        let storageRef = Storage.storage().reference().child("todoImages/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(nil)
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        completion(nil)
                    } else {
                        completion(url?.absoluteString) // URL'yi Firestore'a kaydedeceğiz
                    }
                }
            }
        }
    }
    
   
}
