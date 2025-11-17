//
//  Constants.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation
import SwiftUI

/// 应用常量
enum AppConstants {
    
    // MARK: - 应用信息
    enum App {
        static let name = "易经国学堂"
        static let version = "1.0.0"
        static let bundleIdentifier = "com.yijing.academy"
    }
    
    // MARK: - 数据文件
    enum DataFiles {
        static let hexagrams = "hexagrams"
        static let trigrams = "trigrams"
        static let quizQuestions = "quiz_questions"
        static let fileExtension = "json"
    }
    
    // MARK: - UserDefaults Keys
    enum StorageKeys {
        static let studyProgress = "studyProgress"
        static let gameRecords = "gameRecords"
        static let studyNotes = "studyNotes"
        static let settings = "appSettings"
        static let firstLaunch = "isFirstLaunch"
    }
    
    // MARK: - 游戏配置
    enum Game {
        static let defaultQuestionCount = 10
        static let memoryGameTimeLimit = 30 // 秒
        static let quizTimeLimit = 60 // 秒
        static let passingScore = 60 // 及格分数
    }
    
    // MARK: - UI 配置
    enum UI {
        static let cornerRadius: CGFloat = 12
        static let cardPadding: CGFloat = 16
        static let sectionSpacing: CGFloat = 20
        static let animationDuration: Double = 0.3
    }
    
    // MARK: - 颜色配置
    enum Colors {
        static let primary = Color("PrimaryColor")
        static let secondary = Color("SecondaryColor")
        static let background = Color("BackgroundColor")
        static let cardBackground = Color("CardBackground")
        
        // 传统色彩
        static let ink = Color(hex: "2C3E50")        // 墨色
        static let cinnabar = Color(hex: "C73E3A")   // 朱砂
        static let jade = Color(hex: "2E8B57")       // 玉色
        static let gold = Color(hex: "D4AF37")       // 金色
    }
    
    // MARK: - 字体大小
    enum FontSize {
        static let title: CGFloat = 28
        static let headline: CGFloat = 20
        static let body: CGFloat = 16
        static let caption: CGFloat = 14
        static let small: CGFloat = 12
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

