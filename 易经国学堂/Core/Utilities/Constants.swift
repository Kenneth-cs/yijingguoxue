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
    
    // MARK: - 字体系统（全局宋体 Songti SC，三档字重）
    enum Fonts {
        /*
         Songti SC 在 iOS 上实际可用的字体文件名：
           - "Songti SC"        → Regular（正文、说明）
           - "Songti SC Bold"   → Bold（主标题、大号数字）
           - "Songti SC Light"  → Light（辅助文字、小字）
         使用 Font.custom 直接指定字体名称，最可靠。
        */

        /// 粗体宋体 —— 用于页面主标题、卦名、重要数字
        static func bold(_ size: CGFloat) -> Font {
            Font.custom("Songti SC Bold", size: size)
        }

        /// 常规宋体 —— 用于正文、卦辞、按钮文字
        static func regular(_ size: CGFloat) -> Font {
            Font.custom("Songti SC", size: size)
        }

        /// 细体宋体 —— 用于辅助说明、标签、时间等小字
        static func light(_ size: CGFloat) -> Font {
            Font.custom("Songti SC Light", size: size)
        }

        // ── 预定义尺寸（按用途分三档字重）──────────────────────
        static let largeTitle  = bold(32)      // 超大标题（封面级）
        static let title1      = bold(24)      // 页面大标题
        static let title2      = bold(20)      // 卡片标题
        static let title3      = bold(18)      // 章节标题
        static let headline    = bold(17)      // 小节标题、按钮
        static let bodyText    = regular(16)   // 主正文
        static let callout     = regular(15)   // 次正文、卦辞
        static let subheadline = regular(14)   // 副标题、描述
        static let caption     = light(13)     // 辅助说明
        static let caption2    = light(12)     // 小标签、时间

        // ── 兼容旧调用（部分 View 仍使用 serifTitle / body）──────
        static func serifTitle(size: CGFloat, weight: Font.Weight = .semibold) -> Font {
            switch weight {
            case .bold, .heavy, .black: return bold(size)
            case .light, .thin, .ultraLight: return light(size)
            default: return regular(size)
            }
        }
        static func body(size: CGFloat, weight: Font.Weight = .regular) -> Font {
            return serifTitle(size: size, weight: weight)
        }
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

