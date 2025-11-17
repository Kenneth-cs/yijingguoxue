//
//  Hexagram.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 卦象模型 - 代表六十四卦中的一卦
struct Hexagram: Identifiable, Codable, Hashable {
    let id: Int                      // 卦序（1-64）
    let name: String                 // 卦名，如"乾"
    let chineseName: String          // 完整名称，如"乾为天"
    let upperTrigram: String         // 上卦（三画卦名）
    let lowerTrigram: String         // 下卦
    let binary: String               // 二进制表示，如"111111"
    let description: String          // 卦辞
    let interpretation: String       // 白话释义
    let lines: [Line]                // 六爻
    let symbol: String               // 卦象符号（用于显示）
    
    /// 爻（Line）模型
    struct Line: Codable, Hashable {
        let position: Int            // 爻位（1-6，从下往上）
        let text: String             // 爻辞
        let interpretation: String   // 白话解释
        let isYang: Bool             // 是否为阳爻（true=阳，false=阴）
    }
    
    /// 获取卦象的完整显示名称
    var displayName: String {
        "\(id). \(chineseName)"
    }
    
    /// 获取八卦组合描述
    var trigramDescription: String {
        "\(upperTrigram)上\(lowerTrigram)下"
    }
    
    /// 获取阳爻数量
    var yangCount: Int {
        lines.filter { $0.isYang }.count
    }
    
    /// 获取阴爻数量
    var yinCount: Int {
        lines.filter { !$0.isYang }.count
    }
}

// MARK: - 示例数据（用于预览和测试）
extension Hexagram {
    static let example = Hexagram(
        id: 1,
        name: "乾",
        chineseName: "乾为天",
        upperTrigram: "乾",
        lowerTrigram: "乾",
        binary: "111111",
        description: "乾：元，亨，利，贞。",
        interpretation: "乾卦象征天，具有刚健、进取的特性。元亨利贞是《周易》中最吉祥的卦辞，代表万事开头、亨通顺利、有利于坚守正道。",
        lines: [
            Line(position: 1, text: "初九：潜龙，勿用。", interpretation: "龙潜伏在深处，暂时不要行动。", isYang: true),
            Line(position: 2, text: "九二：见龙在田，利见大人。", interpretation: "龙出现在田野，有利于见到大人物。", isYang: true),
            Line(position: 3, text: "九三：君子终日乾乾，夕惕若厉，无咎。", interpretation: "君子整日勤勉警惕，虽有危险但无灾祸。", isYang: true),
            Line(position: 4, text: "九四：或跃在渊，无咎。", interpretation: "龙跃跃欲试，无灾祸。", isYang: true),
            Line(position: 5, text: "九五：飞龙在天，利见大人。", interpretation: "飞龙在天空，最为吉祥，有利于见大人。", isYang: true),
            Line(position: 6, text: "上九：亢龙有悔。", interpretation: "龙飞得太高，会有后悔。", isYang: true)
        ],
        symbol: "☰"
    )
}

