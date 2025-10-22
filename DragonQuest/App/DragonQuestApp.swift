//
//  DragonQuestApp.swift
//  DragonQuest
//
//  Main App Entry Point
//

import SwiftUI

@main
struct DragonQuestApp: App {
    // Dependency Injection Container
    private let container = DIContainer.shared
    
    // App Delegate for notification handling
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(container.appCoordinator)
        }
    }
}

// MARK: - Content View
struct ContentView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    private let container = DIContainer.shared
    
    var body: some View {
        MainView(viewModel: container.makeMainViewModel())
            .sheet(isPresented: $coordinator.showingAdmin) {
                AdminView(viewModel: container.makeAdminViewModel())
            }
    }
}


