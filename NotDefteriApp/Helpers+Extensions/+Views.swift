//
//  +Views.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 28.02.2025.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignment : Alignment) -> some View{
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(_ alignment : Alignment) -> some View{
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    
    func isSameDate(_ date1 :Date, _ date2 : Date) -> Bool{
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
    //Kullanıcı ekrana dokunduğunda klavyeyi kapatır.
    func hideKeyboardWhenTappedAround() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
   
  
}
