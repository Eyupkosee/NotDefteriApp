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
    
    @Published var searchText: String = ""
    @Published var selectedCategory: TaskCategory? = nil
    
    
    private let db = Firestore.firestore()
    
    var userId: String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    init() {
        fetchTasks()
    }
    
    func fetchTasks() {
        guard !userId.isEmpty else {
            errorMessage = "Kullanıcı giriş yapmamış"
            return
        }
        
        isLoading = true
        
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
                        return try document.data(as: Task.self)
                    } catch {
                        print("Döküman dönüştürme hatası: \(error)")
                        return nil
                    }
                }
            }
    }

        
        // Arama ve kategori filtresini uygulayan hesaplanmış özellik
        var filteredTasks: [Task] {
            tasks.filter { task in
                let matchesSearch = searchText.isEmpty || task.title.localizedCaseInsensitiveContains(searchText)
                let matchesCategory = selectedCategory == nil || task.category == selectedCategory
                return matchesSearch && matchesCategory
            }
        }
    
    
}

