//
//  AdminView.swift
//  DragonQuest
//
//  Presentation Layer - Admin View
//

import SwiftUI

/// Admin panel view
struct AdminView: View {
    @StateObject var viewModel: AdminViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button {
                        Task {
                            await viewModel.createPresetTasks()
                        }
                    } label: {
                        Label("Örnek Görevler Ekle", systemImage: "star.fill")
                    }
                } header: {
                    Text("Hızlı İşlemler")
                }
                
                Section {
                    ForEach(viewModel.tasks) { task in
                        TaskAdminRow(task: task) {
                            Task {
                                await viewModel.deleteTask(task)
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Tüm Görevler")
                        Spacer()
                        Text("\(viewModel.tasks.count)")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Admin Panel")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.showAddTaskSheet()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .task {
                await viewModel.loadTasks()
            }
            .sheet(isPresented: $viewModel.showingAddTask) {
                TaskFormView(viewModel: viewModel)
            }
            .alert("Hata", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Tamam") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
}

// MARK: - Task Admin Row
struct TaskAdminRow: View {
    let task: Task
    let onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title)
                    .font(.headline)
                
                Spacer()
                
                Button(role: .destructive, action: onDelete) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                .buttonStyle(.borderless)
            }
            
            HStack(spacing: 12) {
                Label(task.type.displayName, systemImage: task.type.icon)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Label("\(task.xpValue) XP", systemImage: "star.fill")
                    .font(.caption)
                    .foregroundColor(.orange)
                
                if task.repeatDaily {
                    Text("Günlük")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(4)
                }
                
                if task.repeatWeekly {
                    Text("Haftalık")
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color.purple.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Task Form View
struct TaskFormView: View {
    @ObservedObject var viewModel: AdminViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section("Temel Bilgiler") {
                    TextField("Görev Başlığı", text: $viewModel.taskTitle)
                    
                    TextField("Açıklama (Opsiyonel)", text: $viewModel.taskDescription, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section("Görev Özellikleri") {
                    Picker("Görev Tipi", selection: $viewModel.selectedTaskType) {
                        ForEach([TaskType.daily, .weekly, .main], id: \.self) { type in
                            Label(type.displayName, systemImage: type.icon)
                                .tag(type)
                        }
                    }
                    
                    Picker("Öncelik", selection: $viewModel.selectedPriority) {
                        ForEach([TaskPriority.low, .medium, .high, .critical], id: \.self) { priority in
                            Text(priority.displayName)
                                .tag(priority)
                        }
                    }
                    
                    Stepper("XP Değeri: \(viewModel.xpValue)", value: $viewModel.xpValue, in: 5...200, step: 5)
                }
                
                Section("Planlama") {
                    Toggle("Günlük Tekrar", isOn: $viewModel.repeatDaily)
                    Toggle("Haftalık Tekrar", isOn: $viewModel.repeatWeekly)
                    
                    DatePicker("Planlanan Tarih", selection: Binding(
                        get: { viewModel.scheduledDate ?? Date() },
                        set: { viewModel.scheduledDate = $0 }
                    ), displayedComponents: [.date])
                }
            }
            .navigationTitle("Yeni Görev")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        Task {
                            await viewModel.createTask()
                            dismiss()
                        }
                    }
                    .disabled(viewModel.taskTitle.isEmpty)
                }
            }
        }
    }
}

// MARK: - Preview
struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView(viewModel: .mock)
    }
}


