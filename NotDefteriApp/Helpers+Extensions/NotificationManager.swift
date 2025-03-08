import Foundation
import FirebaseAuth
import UserNotifications
import FirebaseFirestore

class NotificationManager {
    static let shared = NotificationManager()
    private let db = Firestore.firestore()
    
    private init() {}
    
    var userId: String {
        Auth.auth().currentUser?.uid ?? ""
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
        }
    }
    
    func scheduleNotifications() {
        
        fetchTasks { tasks in
            
            self.clearAllNotifications {

                for task in tasks {
                    self.scheduleNotification(for: task)
                }
            }
        }
    }

    
    private func fetchTasks(completion: @escaping ([Task]) -> Void) {
        
        guard !userId.isEmpty else {
               print("Hata: Kullanıcı oturumu açık değil.")
               completion([])
               return
           }
        
        
        db.collection("users").document(userId).collection("todos").getDocuments { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("Error fetching tasks: \(error?.localizedDescription ?? "Unknown error")")
                completion([])
                return
            }
            
            let tasks: [Task] = documents.compactMap { document in
                try? document.data(as: Task.self)
            }
            
            completion(tasks)
        }
    }
    
    private func clearAllNotifications(completion: @escaping () -> Void) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        completion()
    }
    
    private func scheduleNotification(for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.body = task.detail ?? ""
        content.sound = .default
        
        let triggerDate = Date(timeIntervalSince1970: task.dueDate)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: task.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Bildirim başarıyla planlandı: \(task.title)")
            }
        }
    }
}

