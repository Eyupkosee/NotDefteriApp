//
//  Task.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import Foundation
import SwiftUI

struct Task: Codable, Identifiable {
    let id: String
    let title: String
    let detail: String?
    let imageData: Data?
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    var category: TaskCategory
    var tint: String
    
    
    mutating func setDone(_ state: Bool){
        isDone = state
    }
    
    var image: UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
    
    
    
    var tintColor: Color{
        switch tint {
        case "taskColor1": return .taskColor1
        case "taskColor2": return .taskColor2
        case "taskColor3": return .taskColor3
        case "taskColor4": return .taskColor4
        case "taskColor5": return .taskColor5
        default:
            return .gray
        }
    }
    
    init(id: String, title: String, detail:String, image: UIImage?, dueDate: TimeInterval ,createDate: TimeInterval, isDone: Bool, tint: String, category: TaskCategory) {
        self.id = id
        self.title = title
        self.detail = detail
        self.imageData = image?.jpegData(compressionQuality: 0.7)
        self.dueDate = dueDate
        self.createDate = createDate
        self.isDone = isDone
        self.tint = tint
        self.category = category
    }
    
}



enum TaskCategory: String, Codable, CaseIterable, Identifiable {
    case iş = "İş"
    case alışveriş = "Alışveriş"
    case okul = "Okul"
    case kişisel = "Kişisel"
    case sağlık = "Sağlık"
    case diğer = "Diğer"
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .iş: return "briefcase"
        case .alışveriş: return "cart"
        case .okul: return "book"
        case .kişisel: return "person"
        case .sağlık: return "heart"
        case .diğer: return "ellipsis.circle"
        }
    }
}
