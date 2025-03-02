//
//  TodoListItemViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 2.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TodoListItemViewModel : ObservableObject {
    init(){}
    
    func toggleIsDone(Todo : Task) {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Kullanıcı ID bulunamadı")
            return
        }
        
        let db = Firestore.firestore()
        let taskRef = db.collection("users")
            .document(userId)
            .collection("todos")
            .document(Todo.id)
        
        taskRef.updateData([
            "isDone": !Todo.isDone
        ]) { error in
            if let error = error {
                print("Güncelleme hatası: \(error.localizedDescription)")
            } else {
                print("Görev başarıyla güncellendi")
            }
        }
    }
    
}
