//
//  TodoListItemView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 2.03.2025.
//

import SwiftUI

struct TodoListItemView: View {
    @StateObject var viewModel : TodoListItemViewModel
    let todo : Task
    
    var body: some View {
        NavigationLink(destination: TodoDetailAndDeleteView( todo: todo)) {
            HStack(spacing: 12) {
                // Tarih kutucuğu (açık mavi)
                VStack {
                    Text(todo.dueDate.formatAsDay())
                        .font(.system(size: 18, weight: .bold))
                    Text(todo.dueDate.formatAsMonth())
                        .font(.system(size: 12))
                }
                .frame(width: 50, height: 60)
                .foregroundColor(.white)
                .background(Color.blue.opacity(0.4))
                .cornerRadius(8)
                
                // Görev içeriği
                VStack(alignment: .leading, spacing: 4) {
                    Text(todo.title)
                        .font(.headline)
                    
                    if let detail = todo.detail, !detail.isEmpty {
                        Text(detail)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text(todo.dueDate.formatAsTime())
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Tamamlanma butonu
                Button {
                    viewModel.toggleIsDone(Todo: todo)
                    
                } label: {
                    ZStack {
                        Circle()
                            .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                            .frame(width: 28, height: 28)
                        
                        if todo.isDone {
                            Circle()
                                .fill(.green)
                                .frame(width: 20, height: 20)
                            Image(systemName: "checkmark")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .padding(12)
            .background(Color(todo.tint))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
        }
    }
}


#Preview {
    TodoListItemView(viewModel: TodoListItemViewModel(), todo: Task(id: "1", title: "süt al", detail: "marketten süt aldsadaksdlkasdkaosdkoasasdkaskdoaskdokasdokdoaks", image: nil, dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: true, tint: "taskColor3", category: .kişisel))
}
