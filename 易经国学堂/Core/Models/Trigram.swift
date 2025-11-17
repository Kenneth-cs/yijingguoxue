//
//  Trigram.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 八卦模型 - 代表八个基本卦象
struct Trigram: Identifiable, Codable, Hashable {
    let id: String                   // 八卦名称（作为唯一标识）
    let name: String                 // 名称（乾、坤、震、巽、坎、离、艮、兑）
    let binary: String               // 三爻二进制，如"111"
    let element: String              // 五行属性
    let direction: String            // 方位
    let symbolism: String            // 象征意义
    let nature: String               // 性质
    let family: String               // 家庭关系（父、母、长男等）
    let description: String          // 详细说明
    let symbol: String               // 卦象符号
    
    /// 获取阳爻数量
    var yangCount: Int {
        binary.filter { $0 == "1" }.count
    }
    
    /// 获取阴爻数量
    var yinCount: Int {
        binary.filter { $0 == "0" }.count
    }
    
    /// 获取完整描述
    var fullDescription: String {
        """
        \(name)卦：\(symbolism)
        五行：\(element)
        方位：\(direction)
        性质：\(nature)
        家庭：\(family)
        
        \(description)
        """
    }
}

// MARK: - 示例数据
extension Trigram {
    static let example = Trigram(
        id: "qian",
        name: "乾",
        binary: "111",
        element: "金",
        direction: "西北",
        symbolism: "天",
        nature: "刚健",
        family: "父",
        description: "乾为天，纯阳之卦，象征刚健、进取、创造。在自然界中代表天空，在人事上代表君王、父亲、领导者。其性质刚健有力，永不停息。",
        symbol: "☰"
    )
    
    static let allTrigrams = [
        Trigram(id: "qian", name: "乾", binary: "111", element: "金", direction: "西北", symbolism: "天", nature: "刚健", family: "父", description: "乾为天，纯阳之卦。", symbol: "☰"),
        Trigram(id: "kun", name: "坤", binary: "000", element: "土", direction: "西南", symbolism: "地", nature: "柔顺", family: "母", description: "坤为地，纯阴之卦。", symbol: "☷"),
        Trigram(id: "zhen", name: "震", binary: "001", element: "木", direction: "东", symbolism: "雷", nature: "动", family: "长男", description: "震为雷，象征震动、奋起。", symbol: "☳"),
        Trigram(id: "xun", name: "巽", binary: "110", element: "木", direction: "东南", symbolism: "风", nature: "入", family: "长女", description: "巽为风，象征柔和、渗透。", symbol: "☴"),
        Trigram(id: "kan", name: "坎", binary: "010", element: "水", direction: "北", symbolism: "水", nature: "陷", family: "中男", description: "坎为水，象征险难、流动。", symbol: "☵"),
        Trigram(id: "li", name: "离", binary: "101", element: "火", direction: "南", symbolism: "火", nature: "丽", family: "中女", description: "离为火，象征光明、附丽。", symbol: "☲"),
        Trigram(id: "gen", name: "艮", binary: "100", element: "土", direction: "东北", symbolism: "山", nature: "止", family: "少男", description: "艮为山，象征停止、静止。", symbol: "☶"),
        Trigram(id: "dui", name: "兑", binary: "011", element: "金", direction: "西", symbolism: "泽", nature: "悦", family: "少女", description: "兑为泽，象征喜悦、交流。", symbol: "☱")
    ]
}

