//
//  TodoDetailAndDeleteViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 4.03.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class TodoDetailAndDeleteViewModel: ObservableObject {
    @Published var title: String
    @Published var detail: String
    @Published var tint: String
    @Published var category: TaskCategory
    @Published var dueDate: Date
    @Published var imageData: Data?
    
    //    if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
    //        Image(uiImage: uiImage)
    //            .resizable()
    //            .scaledToFit()
    //    }
    
    private var taskId: String
    private var uId: String
    private var db: Firestore
    private var isDone : Bool
    
    init(todo: Task) {
        self.title = todo.title
        self.detail = todo.detail ?? ""
        self.tint = todo.tint
        self.category = todo.category
        self.dueDate = Date(timeIntervalSince1970: todo.dueDate) // Todo tarihini doğru formatta başlatın
        self.imageData = todo.imageData
        
        self.taskId = todo.id
        self.uId = Auth.auth().currentUser?.uid ?? ""
        self.db = Firestore.firestore()
        self.isDone = todo.isDone
    }
    
    
    
    func updateTodo() {
            guard canUpdate else { return }

            let updatedTask = Task(
                id: taskId,
                title: self.title,
                detail: self.detail,
                image: UIImage(data: self.imageData ?? Data()), // UIImage'a dönüştürme
                dueDate: self.dueDate.timeIntervalSince1970,
                createDate: Date().timeIntervalSince1970,
                isDone: self.isDone,
                tint: self.tint,
                category: self.category
            )
            
            // Firestore'da güncelleme işlemi
            db.collection("users")
                .document(uId)
                .collection("todos")
                .document(taskId)
                .setData(updatedTask.asDictionary(), merge: true) { error in
                    if let error = error {
                        print("Todo güncellenirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        print("Todo başarıyla güncellendi.")
                    }
                }
        }
        
        // Todo silme fonksiyonu
        func deleteTodo(completion: @escaping (Bool) -> Void) {
            db.collection("users")
                .document(uId)
                .collection("todos")
                .document(taskId)
                .delete { error in
                    if let error = error {
                        print("Todo silinirken hata oluştu: \(error.localizedDescription)")
                        completion(false)
                    } else {
                        print("Todo başarıyla silindi.")
                        completion(true)
                    }
                }
        }
    
    

    var canUpdate: Bool{
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        return true
    }
    
}

