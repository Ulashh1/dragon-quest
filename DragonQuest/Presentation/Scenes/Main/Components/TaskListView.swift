//
//  TaskListView.swift
//  DragonQuest
//
//  Presentation Layer - Component
//

import SwiftUI

/// Görev listesi component
struct TaskListView: View {
    let tasks: [Task]
    let onTaskTap: (Task) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(tasks) { task in
                TaskRowView(task: task, onTap: {
                    onTaskTap(task)
                })
            }
        }
    }
}

// MARK: - Task Row View
struct TaskRowView: View {
    let task: Task
    let onTap: () -> Void
    
    var body: some View {
        Button(action: {
            if !task.isCompleted {
                onTap()
            }
        }) {
            HStack(spacing: 16) {
                // Checkbox
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .gray)
                
                // Task Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(task.title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                        .strikethrough(task.isCompleted)
                    
                    if let description = task.description {
                        Text(description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    
                    HStack(spacing: 8) {
                        // Priority badge
                        PriorityBadge(priority: task.priority)
                        
                        // XP badge
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption2)
                            Text("\(task.xpValue) XP")
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.orange)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                Spacer()
                
                // Chevron
                if !task.isCompleted {
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(uiColor: .systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 5)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Priority Badge
struct PriorityBadge: View {
    let priority: TaskPriority
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(priorityColor)
                .frame(width: 8, height: 8)
            
            Text(priority.displayName)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(priorityColor.opacity(0.1))
        .cornerRadius(8)
    }
    
    private var priorityColor: Color {
        switch priority {
        case .low:
            return .gray
        case .medium:
            return .blue
        case .high:
            return .orange
        case .critical:
            return .red
        }
    }
}

// MARK: - Task Section View
struct TaskSectionView: View {
    let title: String
    let icon: String
    let tasks: [Task]
    let onTaskTap: (Task) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                
                Text(title)
                    .font(.headline)
                
                Spacer()
                
                Text("\(tasks.filter { !$0.isCompleted }.count)/\(tasks.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if tasks.isEmpty {
                EmptyTaskView()
            } else {
                TaskListView(tasks: tasks, onTaskTap: onTaskTap)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground).opacity(0.7))
        )
    }
}

// MARK: - Empty Task View
struct EmptyTaskView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "tray")
                .font(.largeTitle)
                .foregroundColor(.secondary)
            
            Text("Henüz görev yok")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32)
    }
}

// MARK: - Level Up View
struct LevelUpView: View {
    let level: Int
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    onDismiss()
                }
            
            VStack(spacing: 24) {
                Text("🎉")
                    .font(.system(size: 80))
                
                Text("Level Up!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text("Level \(level)")
                    .font(.title)
                    .foregroundColor(.yellow)
                
                Button("Devam Et") {
                    onDismiss()
                }
                .buttonStyle(.borderedProminent)
                .tint(.yellow)
            }
            .padding(40)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(uiColor: .systemBackground))
            )
            .padding(40)
        }
    }
}

// MARK: - Preview
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TaskSectionView(
                title: "Günlük Görevler",
                icon: "sun.max.fill",
                tasks: [.mockDaily, .mockWeekly],
                onTaskTap: { _ in }
            )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}


