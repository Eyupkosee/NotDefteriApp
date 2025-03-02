//
//  TodoViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 2.03.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class TodoViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading :Bool = false
    @Published var errorMessage: String = ""
    @Published var addingNewTask :Bool = false
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
    var userId: String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        // Kullanıcı giriş yapmamışsa, işlemi sonlandır
        guard !userId.isEmpty else {
            errorMessage = "Kullanıcı giriş yapmamış"
            return
        }
        
        isLoading = true
        
        // Belirttiğiniz yapıya uygun şekilde sorgulamayı düzenledim
        db.collection("users")
            .document(userId)
            .collection("todos")
            .order(by: "createDate", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = "Görevler yüklenirken hata oluştu: \(error.localizedDescription)"
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    self.errorMessage = "Dökümanlar bulunamadı"
                    return
                }
                
                self.tasks = documents.compactMap { document -> Task? in
                    do {
                        // FirebaseFirestoreSwift'in FirestoreDecodable protokolünü kullanarak dönüştürme
                        let task = try document.data(as: Task.self)
                        return task
                    } catch {
                        print("Doküman dönüştürme hatası: \(error)")
                        return nil
                    }
                }
            }
    }

    
}

