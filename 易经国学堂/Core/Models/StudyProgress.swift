//
//  StudyProgress.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 学习进度模型
struct StudyProgress: Codable {
    var learnedHexagrams: Set<Int>   // 已学习的卦象ID
    var favoriteHexagrams: Set<Int>  // 收藏的卦象ID
    var studyDays: Int               // 连续学习天数
    var lastStudyDate: Date?         // 最后学习日期
    var totalStudyTime: TimeInterval // 总学习时长（秒）
    var dailyHexagramId: Int?        // 今日一卦的ID
    var lastDailyUpdate: Date?       // 上次更新每日一卦的日期
    
    init() {
        self.learnedHexagrams = []
        self.favoriteHexagrams = []
        self.studyDays = 0
        self.lastStudyDate = nil
        self.totalStudyTime = 0
        self.dailyHexagramId = nil
        self.lastDailyUpdate = nil
    }
    
    /// 标记卦象为已学习
    mutating func markAsLearned(_ hexagramId: Int) {
        learnedHexagrams.insert(hexagramId)
    }
    
    /// 切换收藏状态
    mutating func toggleFavorite(_ hexagramId: Int) {
        if favoriteHexagrams.contains(hexagramId) {
            favoriteHexagrams.remove(hexagramId)
        } else {
            favoriteHexagrams.insert(hexagramId)
        }
    }
    
    /// 检查是否已收藏
    func isFavorite(_ hexagramId: Int) -> Bool {
        favoriteHexagrams.contains(hexagramId)
    }
    
    /// 检查是否已学习
    func isLearned(_ hexagramId: Int) -> Bool {
        learnedHexagrams.contains(hexagramId)
    }
    
    /// 更新学习天数
    mutating func updateStudyDays() {
        let calendar = Calendar.current
        let today = Date()
        
        if let lastDate = lastStudyDate {
            if calendar.isDateInToday(lastDate) {
                // 今天已经学习过，不增加天数
                return
            } else if calendar.isDateInYesterday(lastDate) {
                // 昨天学习过，连续天数+1
                studyDays += 1
            } else {
                // 中断了，重新开始
                studyDays = 1
            }
        } else {
            // 第一次学习
            studyDays = 1
        }
        
        lastStudyDate = today
    }
    
    /// 学习进度百分比（0-100）
    var progressPercentage: Int {
        let total = 64
        let learned = learnedHexagrams.count
        return Int((Double(learned) / Double(total)) * 100)
    }
    
    /// 获取格式化的学习时长
    var formattedStudyTime: String {
        let hours = Int(totalStudyTime) / 3600
        let minutes = (Int(totalStudyTime) % 3600) / 60
        
        if hours > 0 {
            return "\(hours)小时\(minutes)分钟"
        } else {
            return "\(minutes)分钟"
        }
    }
}

// MARK: - 示例数据
extension StudyProgress {
    static let example: StudyProgress = {
        var progress = StudyProgress()
        progress.learnedHexagrams = [1, 2, 3, 4, 5]
        progress.favoriteHexagrams = [1, 2]
        progress.studyDays = 7
        progress.lastStudyDate = Date()
        progress.totalStudyTime = 3600 // 1小时
        progress.dailyHexagramId = 1
        progress.lastDailyUpdate = Date()
        return progress
    }()
}

