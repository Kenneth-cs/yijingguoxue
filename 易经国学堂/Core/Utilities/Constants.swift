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
        static let cornerRadius: CGFloat = 16
        static let cardPadding: CGFloat = 20
        static let sectionSpacing: CGFloat = 24
        static let animationDuration: Double = 0.35
        static let shadowRadius: CGFloat = 8
        static let shadowOpacity: Double = 0.08
    }
    
    // MARK: - 颜色配置 (易经主题)
    enum Colors {
        // 主色调 - 墨绿色系（呼应App Icon）
        static let primary = Color(hex: "1B5E4F")        // 深墨绿
        static let primaryLight = Color(hex: "2E8B6F")   // 浅墨绿
        static let primaryDark = Color(hex: "0D3D31")    // 极深绿
        
        // 辅助色 - 金色系（呼应App Icon）
        static let accent = Color(hex: "D4AF37")         // 金色
        static let accentLight = Color(hex: "E5C766")    // 浅金
        static let accentDark = Color(hex: "B8941F")     // 深金
        
        // 传统文化色彩
        static let ink = Color(hex: "2C3E50")            // 墨色
        static let cinnabar = Color(hex: "C73E3A")       // 朱砂红
        static let jade = Color(hex: "3FA796")           // 玉色
        static let bamboo = Color(hex: "6B8E23")         // 竹青
        static let cloud = Color(hex: "E8E8E8")          // 云白
        
        // 阴阳色彩
        static let yang = Color(hex: "FF6B6B")           // 阳爻 - 暖红
        static let yin = Color(hex: "4ECDC4")            // 阴爻 - 冷青
        
        // 背景色
        static let background = Color(hex: "F5F7F6")     // 淡雅背景
        static let cardBackground = Color.white
        
        // 渐变色组合
        static let primaryGradient = LinearGradient(
            colors: [Color(hex: "1B5E4F"), Color(hex: "2E8B6F")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let accentGradient = LinearGradient(
            colors: [Color(hex: "D4AF37"), Color(hex: "E5C766")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let elegantGradient = LinearGradient(
            colors: [Color(hex: "1B5E4F").opacity(0.1), Color(hex: "D4AF37").opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
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

