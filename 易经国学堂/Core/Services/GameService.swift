//
//  GameService.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 游戏服务 - 负责游戏逻辑管理
class GameService: ObservableObject {
    
    // MARK: - Singleton
    static let shared = GameService()
    
    // MARK: - Published Properties
    @Published var currentGame: Game?
    @Published var isGameActive = false
    
    // MARK: - Private Properties
    private let dataService = DataService.shared
    private let storageService = StorageService.shared
    
    // MARK: - Initialization
    private init() {}
    
    // MARK: - Public Methods
    
    /// 开始新游戏
    func startGame(type: GameRecord.GameType, questionCount: Int = AppConstants.Game.defaultQuestionCount) {
        switch type {
        case .memoryGame:
            startMemoryGame(questionCount: questionCount)
        case .quiz:
            startQuizGame(questionCount: questionCount)
        case .symbolRecognition:
            startSymbolRecognitionGame(questionCount: questionCount)
        case .lineMatch:
            startLineMatchGame(questionCount: questionCount)
        }
        
        isGameActive = true
    }
    
    /// 回答问题
    func answerQuestion(_ answer: String) -> Bool {
        guard var game = currentGame else { return false }
        
        let isCorrect = game.checkAnswer(answer)
        game.recordAnswer(isCorrect: isCorrect)
        currentGame = game
        
        return isCorrect
    }
    
    /// 结束游戏并保存记录
    func endGame() -> GameRecord? {
        guard let game = currentGame else { return nil }
        
        let record = GameRecord(
            gameType: game.type,
            score: game.score,
            totalQuestions: game.questions.count,
            correctAnswers: game.correctCount,
            duration: Date().timeIntervalSince(game.startTime)
        )
        
        storageService.addGameRecord(record)
        
        currentGame = nil
        isGameActive = false
        
        return record
    }
    
    /// 跳过当前问题
    func skipQuestion() {
        guard var game = currentGame else { return }
        game.moveToNextQuestion()
        currentGame = game
    }
    
    // MARK: - Private Game Initialization Methods
    
    /// 开始认卦游戏
    private func startMemoryGame(questionCount: Int) {
        let hexagrams = dataService.getRandomHexagrams(count: questionCount)
        let questions = hexagrams.map { hexagram -> Question in
            // 生成3个随机的错误选项
            var options = [hexagram.name]
            let otherHexagrams = dataService.hexagrams.filter { $0.id != hexagram.id }.shuffled()
            options.append(contentsOf: otherHexagrams.prefix(3).map { $0.name })
            options.shuffle()
            
            return Question(
                id: UUID(),
                type: .multipleChoice,
                prompt: "这是哪一卦？",
                content: hexagram.symbol,
                correctAnswer: hexagram.name,
                options: options,
                hexagramId: hexagram.id,
                linePosition: nil
            )
        }
        
        currentGame = Game(type: .memoryGame, questions: questions)
    }
    
    /// 开始知识问答游戏
    private func startQuizGame(questionCount: Int) {
        let hexagrams = dataService.getRandomHexagrams(count: questionCount)
        let otherHexagrams = dataService.hexagrams // 全量用于生成干扰项
        
        let questions = hexagrams.map { hexagram -> Question in
            let questionTypes = ["卦名", "卦辞", "组成"]
            let selectedType = questionTypes.randomElement()!
            
            var prompt = ""
            var correctAnswer = ""
            var options: [String] = []
            
            let others = otherHexagrams.filter { $0.id != hexagram.id }.shuffled()
            
            switch selectedType {
            case "卦名":
                // 看卦辞猜卦名，4个选项
                prompt = "「\(hexagram.description.prefix(8))…」是哪一卦的卦辞？"
                correctAnswer = hexagram.chineseName
                var opts = [hexagram.chineseName]
                opts.append(contentsOf: others.prefix(3).map { $0.chineseName })
                options = opts.shuffled()
                
            case "卦辞":
                // 看卦名猜卦辞（取第一句），4个选项
                prompt = "\(hexagram.chineseName)的卦辞是？"
                let correct = String(hexagram.description.split(separator: "。").first ?? Substring(hexagram.description))
                correctAnswer = correct
                var opts = [correct]
                // 从其他卦取卦辞第一句作为干扰项
                let wrongs = others.prefix(3).compactMap { h -> String? in
                    let s = String(h.description.split(separator: "。").first ?? Substring(h.description))
                    return s.isEmpty ? nil : s
                }
                opts.append(contentsOf: wrongs)
                options = opts.shuffled()
                
            case "组成":
                // 看卦名猜八卦组成，4个选项
                prompt = "\(hexagram.chineseName)由哪两个经卦组成？"
                correctAnswer = hexagram.trigramDescription
                var opts = [hexagram.trigramDescription]
                // 从其他卦取组成描述作为干扰项，去重
                let wrongs = others
                    .map { $0.trigramDescription }
                    .filter { $0 != hexagram.trigramDescription }
                    .prefix(3)
                opts.append(contentsOf: wrongs)
                options = opts.shuffled()
                
            default:
                break
            }
            
            return Question(
                id: UUID(),
                type: .multipleChoice, // 始终4选1
                prompt: prompt,
                content: hexagram.symbol,
                correctAnswer: correctAnswer,
                options: options,
                hexagramId: hexagram.id,
                linePosition: nil
            )
        }
        
        currentGame = Game(type: .quiz, questions: questions)
    }
    
    /// 开始卦象识别游戏
    private func startSymbolRecognitionGame(questionCount: Int) {
        let hexagrams = dataService.getRandomHexagrams(count: questionCount)
        let questions = hexagrams.map { hexagram -> Question in
            var options = [hexagram.chineseName]
            let others = dataService.hexagrams.filter { $0.id != hexagram.id }.shuffled()
            options.append(contentsOf: others.prefix(3).map { $0.chineseName })
            options.shuffle()
            
            return Question(
                id: UUID(),
                type: .multipleChoice,
                prompt: "这是哪一卦？",
                content: hexagram.binary.toBinarySymbol(),
                correctAnswer: hexagram.chineseName,
                options: options,
                hexagramId: hexagram.id,
                linePosition: nil
            )
        }
        
        currentGame = Game(type: .symbolRecognition, questions: questions)
    }
    
    /// 开始爻辞配对游戏
    private func startLineMatchGame(questionCount: Int) {
        let hexagrams = dataService.getRandomHexagrams(count: questionCount)
        let questions = hexagrams.map { hexagram -> Question in
            // 随机选择一个爻
            let line = hexagram.lines.randomElement()!
            
            var options = [line.text]
            // 从其他卦象中随机选择爻辞作为干扰项
            let otherLines = dataService.hexagrams
                .filter { $0.id != hexagram.id }
                .shuffled()
                .prefix(3)
                .compactMap { $0.lines.randomElement()?.text }
            options.append(contentsOf: otherLines)
            options.shuffle()
            
            return Question(
                id: UUID(),
                type: .multipleChoice,
                prompt: "\(hexagram.chineseName) 的第\(line.position)爻爻辞是？",
                content: hexagram.symbol,
                correctAnswer: line.text,
                options: options,
                hexagramId: hexagram.id,
                linePosition: line.position
            )
        }
        
        currentGame = Game(type: .lineMatch, questions: questions)
    }
}

// MARK: - Game Model

struct Game {
    let type: GameRecord.GameType
    let questions: [Question]
    let startTime: Date
    
    var currentQuestionIndex = 0
    var correctCount = 0
    var score = 0
    var currentStreak = 0
    var maxStreak = 0
    
    init(type: GameRecord.GameType, questions: [Question]) {
        self.type = type
        self.questions = questions
        self.startTime = Date()
    }
    
    var currentQuestion: Question? {
        questions[safe: currentQuestionIndex]
    }
    
    var isFinished: Bool {
        currentQuestionIndex >= questions.count
    }
    
    var progress: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(currentQuestionIndex) / Double(questions.count)
    }
    
    mutating func checkAnswer(_ answer: String) -> Bool {
        guard let question = currentQuestion else { return false }
        return question.correctAnswer == answer
    }
    
    mutating func recordAnswer(isCorrect: Bool) {
        if isCorrect {
            correctCount += 1
            score += 10 // 每题10分
            currentStreak += 1
            if currentStreak > maxStreak {
                maxStreak = currentStreak
            }
        } else {
            currentStreak = 0
        }
        // 注意：不自动跳到下一题，让UI控制何时跳转
    }
    
    mutating func moveToNextQuestion() {
        currentQuestionIndex += 1
    }
}

// MARK: - Question Model

struct Question: Identifiable {
    let id: UUID
    let type: QuestionType
    let prompt: String          // 问题提示
    let content: String         // 问题内容（卦象符号等）
    let correctAnswer: String   // 正确答案
    let options: [String]       // 选项（用于选择题）
    let hexagramId: Int         // 关联的卦象ID
    let linePosition: Int?      // 关联的爻位（仅用于爻辞配对）
    
    enum QuestionType {
        case multipleChoice     // 选择题
        case text              // 文本输入题
        case trueOrFalse       // 判断题
    }
}

