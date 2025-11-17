//
//  GameRecord.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 游戏记录模型
struct GameRecord: Identifiable, Codable {
    let id: UUID
    let gameType: GameType           // 游戏类型
    let score: Int                   // 得分
    let totalQuestions: Int          // 总题数
    let correctAnswers: Int          // 正确数
    let date: Date                   // 游戏日期
    let duration: TimeInterval       // 游戏时长（秒）
    
    /// 游戏类型枚举
    enum GameType: String, Codable {
        case memoryGame = "认卦游戏"
        case quiz = "知识问答"
        case lineMatch = "爻辞配对"
        case symbolRecognition = "卦象识别"
        
        var icon: String {
            switch self {
            case .memoryGame: return "brain.head.profile"
            case .quiz: return "questionmark.circle"
            case .lineMatch: return "link"
            case .symbolRecognition: return "eye"
            }
        }
    }
    
    init(gameType: GameType, score: Int, totalQuestions: Int, correctAnswers: Int, duration: TimeInterval) {
        self.id = UUID()
        self.gameType = gameType
        self.score = score
        self.totalQuestions = totalQuestions
        self.correctAnswers = correctAnswers
        self.date = Date()
        self.duration = duration
    }
    
    /// 正确率（百分比）
    var accuracy: Int {
        guard totalQuestions > 0 else { return 0 }
        return Int((Double(correctAnswers) / Double(totalQuestions)) * 100)
    }
    
    /// 错误数
    var wrongAnswers: Int {
        totalQuestions - correctAnswers
    }
    
    /// 获取格式化的日期
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: date)
    }
    
    /// 获取格式化的游戏时长
    var formattedDuration: String {
        let minutes = Int(duration) / 60
        let seconds = Int(duration) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    
    /// 评级（根据正确率）
    var rating: String {
        switch accuracy {
        case 90...100: return "优秀"
        case 75..<90: return "良好"
        case 60..<75: return "及格"
        default: return "需努力"
        }
    }
    
    /// 评级颜色名称
    var ratingColor: String {
        switch accuracy {
        case 90...100: return "green"
        case 75..<90: return "blue"
        case 60..<75: return "orange"
        default: return "red"
        }
    }
}

// MARK: - 示例数据
extension GameRecord {
    static let example = GameRecord(
        gameType: .memoryGame,
        score: 85,
        totalQuestions: 10,
        correctAnswers: 8,
        duration: 120
    )
    
    static let examples: [GameRecord] = [
        GameRecord(gameType: .memoryGame, score: 90, totalQuestions: 10, correctAnswers: 9, duration: 150),
        GameRecord(gameType: .quiz, score: 75, totalQuestions: 20, correctAnswers: 15, duration: 300),
        GameRecord(gameType: .symbolRecognition, score: 100, totalQuestions: 8, correctAnswers: 8, duration: 90)
    ]
}

