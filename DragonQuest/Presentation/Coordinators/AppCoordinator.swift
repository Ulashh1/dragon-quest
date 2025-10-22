//
//  AppCoordinator.swift
//  DragonQuest
//
//  Presentation Layer - Coordinator
//

import SwiftUI

/// Uygulama navigation'ını yöneten coordinator
final class AppCoordinator: ObservableObject {
    @Published var currentScreen: Screen = .main
    @Published var showingAdmin = false
    
    enum Screen {
        case main
        case settings
    }
    
    func showAdmin() {
        showingAdmin = true
    }
    
    func hideAdmin() {
        showingAdmin = false
    }
    
    func navigateTo(_ screen: Screen) {
        currentScreen = screen
    }
}


