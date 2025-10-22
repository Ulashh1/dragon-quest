//
//  Colors.swift
//  DragonQuest
//
//  Presentation Layer - Theme Colors
//

import SwiftUI

/// Uygulama renk temaları
struct AppColors {
    // MARK: - Primary Colors
    
    static let primary = Color.blue
    static let secondary = Color.purple
    static let accent = Color.orange
    
    // MARK: - Status Colors
    
    static let success = Color.green
    static let warning = Color.orange
    static let danger = Color.red
    static let info = Color.blue
    
    // MARK: - Task Priority Colors
    
    static let priorityLow = Color.gray
    static let priorityMedium = Color.blue
    static let priorityHigh = Color.orange
    static let priorityCritical = Color.red
    
    // MARK: - Dragon Stage Colors
    
    static let stageEgg = Color.gray
    static let stageCracking = Color.gray
    static let stageHatchling = Color.green
    static let stageJuvenile = Color.blue
    static let stageAdult = Color.purple
    static let stageElder = Color.orange
    
    // MARK: - Gradient Colors
    
    static let backgroundGradient = LinearGradient(
        colors: [primary.opacity(0.3), secondary.opacity(0.3)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let xpGradient = LinearGradient(
        colors: [.blue, .purple],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let levelUpGradient = LinearGradient(
        colors: [.yellow, .orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

/// Uygulama font stilleri
struct AppFonts {
    static let largeTitle = Font.largeTitle.weight(.bold)
    static let title = Font.title.weight(.semibold)
    static let title2 = Font.title2.weight(.semibold)
    static let title3 = Font.title3.weight(.medium)
    static let headline = Font.headline
    static let body = Font.body
    static let callout = Font.callout
    static let caption = Font.caption
    static let caption2 = Font.caption2
}

/// Uygulama spacing değerleri
struct AppSpacing {
    static let tiny: CGFloat = 4
    static let small: CGFloat = 8
    static let medium: CGFloat = 16
    static let large: CGFloat = 24
    static let extraLarge: CGFloat = 32
    static let huge: CGFloat = 48
}

/// Uygulama corner radius değerleri
struct AppCornerRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let extraLarge: CGFloat = 24
}


