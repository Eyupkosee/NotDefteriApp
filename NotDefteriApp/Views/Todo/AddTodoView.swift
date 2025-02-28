//
//  AddTodoView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 28.02.2025.
//

import SwiftUI

struct AddTodoView: View {
    
    @State var oylesine : String = ""
    @State private var taskDate : Date = .init()
    @State private var taskColor : String = "taskColor1"
    
    
    @State private var selectedCategory: TaskCategory = .kişisel
    
    @State private var selectedImage: UIImage?
    @State private var isImagePickerShowing = false

    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Todo Başlığı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextField("Akşam 8 de toplantı var.", text: $oylesine)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal,15)
                        .background(.white.shadow(.drop(color: .black.opacity(0.25), radius: 2)), in: .rect(cornerRadius: 10))
                    
                })
                .padding(.top,5)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Todo Detayı")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    TextEditor(text: $oylesine)
                        .frame(height: UIScreen.main.bounds.height / 9)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .heavy, design: .rounded))
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
                                    selectedCategory = category
                                }) {
                                    HStack(spacing: 4) {
                                        Image(systemName: category.icon)
                                        Text(category.rawValue)
                                            .font(.subheadline)
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(selectedCategory == category ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                    .foregroundColor(selectedCategory == category ? .blue : .primary)
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
                        
                       DatePicker("", selection: $taskDate)
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
                                            .opacity(taskColor == color ? 1 : 0)
                                    })
                                    .hSpacing(.center)
                                    .contentShape(.rect)
                                    .onTapGesture {
                                        taskColor = color
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
                    
                    Button(action: {
                        isImagePickerShowing = true
                    }) {
                        ZStack {
                            if let selectedImage = selectedImage {
                                Image(uiImage: selectedImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(16/9, contentMode: .fill) // Sabit oran kullanıyoruz, ancak yükseklik sınırlaması yok
                                    .clipped()
                                    .cornerRadius(10)
                                    .overlay(
                                        Image(systemName: "pencil.circle.fill")
                                            .font(.title)
                                            .foregroundColor(.white)
                                            .padding(8)
                                            .background(Color.black.opacity(0.6), in: Circle())
                                            .padding(8),
                                        alignment: .topTrailing
                                    )
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(maxWidth: .infinity)
                                    .aspectRatio(16/9, contentMode: .fill) // Oranlı boyut, sabit yükseklik yok
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
                    }
                    .sheet(isPresented: $isImagePickerShowing) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                }
                .padding(.top, 5)
                
                
                
                
                
                Spacer(minLength: 0)
                
                Button {
                    // Saving Data
                    do{
                      
                    }catch{
                        print(error.localizedDescription)
                    }
                    
                    
                } label: {
                    Text("Todo Oluştur")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.black)
                        .hSpacing(.center)
                        .padding(.vertical, 12)
                        .background(Color(taskColor), in: .rect(cornerRadius: 10))
                }
                .disabled(oylesine == "")
                .opacity(oylesine == "" ? 0.5 : 1)
                       
            }
            .padding(15)

        }
       
    }
}

#Preview {
    AddTodoView()
}

