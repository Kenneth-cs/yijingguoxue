//
//  StorageService.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation
import UIKit

/// 存储服务 - 负责本地数据持久化
class StorageService: ObservableObject {
    
    // MARK: - Singleton
    static let shared = StorageService()
    
    // MARK: - Published Properties
    @Published var studyProgress: StudyProgress {
        didSet {
            saveStudyProgress()
        }
    }
    
    @Published var gameRecords: [GameRecord] {
        didSet {
            saveGameRecords()
        }
    }
    
    @Published var studyNotes: [StudyNote] {
        didSet {
            saveStudyNotes()
        }
    }
    
    // MARK: - Private Properties
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Initialization
    private init() {
        // 加载学习进度
        self.studyProgress = userDefaults.getCodable(
            StudyProgress.self,
            forKey: AppConstants.StorageKeys.studyProgress
        ) ?? StudyProgress()
        
        // 加载游戏记录
        self.gameRecords = userDefaults.getCodable(
            [GameRecord].self,
            forKey: AppConstants.StorageKeys.gameRecords
        ) ?? []
        
        // 加载学习笔记
        self.studyNotes = userDefaults.getCodable(
            [StudyNote].self,
            forKey: AppConstants.StorageKeys.studyNotes
        ) ?? []
        
        print("✅ 存储服务初始化完成")
    }
    
    // MARK: - Study Progress Methods
    
    /// 标记卦象为已学习
    func markHexagramAsLearned(_ hexagramId: Int) {
        studyProgress.markAsLearned(hexagramId)
        studyProgress.updateStudyDays()
    }
    
    /// 切换收藏状态
    func toggleFavorite(_ hexagramId: Int) {
        studyProgress.toggleFavorite(hexagramId)
    }
    
    /// 检查是否已收藏
    func isFavorite(_ hexagramId: Int) -> Bool {
        studyProgress.isFavorite(hexagramId)
    }
    
    /// 检查是否已学习
    func isLearned(_ hexagramId: Int) -> Bool {
        studyProgress.isLearned(hexagramId)
    }
    
    /// 更新每日一卦
    func updateDailyHexagram(_ hexagramId: Int) {
        studyProgress.dailyHexagramId = hexagramId
        studyProgress.lastDailyUpdate = Date()
        saveStudyProgress()
    }
    
    /// 获取每日一卦ID（基于设备+日期生成稳定的卦象）
    func getDailyHexagramId() -> Int? {
        let calendar = Calendar.current
        
        // 检查缓存：如果是今天且已有卦象，直接返回（提高性能）
        if let lastUpdate = studyProgress.lastDailyUpdate,
           calendar.isDateInToday(lastUpdate),
           let dailyId = studyProgress.dailyHexagramId {
            return dailyId
        }
        
        // 生成新的每日一卦（基于设备ID + 日期）
        let newId = generateDailyHexagramId()
        updateDailyHexagram(newId)
        return newId
    }
    
    /// 基于设备UUID和日期生成稳定的卦象ID
    private func generateDailyHexagramId() -> Int {
        // 获取设备唯一标识符
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? "default-device"
        
        // 获取当前日期字符串（格式：yyyyMMdd）
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: Date())
        
        // 组合设备ID和日期
        let seed = "\(deviceId)-\(dateString)"
        
        // 使用哈希值生成1-64之间的卦象ID
        let hash = seed.hashValue
        let hexagramId = abs(hash % 64) + 1
        
        return hexagramId
    }
    
    /// 增加学习时长
    func addStudyTime(_ seconds: TimeInterval) {
        studyProgress.totalStudyTime += seconds
        saveStudyProgress()
    }
    
    // MARK: - Game Records Methods
    
    /// 添加游戏记录
    func addGameRecord(_ record: GameRecord) {
        gameRecords.insert(record, at: 0) // 最新的记录放在前面
        
        // 只保留最近100条记录
        if gameRecords.count > 100 {
            gameRecords = Array(gameRecords.prefix(100))
        }
    }
    
    /// 获取特定类型的游戏记录
    func getGameRecords(for gameType: GameRecord.GameType) -> [GameRecord] {
        gameRecords.filter { $0.gameType == gameType }
    }
    
    /// 获取游戏统计数据
    func getGameStatistics(for gameType: GameRecord.GameType) -> GameStatistics {
        let records = getGameRecords(for: gameType)
        guard !records.isEmpty else {
            return GameStatistics(totalGames: 0, averageScore: 0, averageAccuracy: 0, bestScore: 0)
        }
        
        let totalGames = records.count
        let averageScore = records.map { $0.score }.reduce(0, +) / totalGames
        let averageAccuracy = records.map { $0.accuracy }.reduce(0, +) / totalGames
        let bestScore = records.map { $0.score }.max() ?? 0
        
        return GameStatistics(
            totalGames: totalGames,
            averageScore: averageScore,
            averageAccuracy: averageAccuracy,
            bestScore: bestScore
        )
    }
    
    struct GameStatistics {
        let totalGames: Int
        let averageScore: Int
        let averageAccuracy: Int
        let bestScore: Int
    }
    
    /// 删除游戏记录
    func deleteGameRecord(_ record: GameRecord) {
        gameRecords.removeAll { $0.id == record.id }
    }
    
    /// 清空所有游戏记录
    func clearAllGameRecords() {
        gameRecords.removeAll()
    }
    
    // MARK: - Study Notes Methods
    
    /// 添加学习笔记
    func addNote(_ note: StudyNote) {
        studyNotes.insert(note, at: 0) // 最新的笔记放在前面
    }
    
    /// 添加学习笔记（别名）
    func addStudyNote(_ note: StudyNote) {
        addNote(note)
    }
    
    /// 更新学习笔记
    func updateNote(_ note: StudyNote) {
        if let index = studyNotes.firstIndex(where: { $0.id == note.id }) {
            studyNotes[index] = note
        }
    }
    
    /// 更新学习笔记（别名）
    func updateStudyNote(_ note: StudyNote) {
        updateNote(note)
    }
    
    /// 删除学习笔记
    func deleteNote(_ note: StudyNote) {
        studyNotes.removeAll { $0.id == note.id }
    }
    
    /// 删除学习笔记（别名）
    func deleteStudyNote(_ note: StudyNote) {
        deleteNote(note)
    }
    
    /// 获取特定卦象的笔记
    func getStudyNotes(for hexagramId: Int) -> [StudyNote] {
        studyNotes.filter { $0.hexagramId == hexagramId }
            .sorted { $0.updatedAt > $1.updatedAt }
    }
    
    // MARK: - Private Save Methods
    
    private func saveStudyProgress() {
        userDefaults.setCodable(studyProgress, forKey: AppConstants.StorageKeys.studyProgress)
    }
    
    private func saveGameRecords() {
        userDefaults.setCodable(gameRecords, forKey: AppConstants.StorageKeys.gameRecords)
    }
    
    private func saveStudyNotes() {
        userDefaults.setCodable(studyNotes, forKey: AppConstants.StorageKeys.studyNotes)
    }
    
    // MARK: - Clear Data
    
    /// 清空所有数据（用于测试或重置）
    func clearAllData() {
        studyProgress = StudyProgress()
        gameRecords.removeAll()
        studyNotes.removeAll()
        
        userDefaults.removeObject(forKey: AppConstants.StorageKeys.studyProgress)
        userDefaults.removeObject(forKey: AppConstants.StorageKeys.gameRecords)
        userDefaults.removeObject(forKey: AppConstants.StorageKeys.studyNotes)
        
        print("⚠️ 已清空所有本地数据")
    }
    
    /// 导出数据（用于备份）
    func exportData() -> [String: Any] {
        [
            "studyProgress": try? JSONEncoder().encode(studyProgress),
            "gameRecords": try? JSONEncoder().encode(gameRecords),
            "studyNotes": try? JSONEncoder().encode(studyNotes),
            "exportDate": Date()
        ].compactMapValues { $0 }
    }
}

