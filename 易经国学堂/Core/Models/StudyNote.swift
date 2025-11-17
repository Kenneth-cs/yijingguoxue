//
//  StudyNote.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 学习笔记模型
struct StudyNote: Identifiable, Codable {
    let id: UUID
    let hexagramId: Int              // 关联的卦象ID
    var content: String              // 笔记内容
    let createdAt: Date              // 创建时间
    var updatedAt: Date              // 更新时间
    
    init(hexagramId: Int, content: String) {
        self.id = UUID()
        self.hexagramId = hexagramId
        self.content = content
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    init(id: UUID, hexagramId: Int, content: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.hexagramId = hexagramId
        self.content = content
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    /// 更新笔记内容
    mutating func update(content: String) {
        self.content = content
        self.updatedAt = Date()
    }
    
    /// 获取格式化的创建时间
    var formattedCreatedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: createdAt)
    }
    
    /// 获取格式化的更新时间
    var formattedUpdatedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: updatedAt)
    }
}

// MARK: - 示例数据
extension StudyNote {
    static let example = StudyNote(
        hexagramId: 1,
        content: "乾卦是六十四卦之首，纯阳之卦。六爻皆为阳爻，象征刚健、进取、创造。学习要点：\n1. 元亨利贞的含义\n2. 六龙的寓意\n3. 君子自强不息的精神"
    )
}

