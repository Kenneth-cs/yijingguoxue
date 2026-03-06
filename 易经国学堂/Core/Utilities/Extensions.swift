//
//  Extensions.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation
import SwiftUI

// MARK: - Date Extensions
extension Date {
    /// 判断是否是今天
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// 判断是否是昨天
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    /// 获取友好的时间描述
    var relativeDescription: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    /// 格式化为"yyyy-MM-dd"
    var shortDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    
    /// 格式化为"yyyy年MM月dd日"
    var chineseDateString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.dateFormat = "yyyy年MM月dd日"
        return formatter.string(from: self)
    }
}

// MARK: - String Extensions
extension String {
    /// 判断字符串是否为空（包括只有空白字符的情况）
    var isBlank: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// 移除所有空白字符
    var removingWhitespace: String {
        self.components(separatedBy: .whitespaces).joined()
    }
    
    /// 将二进制字符串转换为卦象符号
    func toBinarySymbol() -> String {
        self.map { $0 == "1" ? "━━━" : "━ ━" }.joined(separator: "\n")
    }
}

// MARK: - Array Extensions
extension Array {
    /// 安全地获取数组元素
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
    
    /// 随机抽取n个不重复的元素
    func randomElements(count: Int) -> [Element] {
        guard count <= self.count else { return Array(self.shuffled()) }
        return Array(self.shuffled().prefix(count))
    }
}

// MARK: - View Extensions
extension View {
    /// 添加卡片样式
    func cardStyle() -> some View {
        self
            .background(Color(.systemBackground))
            .cornerRadius(AppConstants.UI.cornerRadius)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    /// 条件性地应用modifier
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// 隐藏键盘
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// MARK: - Int Extensions
extension Int {
    /// 转换为中文数字
    var toChinese: String {
        let chineseNumbers = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        guard self >= 0, self < chineseNumbers.count else { return "\(self)" }
        return chineseNumbers[self]
    }
    
    /// 转换为序数（第一、第二等）
    var toOrdinalChinese: String {
        "第\(self.toChinese)"
    }
}

// MARK: - Bundle Extensions
extension Bundle {
    /// 从Bundle中解码JSON文件
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T? {
        
        guard let url = self.url(forResource: file, withExtension: nil) else {
            print("❌ 找不到文件: \(file)")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("❌ 无法加载文件: \(file)")
            return nil
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ 解码失败 (\(file)): \(error)")
            return nil
        }
    }
}

// MARK: - Color Extension
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

// MARK: - UserDefaults Extensions
extension UserDefaults {
    /// 保存Codable对象
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            set(encoded, forKey: key)
        }
    }
    
    /// 读取Codable对象
    func getCodable<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
}

