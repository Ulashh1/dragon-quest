//
//  DragonView.swift
//  DragonQuest
//
//  Presentation Layer - Component
//

import SwiftUI

/// Ejderha görselleştirme view'ı
struct DragonView: View {
    let stage: DragonStage
    let progress: Double
    
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                // Background glow effect
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                stageColor.opacity(0.3),
                                stageColor.opacity(0.1),
                                .clear
                            ],
                            center: .center,
                            startRadius: 50,
                            endRadius: 120
                        )
                    )
                    .frame(width: 200, height: 200)
                    .blur(radius: 20)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                
                // Dragon representation
                // NOT: Gerçek uygulamada buraya Lottie/Rive animasyonu gelecek
                dragonRepresentation
                    .scaleEffect(isAnimating ? 1.05 : 1.0)
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    isAnimating = true
                }
            }
            
            Text(stage.displayName)
                .font(.headline)
                .foregroundColor(stageColor)
            
            Text(stage.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var dragonRepresentation: some View {
        switch stage {
        case .egg:
            EggView(crackProgress: progress)
        case .cracking:
            CrackingEggView(crackProgress: progress)
        case .hatchling:
            DragonEmojiView(emoji: "🐲", size: 80)
        case .juvenile:
            DragonEmojiView(emoji: "🐉", size: 100)
        case .adult:
            DragonEmojiView(emoji: "🐲", size: 120)
        case .elder:
            DragonEmojiView(emoji: "🐉", size: 140)
        }
    }
    
    private var stageColor: Color {
        switch stage {
        case .egg, .cracking:
            return .gray
        case .hatchling:
            return .green
        case .juvenile:
            return .blue
        case .adult:
            return .purple
        case .elder:
            return .orange
        }
    }
}

// MARK: - Egg View
struct EggView: View {
    let crackProgress: Double
    
    var body: some View {
        ZStack {
            // Egg shape
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [.white, .gray.opacity(0.5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 100, height: 120)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            // Decorative spots
            ForEach(0..<5, id: \.self) { index in
                Circle()
                    .fill(Color.brown.opacity(0.2))
                    .frame(width: CGFloat.random(in: 8...15))
                    .offset(
                        x: CGFloat.random(in: -30...30),
                        y: CGFloat.random(in: -40...40)
                    )
            }
        }
    }
}

// MARK: - Cracking Egg View
struct CrackingEggView: View {
    let crackProgress: Double
    
    var body: some View {
        ZStack {
            EggView(crackProgress: crackProgress)
            
            // Crack lines
            Path { path in
                path.move(to: CGPoint(x: 50, y: 30))
                path.addLine(to: CGPoint(x: 60, y: 80))
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 2)
            
            Path { path in
                path.move(to: CGPoint(x: 50, y: 50))
                path.addLine(to: CGPoint(x: 30, y: 90))
            }
            .stroke(Color.black.opacity(0.6), lineWidth: 2)
            
            // Glow from inside
            Circle()
                .fill(Color.yellow.opacity(0.3 * crackProgress))
                .frame(width: 40, height: 40)
                .blur(radius: 10)
        }
    }
}

// MARK: - Dragon Emoji View
struct DragonEmojiView: View {
    let emoji: String
    let size: CGFloat
    
    var body: some View {
        Text(emoji)
            .font(.system(size: size))
    }
}

// MARK: - Preview
struct DragonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            DragonView(stage: .egg, progress: 0.3)
            DragonView(stage: .cracking, progress: 0.7)
            DragonView(stage: .hatchling, progress: 0.5)
            DragonView(stage: .adult, progress: 0.8)
        }
        .padding()
    }
}


