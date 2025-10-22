//
//  MainView.swift
//  DragonQuest
//
//  Presentation Layer - Main View
//

import SwiftUI

/// Ana ekran view
struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Dragon View
                        DragonView(
                            stage: viewModel.currentDragonStage,
                            progress: viewModel.progressPercentage
                        )
                        .frame(height: 250)
                        .padding()
                        
                        // Progress Card
                        ProgressCardView(progress: viewModel.userProgress)
                            .padding(.horizontal)
                        
                        // Tasks Section
                        VStack(spacing: 16) {
                            // Daily Tasks
                            TaskSectionView(
                                title: "Günlük Görevler",
                                icon: "sun.max.fill",
                                tasks: viewModel.dailyTasks,
                                onTaskTap: { task in
                                    Task {
                                        await viewModel.completeTask(task)
                                    }
                                }
                            )
                            
                            // Weekly Tasks
                            TaskSectionView(
                                title: "Haftalık Görevler",
                                icon: "calendar.badge.clock",
                                tasks: viewModel.weeklyTasks,
                                onTaskTap: { task in
                                    Task {
                                        await viewModel.completeTask(task)
                                    }
                                }
                            )
                            
                            // Main Quests
                            TaskSectionView(
                                title: "Ana Görevler",
                                icon: "star.fill",
                                tasks: viewModel.mainTasks,
                                onTaskTap: { task in
                                    Task {
                                        await viewModel.completeTask(task)
                                    }
                                }
                            )
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                
                // Loading Overlay
                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                }
            }
            .navigationTitle("Dragon Quest")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Admin panel'e git
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .task {
                await viewModel.loadData()
            }
            .refreshable {
                await viewModel.refresh()
            }
            .alert("Hata", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("Tamam") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .overlay {
                if viewModel.showLevelUpAnimation {
                    LevelUpView(
                        level: viewModel.userProgress.currentLevel,
                        onDismiss: {
                            viewModel.dismissLevelUpAnimation()
                        }
                    )
                    .transition(.scale.combined(with: .opacity))
                }
            }
        }
    }
}

// MARK: - Progress Card View
struct ProgressCardView: View {
    let progress: UserProgress
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Level \(progress.currentLevel)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("\(progress.currentLevelXP) / \(progress.nextLevelXP) XP")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("\(progress.dailyStreak)")
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                    
                    Text("Günlük Seri")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                    
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geometry.size.width * progress.progressPercentage)
                }
            }
            .frame(height: 12)
            
            HStack {
                Label("\(progress.totalTasksCompleted)", systemImage: "checkmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.green)
                
                Spacer()
                
                Text(progress.dragonStage.displayName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(uiColor: .systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10)
        )
    }
}

// MARK: - Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: .mock)
    }
}


