//
//  TaskViewModel.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isLoading :Bool = false
    @Published var errorMessage: String = ""
    @Published var addingNewTask :Bool = false
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage().reference()
    
//    init() {
//           fetchTasks()
//       }
//    func fetchTasks() {
//            isLoading = true
//            
//            db.collection("tasks")
//                .order(by: "createDate", descending: true)
//                .addSnapshotListener { [weak self] snapshot, error in
//                    guard let self = self else { return }
//                    
//                    self.isLoading = false
//                    
//                    if let error = error {
//                        self.errorMessage = "Görevler yüklenirken hata oluştu: \(error.localizedDescription)"
//                        return
//                    }
//                    
//                    guard let documents = snapshot?.documents else {
//                        self.errorMessage = "Dökümanlar bulunamadı"
//                        return
//                    }
//                    
//                    self.tasks = documents.compactMap { document -> Task? in
//                        do {
//                            let taskData = try document.data(as: TaskDTO.self)
//                            return self.convertDTOToTask(taskData)
//                        } catch {
//                            print("Doküman dönüştürme hatası: \(error)")
//                            return nil
//                        }
//                    }
//                }
//        }
    
}
