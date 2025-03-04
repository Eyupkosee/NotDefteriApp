//
//  TodoDetailAndDeleteView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 4.03.2025.
//

import SwiftUI

struct TodoDetailAndDeleteView: View {
    
    @ObservedObject var viewModel: TodoDetailAndDeleteViewModel
    
    let todo : Task
    @State private var isImagePickerShowing = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    init(todo: Task) {
        self.todo = todo
        _viewModel = ObservedObject(wrappedValue: TodoDetailAndDeleteViewModel(todo: todo))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Todo Başlığı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField(todo.title, text: $viewModel.title)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .background(Color.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Todo Detayı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextEditor(text: $viewModel.detail)
                        .frame(height: UIScreen.main.bounds.height / 9)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                }
                
                HStack(spacing: 12){
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Todo Tarihi")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        DatePicker("", selection: $viewModel.dueDate)
                            .datePickerStyle(.compact)
                            .scaleEffect(0.9,anchor: .leading)
                        
                    })
                    .padding(.top,5)
                    .padding(.trailing, -5)
                    
                    VStack(alignment: .leading, spacing: 8, content: {
                        Text("Todo Rengi")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                        let colors : [String] = (1...5).compactMap { index -> String in
                            return "taskColor\(index)"
                        }
                        
                        HStack(spacing: 2){
                            ForEach(colors, id: \.self) {color in
                                Circle()
                                    .fill(Color(color))
                                    .frame(width: 20 ,height: 20)
                                    .background(content: {
                                        Circle()
                                            .stroke(lineWidth: 1.5)
                                            .opacity(viewModel.tint == color ? 1 : 0)
                                    })
                                    .hSpacing(.center)
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        viewModel.tint = color
                                    }
                            }
                        }
                        
                        
                    })
                    .padding(.top,5)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Todo Kategorisi")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(TaskCategory.allCases) { category in
                                Button(action: {
                                    viewModel.category = category
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: category.icon)
                                        Text(category.rawValue)
                                            .font(.subheadline)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(viewModel.category == category ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                    .foregroundColor(viewModel.category == category ? .blue : .primary)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    
                }
                
                
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Todo Görseli")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    ZStack(alignment: .topTrailing) {
                        Button(action: {
                            isImagePickerShowing = true
                        }) {
                            if let imageData = viewModel.imageData, let selectedImage = UIImage(data: imageData) {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .clipped()
                                    .cornerRadius(10)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 180)
                                    .cornerRadius(10)
                                    .overlay(
                                        VStack(spacing: 8) {
                                            Image(systemName: "camera")
                                                .font(.system(size: 24))
                                            Text("Fotoğraf ekle")
                                                .font(.subheadline)
                                        }
                                        .foregroundColor(.gray)
                                    )
                            }
                        }
                        
                        if viewModel.imageData != nil {
                            Button(action: {
                                isImagePickerShowing = true
                            }) {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.black.opacity(0.6), in: Circle())
                            }
                            .padding(8)
                        }
                    }
                    .sheet(isPresented: $isImagePickerShowing) {
                        ImagePicker(selectedImage: Binding(
                            get: { viewModel.imageData.flatMap { UIImage(data: $0) } },
                            set: { newImage in viewModel.imageData = newImage?.jpegData(compressionQuality: 1.0) }
                        ))
                    }
                }
                .padding(.top, 5)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 12) {
                    Button(action: {
                        if viewModel.canUpdate {
                            viewModel.updateTodo()
                            dismiss()
                        } else {
                            showAlert = true
                        }
                    }) {
                        Text("Güncelle")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .hSpacing(.center)
                            .padding(.vertical, 12)
                            .background(Color(viewModel.tint), in: .rect(cornerRadius: 10))
                    }
                    
                    Button(action: {
                        viewModel.deleteTodo{ success in
                            if success {
                                dismiss()
                            }else{
                                
                            }
                        }
                        dismiss()
                    }) {
                        Text("Sil")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .hSpacing(.center)
                            .padding(.vertical, 12)
                            .background(Color.red, in: .rect(cornerRadius: 10))
                    }
                }
                .alert("Başlık boş bırakılamaz!", isPresented: $showAlert) {
                    Button("Tamam", role: .cancel) {}
                }
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    TodoDetailAndDeleteView( todo: Task(id: "1", title: "süt al", detail: "marketten süt aldsadaksdlkasdkaosdkoasasdkaskdoaskdokasdokdoaks", image: nil, dueDate: Date().timeIntervalSince1970, createDate: Date().timeIntervalSince1970, isDone: true, tint: "taskColor3", category: .kişisel))
}
