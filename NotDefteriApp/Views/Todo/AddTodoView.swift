//
//  AddTodoView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 28.02.2025.
//

import SwiftUI

struct AddTodoView: View {
    
    @StateObject var viewModel = AddTodoViewModel()
    @State private var isImagePickerShowing = false
    @State private var showAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Todo Başlığı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Akşam 8 de toplantı var.", text: $viewModel.title)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal,15)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    
                })
                .padding(.top,5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Todo Detayı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextEditor(text: $viewModel.detail)
                        .frame(height: UIScreen.main.bounds.height / 9)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .padding(.vertical, 10)
                        .padding(.horizontal,15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    
                })
                .padding(.top,5)
                
                VStack(alignment: .leading, spacing: 8, content: {
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
                    
                    
                })
                .padding(.top,5)

                
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
                .padding(.top,5)
                

             
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
                
                Button {
                    if viewModel.canSave {
                        viewModel.save()
                        NotificationManager.shared.scheduleNotifications()
                        dismiss()
                    }else{
                        showAlert = true
                    }
                    
                } label: {
                    Text("Todo Oluştur")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(Color(viewModel.tint), in: .rect(cornerRadius: 10))
                }
                .alert("Başlık boş bırakılamaz!", isPresented: $showAlert) {
                    Button("Tamam", role: .cancel) { }
                }
                       
            }
            .padding(.horizontal, 15)

        }
       
    }
}

#Preview {
    AddTodoView()
}

