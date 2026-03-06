//
//  PracticeView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var storageService: StorageService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // 游戏选项
                    gameOptionsSection
                    
                    // 最近游戏记录
                    recentRecordsSection
                }
                .padding(DeviceType.value(iPad: 24, iPhone: 16))
                .centerContent()
            }
            .navigationTitle("互动练习")
            .background(Color(.systemGroupedBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Game Options Section
    private var gameOptionsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("选择游戏")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                GameOptionCard(
                    title: "认卦游戏",
                    description: "识别卦象符号",
                    icon: "brain.head.profile",
                    color: .blue,
                    gameType: .memoryGame
                )
                
                GameOptionCard(
                    title: "知识问答",
                    description: "测试易经知识",
                    icon: "questionmark.circle",
                    color: .green,
                    gameType: .quiz
                )
                
                GameOptionCard(
                    title: "卦象识别",
                    description: "识别卦名",
                    icon: "eye",
                    color: .purple,
                    gameType: .symbolRecognition
                )
                
                GameOptionCard(
                    title: "爻辞配对",
                    description: "匹配爻辞",
                    icon: "link",
                    color: .orange,
                    gameType: .lineMatch
                )
            }
        }
    }
    
    // MARK: - Recent Records Section
    private var recentRecordsSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("最近记录")
                    .font(.headline)
                
                Spacer()
                
                NavigationLink("查看全部", destination: GameRecordsView())
                    .font(.subheadline)
            }
            .padding(.horizontal)
            
            if storageService.gameRecords.isEmpty {
                Text("还没有游戏记录")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 40)
                    .background(Color(.systemBackground))
                    .cornerRadius(AppConstants.UI.cornerRadius)
            } else {
                VStack(spacing: 10) {
                    ForEach(storageService.gameRecords.prefix(3)) { record in
                        GameRecordRow(record: record)
                    }
                }
            }
        }
    }
}

// MARK: - Game Option Card
struct GameOptionCard: View {
    let title: String
    let description: String
    let icon: String
    let color: Color
    let gameType: GameRecord.GameType
    
    @State private var showingGame = false
    
    var body: some View {
        Button(action: { showingGame = true }) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(color)
                
                VStack(spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(Color(.systemBackground))
            .cornerRadius(AppConstants.UI.cornerRadius)
            .shadow(color: .black.opacity(0.05), radius: 5)
        }
        .sheet(isPresented: $showingGame) {
            GamePlayView(gameType: gameType)
        }
    }
}

// MARK: - Game Record Row
struct GameRecordRow: View {
    let record: GameRecord
    
    var body: some View {
        HStack {
            Image(systemName: record.gameType.icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(record.gameType.rawValue)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(record.formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(record.score)分")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text("\(record.accuracy)%正确")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
}

// MARK: - Game Play View
struct GamePlayView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameService = GameService.shared
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    
    let gameType: GameRecord.GameType
    
    @State private var selectedAnswer: String? = nil
    @State private var showingResult = false
    @State private var isCorrect = false
    @State private var showingCompletion = false
    @State private var gameRecord: GameRecord? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
                if !gameService.isGameActive {
                    gameStartView
                } else if let game = gameService.currentGame {
                    if game.isFinished {
                        gameCompletionView
                    } else {
                        gamePlayingView(game: game)
                    }
                }
            }
            .navigationTitle(gameType.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("退出") {
                        if gameService.isGameActive {
                            _ = gameService.endGame()
                        }
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            if !gameService.isGameActive {
                gameService.startGame(type: gameType)
            }
        }
    }
    
    // MARK: - Game Start View
    private var gameStartView: some View {
        VStack(spacing: 30) {
            Image(systemName: gameType.icon)
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            VStack(spacing: 10) {
                Text(gameType.rawValue)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("准备开始游戏")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Button(action: {
                gameService.startGame(type: gameType)
            }) {
                Text("开始游戏")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(AppConstants.UI.cornerRadius)
            }
            .padding(.horizontal, 40)
        }
    }
    
    // MARK: - Game Playing View
    private func gamePlayingView(game: Game) -> some View {
        VStack(spacing: 0) {
            // 进度条
            GameProgressBar(
                current: game.currentQuestionIndex + 1,
                total: game.questions.count,
                score: game.score
            )
            .padding()
            .centerContent()
            
            ScrollView {
                if let question = game.currentQuestion {
                    VStack(spacing: 25) {
                        // 问题内容
                        QuestionContentView(question: question)
                            .padding(.top, 20)
                        
                        // 答案选项
                        AnswerOptionsView(
                            question: question,
                            selectedAnswer: $selectedAnswer,
                            showingResult: showingResult,
                            isCorrect: isCorrect
                        )
                        .padding(.horizontal)
                        
                        // 提交按钮
                        Button(action: submitAnswer) {
                            Text(showingResult ? "下一题" : "提交答案")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedAnswer == nil && !showingResult ? Color.gray : Color.blue)
                                .cornerRadius(AppConstants.UI.cornerRadius)
                        }
                        .disabled(selectedAnswer == nil && !showingResult)
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        // 跳过按钮
                        if !showingResult {
                            Button("跳过此题") {
                                skipQuestion()
                            }
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                        }
                    }
                    .padding(.bottom, 30)
                    .padding(.horizontal, DeviceType.isPad ? 40 : 0)
                    .centerContent()
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Game Completion View
    private var gameCompletionView: some View {
        VStack(spacing: 30) {
            Image(systemName: "star.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
            
            VStack(spacing: 10) {
                Text("游戏完成！")
                    .font(.title)
                    .fontWeight(.bold)
                
                if let game = gameService.currentGame {
                    VStack(spacing: 8) {
                        Text("得分: \(game.score)分")
                            .font(.title2)
                            .foregroundColor(.blue)
                        
                        Text("正确率: \(game.correctCount)/\(game.questions.count)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        let accuracy = Double(game.correctCount) / Double(game.questions.count) * 100
                        Text(String(format: "%.0f%%", accuracy))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            VStack(spacing: 15) {
                Button(action: {
                    gameService.startGame(type: gameType)
                    selectedAnswer = nil
                    showingResult = false
                }) {
                    Text("再玩一次")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(AppConstants.UI.cornerRadius)
                }
                
                Button(action: {
                    _ = gameService.endGame()
                    dismiss()
                }) {
                    Text("返回")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(AppConstants.UI.cornerRadius)
                }
            }
            .padding(.horizontal, 40)
        }
    }
    
    // MARK: - Helper Methods
    private func submitAnswer() {
        if showingResult {
            // 显示结果后，进入下一题
            selectedAnswer = nil
            showingResult = false
            isCorrect = false
            
            // 移动到下一题（不要使用skipQuestion，它会跳过题目）
            if var game = gameService.currentGame {
                game.moveToNextQuestion()
                gameService.currentGame = game
                
                // 检查游戏是否完成
                if game.isFinished {
                    _ = gameService.endGame()
                }
            }
        } else if let answer = selectedAnswer {
            // 提交答案 - 显示正确/错误反馈
            isCorrect = gameService.answerQuestion(answer)
            showingResult = true
            
            // 注意：不立即跳转，让用户看到反馈
        }
    }
    
    private func skipQuestion() {
        selectedAnswer = nil
        showingResult = false
        isCorrect = false
        
        // 跳过当前题目
        if var game = gameService.currentGame {
            game.moveToNextQuestion()
            gameService.currentGame = game
            
            if game.isFinished {
                _ = gameService.endGame()
            }
        }
    }
}

// MARK: - Game Progress Bar
struct GameProgressBar: View {
    let current: Int
    let total: Int
    let score: Int
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("题目 \(current)/\(total)")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text("\(score)分")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                        .cornerRadius(4)
                    
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: geometry.size.width * (Double(current - 1) / Double(total)), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

// MARK: - Question Content View
struct QuestionContentView: View {
    let question: Question
    @EnvironmentObject var dataService: DataService
    
    var body: some View {
        VStack(spacing: 20) {
            // 问题提示
            Text(question.prompt)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            // 问题内容（卦象符号显示）
            if let hexagram = dataService.getHexagram(by: question.hexagramId) {
                // 使用垂直卦象视图
                HexagramSymbolView(hexagram: hexagram, size: 140)
                    .padding(.horizontal)
            } else {
                // 降级方案：使用文本显示
                Text(question.content)
                    .font(.system(size: 60, weight: .light))
                    .foregroundColor(.primary)
                    .padding(30)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .cornerRadius(AppConstants.UI.cornerRadius)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                    .padding(.horizontal)
            }
        }
    }
}

// MARK: - Answer Options View
struct AnswerOptionsView: View {
    let question: Question
    @Binding var selectedAnswer: String?
    let showingResult: Bool
    let isCorrect: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(question.options, id: \.self) { option in
                AnswerOptionButton(
                    option: option,
                    isSelected: selectedAnswer == option,
                    showingResult: showingResult,
                    isCorrectAnswer: option == question.correctAnswer,
                    isUserAnswer: selectedAnswer == option
                ) {
                    if !showingResult {
                        selectedAnswer = option
                    }
                }
            }
        }
    }
}

// MARK: - Answer Option Button
struct AnswerOptionButton: View {
    let option: String
    let isSelected: Bool
    let showingResult: Bool
    let isCorrectAnswer: Bool
    let isUserAnswer: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if showingResult {
            if isCorrectAnswer {
                return Color.green.opacity(0.2)
            } else if isUserAnswer {
                return Color.red.opacity(0.2)
            }
        } else if isSelected {
            return Color.blue.opacity(0.2)
        }
        return Color(.systemBackground)
    }
    
    var borderColor: Color {
        if showingResult {
            if isCorrectAnswer {
                return Color.green
            } else if isUserAnswer {
                return Color.red
            }
        } else if isSelected {
            return Color.blue
        }
        return Color(.systemGray4)
    }
    
    var icon: String? {
        if showingResult {
            if isCorrectAnswer {
                return "checkmark.circle.fill"
            } else if isUserAnswer {
                return "xmark.circle.fill"
            }
        }
        return nil
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(option)
                    .font(.body)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if let iconName = icon {
                    Image(systemName: iconName)
                        .foregroundColor(isCorrectAnswer ? .green : .red)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(AppConstants.UI.cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: AppConstants.UI.cornerRadius)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(showingResult)
    }
}

// MARK: - Game Records View
struct GameRecordsView: View {
    @EnvironmentObject var storageService: StorageService
    
    var body: some View {
        List {
            ForEach(storageService.gameRecords) { record in
                GameRecordDetailRow(record: record)
            }
        }
        .navigationTitle("游戏记录")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameRecordDetailRow: View {
    let record: GameRecord
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(record.gameType.rawValue)
                    .font(.headline)
                
                Spacer()
                
                Text(record.rating)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(record.ratingColor).opacity(0.2))
                    .foregroundColor(Color(record.ratingColor))
                    .cornerRadius(4)
            }
            
            HStack {
                Label("\(record.correctAnswers)/\(record.totalQuestions)", systemImage: "checkmark.circle")
                Label("\(record.score)分", systemImage: "star.fill")
                Label(record.formattedDuration, systemImage: "clock")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            Text(record.formattedDate)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    PracticeView()
        .environmentObject(StorageService.shared)
}

