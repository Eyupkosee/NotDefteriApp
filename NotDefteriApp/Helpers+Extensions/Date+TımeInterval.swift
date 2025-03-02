//
//  Date+TımeInterval.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 2.03.2025.
//

import Foundation

extension Date {
    func formatDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
    
    func formatMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: self)
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

// Tarihi TimeInterval'dan kolayca çevirip formatlayabilmek için ek bir extension
extension TimeInterval {
    func formatAsDay() -> String {
        return Date(timeIntervalSince1970: self).formatDay()
    }
    
    func formatAsMonth() -> String {
        return Date(timeIntervalSince1970: self).formatMonth()
    }
    
    func formatAsTime() -> String {
        return Date(timeIntervalSince1970: self).formatTime()
    }
}
