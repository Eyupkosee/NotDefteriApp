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
    let dueDate: TimeInterval
    let createDate: TimeInterval
    var isDone: Bool
    var tint: String

    
    mutating func setDone(_ state: Bool){
        isDone = state
    }
    
    
    
    var tintColor: Color{
        switch tint {
        case "taskColor1": return .taskColor1
        case "taskColor2": return .taskColor2
        case "taskColor3": return .taskColor3
        case "taskColor4": return .taskColor4
        case "taskColor5": return .taskColor5
        case "taskColor6": return .taskColor6
        default:
            return .gray
        }
    }
    
}
