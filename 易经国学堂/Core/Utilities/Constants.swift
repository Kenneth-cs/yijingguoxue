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
        static let cardCornerRadius: CGFloat = 16
        static let cardPadding: CGFloat = 16
        static let sectionSpacing: CGFloat = 20
        static let animationDuration: Double = 0.3
        static let shadowOpacity: Double = 0.08
        static let cardShadowRadius: CGFloat = 8
        static let cardShadowY: CGFloat = 3
    }
    
    // MARK: - 新中式色彩系统
    enum Colors {
        // 背景色系 - 宣纸质感
        static let paperBackground = Color(hex: "F7F5F0")      // 米白/宣纸色
        static let cardBackground = Color(hex: "FFFEFB")       // 卡片纯白
        static let darkBackground = Color(hex: "1A1A1A")       // 墨黑
        static let groupedBackground = Color(hex: "EAE6DD")    // 分组背景
        
        // 主色系 - 朱砂与黛蓝
        static let cinnabar = Color(hex: "C04851")             // 朱砂红（主色）
        static let indigo = Color(hex: "2C4A6E")               // 黛蓝（辅助色）
        static let deepGreen = Color(hex: "1B5E4F")            // 墨绿
        
        // 文字色系 - 墨色
        static let textPrimary = Color(hex: "2C2C2C")          // 浓墨（主要文字）
        static let textSecondary = Color(hex: "666666")        // 淡墨（次要文字）
        static let textTertiary = Color(hex: "999999")         // 轻墨（辅助文字）
        
        // 点缀色系
        static let gold = Color(hex: "D4AF37")                 // 流金（强调、VIP）
        static let amber = Color(hex: "F0A020")                // 琥珀
        static let jade = Color(hex: "7FB77E")                 // 碧玉
        
        // 五行色系（用于八卦属性展示）
        static let woodColor = Color(hex: "7FB77E")            // 木-青绿
        static let fireColor = Color(hex: "E85D4E")            // 火-朱红
        static let earthColor = Color(hex: "D4A574")           // 土-土黄
        static let metalColor = Color(hex: "C0C0C0")           // 金-银白
        static let waterColor = Color(hex: "4A90E2")           // 水-湛蓝
        
        // 渐变色
        static let elegantGradient = LinearGradient(
            colors: [Color(hex: "F7F5F0"), Color(hex: "EAE6DD")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let cardGradient = LinearGradient(
            colors: [Color(hex: "FFFEFB"), Color(hex: "F9F8F5")],
            startPoint: .top,
            endPoint: .bottom
        )
        
        static let accentGradient = LinearGradient(
            colors: [Color(hex: "C04851").opacity(0.15), Color(hex: "2C4A6E").opacity(0.15)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        static let symbolGradient = LinearGradient(
            colors: [Color(hex: "D4AF37").opacity(0.2), Color(hex: "C04851").opacity(0.1)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    // MARK: - 字体系统（全局使用宋体 Songti SC）
    enum Fonts {
        // 宋体名称常量，iOS 系统内置
        private static let songtiName = "Songti SC"

        // 宋体标题（用于卦名、章节标题等需要古典气质的地方）
        static func serifTitle(size: CGFloat, weight: Font.Weight = .semibold) -> Font {
            let uiWeight: UIFont.Weight
            switch weight {
            case .bold:     uiWeight = .bold
            case .semibold: uiWeight = .semibold
            case .medium:   uiWeight = .medium
            case .light:    uiWeight = .light
            default:        uiWeight = .regular
            }
            // 通过 UIFont 确保正确加载宋体，再桥接到 SwiftUI Font
            let descriptor = UIFontDescriptor(name: songtiName, size: size)
            let uiFont = UIFont(descriptor: descriptor.addingAttributes([
                .traits: [UIFontDescriptor.TraitKey.weight: uiWeight]
            ]), size: size)
            return Font(uiFont)
        }

        // 宋体正文（用于卦辞、解读等内容文字）
        static func body(size: CGFloat, weight: Font.Weight = .regular) -> Font {
            return serifTitle(size: size, weight: weight)
        }

        // 预定义尺寸
        static let largeTitle  = serifTitle(size: 32, weight: .bold)
        static let title1      = serifTitle(size: 24, weight: .semibold)
        static let title2      = serifTitle(size: 20, weight: .semibold)
        static let title3      = serifTitle(size: 18, weight: .semibold)
        static let headline    = serifTitle(size: 17, weight: .semibold)
        static let bodyText    = serifTitle(size: 16, weight: .regular)
        static let callout     = serifTitle(size: 15, weight: .regular)
        static let subheadline = serifTitle(size: 14, weight: .regular)
        static let caption     = serifTitle(size: 13, weight: .regular)
        static let caption2    = serifTitle(size: 12, weight: .regular)
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

