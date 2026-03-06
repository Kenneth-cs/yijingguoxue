//
//  GuessGameView.swift
//  易经国学堂
//
//  Created on 2026/03/06.
//

import SwiftUI

struct GuessGameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameService = GameService.shared
    @EnvironmentObject var dataService: DataService
    
    @State private var selectedAnswer: String? = nil
    @State private var showingResult = false
    @State private var isCorrect = false
    
    // Constants for layout
    private let cardWidth: CGFloat = 200
    private let cardHeight: CGFloat = 240
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "F5F7F9")
                .ignoresSafeArea()
            
            if !gameService.isGameActive {
                // Game Start View
                gameStartView
            } else if let game = gameService.currentGame {
                if game.isFinished {
                    // Game Completion View
                    GameCompletionView(gameType: .memoryGame, game: game) {
                        gameService.startGame(type: .memoryGame)
                        selectedAnswer = nil
                        showingResult = false
                    } onExit: {
                        _ = gameService.endGame()
                        dismiss()
                    }
                } else {
                    // Game Playing View
                    VStack(spacing: 0) {
                        // Header
                        gameHeader(game: game)
                        
                        ScrollView {
                            VStack(spacing: 16) {
                                // Hexagram Card
                                if let question = game.currentQuestion,
                                   let hexagram = dataService.getHexagram(by: question.hexagramId) {
                                    
                                    VStack(spacing: 12) {
                                        // Card with Symbol（缩小高度以留出空间给按钮）
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color(hex: "F5F7F7"))
                                                .frame(width: 170, height: 180)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(hex: "086B52").opacity(0.05), lineWidth: 1)
                                                )
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white)
                                                .frame(width: 170, height: 155)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(Color(hex: "086B52").opacity(0.05), lineWidth: 1)
                                                )
                                                .offset(y: -12)
                                            
                                            // Hexagram Symbol
                                            HexagramSymbolView(hexagram: hexagram, size: 90, color: Color(hex: "086B52"))
                                                .offset(y: -12)
                                        }
                                        .frame(height: 190)
                                        
                                        VStack(spacing: 4) {
                                            Text("识其形，辩其义")
                                                .font(AppConstants.Fonts.medium(14))
                                                .foregroundColor(Color(hex: "086B52").opacity(0.8))
                                            
                                            Text("请选择正确的卦名")
                                                .font(AppConstants.Fonts.bold(18))
                                                .foregroundColor(Color(hex: "0F1729"))
                                        }
                                    }
                                    .padding(.top, 16)
                                    
                                    // Options
                                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                                        ForEach(question.options, id: \.self) { option in
                                            OptionCard(
                                                text: option,
                                                isSelected: selectedAnswer == option,
                                                isCorrect: option == question.correctAnswer,
                                                isWrong: selectedAnswer == option && option != question.correctAnswer,
                                                showResult: showingResult
                                            ) {
                                                if !showingResult {
                                                    selectedAnswer = option
                                                }
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.bottom, 8)
                        }
                        
                        // 提交按钮固定在底部，始终可见
                        if let question = gameService.currentGame?.currentQuestion {
                            VStack(spacing: 10) {
                                Button(action: submitAnswer) {
                                    Text(showingResult ? "下一题" : "提交答案")
                                        .font(AppConstants.Fonts.bold(16))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(selectedAnswer == nil && !showingResult ? Color(hex: "086B52").opacity(0.4) : Color(hex: "086B52"))
                                        )
                                }
                                .disabled(selectedAnswer == nil && !showingResult)
                                
                                if !showingResult {
                                    Button("跳过此题") {
                                        skipQuestion()
                                    }
                                    .font(AppConstants.Fonts.medium(14))
                                    .foregroundColor(Color(hex: "086B52").opacity(0.6))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .padding(.bottom, 16)
                            .background(Color(hex: "F5F7F9"))
                            // 使用 question.id 触发刷新，避免编译器警告
                            .id(question.id)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if !gameService.isGameActive {
                gameService.startGame(type: .memoryGame)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var gameStartView: some View {
        VStack(spacing: 30) {
            Image(systemName: "brain.head.profile")
                .font(.system(size: 80))
                .foregroundColor(Color(hex: "086B52"))
            
            Text("准备开始认卦游戏")
                .font(AppConstants.Fonts.bold(24))
            
            Button(action: {
                gameService.startGame(type: .memoryGame)
            }) {
                Text("开始游戏")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "086B52"))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 40)
        }
    }
    
    private func gameHeader(game: Game) -> some View {
        VStack(spacing: 0) {
            // Top Bar
            ZStack {
                HStack {
                    Button(action: {
                        _ = gameService.endGame()
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(hex: "0F1729"))
                    }
                    Spacer()
                }
                
                Text("认卦游戏")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(Color(hex: "0F1729"))
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            // Progress & Score
            HStack(alignment: .top) {
                // Progress
                VStack(alignment: .leading, spacing: 4) {
                    Text("当前进度")
                        .font(AppConstants.Fonts.medium(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.7))
                    
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text("\(game.currentQuestionIndex + 1)")
                            .font(AppConstants.Fonts.bold(24))
                            .foregroundColor(Color(hex: "0F1729"))
                        Text("/\(game.questions.count)")
                            .font(AppConstants.Fonts.regular(18))
                            .foregroundColor(Color(hex: "94A3B8"))
                    }
                }
                
                Spacer()
                
                // Score
                VStack(alignment: .trailing, spacing: 4) {
                    Text("当前得分")
                        .font(AppConstants.Fonts.medium(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.7))
                    
                    Text("\(game.score)")
                        .font(AppConstants.Fonts.bold(24))
                        .foregroundColor(Color(hex: "086B52"))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)
            
            // Progress Bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(hex: "086B52").opacity(0.1))
                        .frame(height: 8)
                    
                    Capsule()
                        .fill(Color(hex: "086B52"))
                        .frame(width: geometry.size.width * game.progress, height: 8)
                }
            }
            .frame(height: 8)
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .background(Color.white)
    }
    
    // MARK: - Logic
    
    private func submitAnswer() {
        if showingResult {
            // Next Question
            selectedAnswer = nil
            showingResult = false
            isCorrect = false
            
            if var game = gameService.currentGame {
                game.moveToNextQuestion()
                gameService.currentGame = game
                
                if game.isFinished {
                    _ = gameService.endGame()
                }
            }
        } else if let answer = selectedAnswer {
            // Check Answer
            isCorrect = gameService.answerQuestion(answer)
            showingResult = true
        }
    }
    
    private func skipQuestion() {
        gameService.skipQuestion()
        selectedAnswer = nil
        showingResult = false
        isCorrect = false
        
        if let game = gameService.currentGame, game.isFinished {
            _ = gameService.endGame()
        }
    }
}

// MARK: - Helper Views

struct OptionCard: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let showResult: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(borderColor, lineWidth: 1)
                    )
                
                Text(text)
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(textColor)
            }
            .frame(height: 64)
        }
        .disabled(showResult)
    }
    
    private var backgroundColor: Color {
        if showResult {
            if isCorrect { return Color.white } // Correct always white bg with green border? UI shows white bg
            if isWrong { return Color.white }
        }
        return isSelected ? Color(hex: "086B52").opacity(0.05) : Color.white
    }
    
    private var borderColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red.opacity(0.5) }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "086B52").opacity(0.1)
    }
    
    private var textColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "334155")
    }
}

struct GameCompletionView: View {
    let gameType: GameRecord.GameType
    let game: Game
    let onRestart: () -> Void
    let onExit: () -> Void
    
    var body: some View {
        let accuracy: Int = {
            let total = Double(game.questions.count)
            guard total > 0 else { return 0 }
            return Int((Double(game.correctCount) / total) * 100)
        }()
        
        return VStack(spacing: 30) {
            Image(systemName: "star.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
            
            VStack(spacing: 10) {
                Text("挑战完成！")
                    .font(AppConstants.Fonts.bold(28))
                
                Text("得分: \(game.score)")
                    .font(AppConstants.Fonts.bold(24))
                    .foregroundColor(Color(hex: "086B52"))
                
                Text("正确率: \(accuracy)%")
                    .font(AppConstants.Fonts.medium(16))
                    .foregroundColor(.secondary)
            }
            
            VStack(spacing: 16) {
                Button(action: onRestart) {
                    Text("再玩一次")
                        .font(AppConstants.Fonts.bold(18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "086B52"))
                        .cornerRadius(12)
                }
                
                Button(action: onExit) {
                    Text("返回")
                        .font(AppConstants.Fonts.medium(16))
                        .foregroundColor(Color(hex: "086B52"))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(hex: "086B52"), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 40)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .padding(20)
    }
}

// Color extension removed as it's defined in GuessGameView.swift and visible internally.
// Ideally it should be moved to Extensions.swift for clarity, but removing here solves ambiguity.


