//
//  RandomColor.swift
//  Finance Tracker
//
//  Created by Batuhan Berk Ertekin on 23.07.2024.
//

import SwiftUI

extension Color {
    
    // MARK: - Random Color Generator
    static func randomColor() -> Color {
        Color(red: Double.random(in: 0.5...1),
              green: Double.random(in: 0.5...1),
              blue: Double.random(in: 0.5...1))
    }
    
    // MARK: - Random Reminder Color
    static func randomReminderColor() -> Color {
        let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .brown, .indigo, .cyan, .yellow]
        return colors.randomElement() ?? .gray
    }
}
