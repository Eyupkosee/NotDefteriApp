//
//  TodoView.swift
//  NotDefteriApp
//
//  Created by eyüp köse on 27.02.2025.
//

import SwiftUI
import FirebaseAuth


struct TodoView: View {
    
    @StateObject var viewModel : TodoViewModel
    
    
    var body: some View {
        NavigationView {
            ZStack {
                // Arka plan
                BackgroundTheme()
                
                VStack {
                    
                    Text("Notlarım")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.white)
                        .italic()
                    
                    
                    // Arama Çubuğu ve Kategori Seçici
                    HStack {
                        TextField("Notlarda ara...", text: $viewModel.searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(minWidth: 200, maxWidth: .infinity)
                            .padding(.leading)
                        
                        Picker("Kategori", selection: $viewModel.selectedCategory) {
                            Text("Tümü").tag(TaskCategory?.none)
                            ForEach(TaskCategory.allCases) { category in
                                Text(category.rawValue).tag(category as TaskCategory?) 
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 110)
                        .tint(.white)
                    }
                    .padding(.horizontal)


                    
                    
                    // Todo listesi
                    ScrollView {
                        if viewModel.isLoading {
                            ProgressView("Yükleniyor...")
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                        } else if viewModel.tasks.isEmpty {
                            VStack(spacing: 20) {
                                Image(systemName: "doc.text")
                                    .font(.system(size: 50))
                                    .foregroundColor(.green)
                                Text("Henüz bir not bulunmuyor")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Yeni not eklemek için + butonunu kullanın")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .padding()
                        } else {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.filteredTasks) { task in
                                    TodoListItemView(viewModel: TodoListItemViewModel(), todo: task)
                                        .padding(.horizontal)
                                }
                            }
                            .padding(.top, 10)
                        }
                    }
                    .cornerRadius(20)
                    .padding()
                    
                    
                    
                    
                    
                    
                    Spacer()
                    
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: AddTodoView()) {
                            Image(systemName: "plus")
                                .font(.title)
                                .fontWeight(.medium)
                                .padding(10)
                                .foregroundColor(.cyan)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding(.trailing, 24)
                        .padding(.bottom, 20)
                    }
                }
            }
        }
        
    }
}

#Preview {
    TodoView(viewModel: TodoViewModel())
}
