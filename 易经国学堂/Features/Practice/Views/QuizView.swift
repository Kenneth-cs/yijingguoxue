//
//  QuizView.swift
//  易经国学堂
//
//  Created on 2026/03/06.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameService = GameService.shared
    
    @State private var selectedAnswer: String? = nil
    @State private var showingResult = false
    @State private var isCorrect = false
    
    var body: some View {
        ZStack {
            // Background
            Color(hex: "F5F7F9")
                .ignoresSafeArea()
            
            if !gameService.isGameActive {
                gameStartView
            } else if let game = gameService.currentGame {
                if game.isFinished {
                    GameCompletionView(
                        gameType: .quiz,
                        game: game,
                        onRestart: {
                            gameService.startGame(type: .quiz)
                            selectedAnswer = nil
                            showingResult = false
                        },
                        onExit: {
                            _ = gameService.endGame()
                            dismiss()
                        }
                    )
                } else {
                    VStack(spacing: 0) {
                        // Header
                        gameHeader(game: game)
                        
                        ScrollView {
                            VStack(spacing: 24) {
                                if let question = game.currentQuestion {
                                    // Question Card
                                    VStack(alignment: .leading, spacing: 20) {
                                        // Tag
                                        Text("单选题")
                                            .font(AppConstants.Fonts.medium(14))
                                            .foregroundColor(Color(hex: "086B52").opacity(0.6))
                                            .tracking(1.4)
                                        
                                        // Content
                                        VStack(alignment: .center, spacing: 24) {
                                            if !question.content.isEmpty && question.content.contains("¦") {
                                                 // If content is a symbol (though usually quiz is text based based on prompts)
                                                // For quiz, content might be symbol but prompt is text.
                                                // Check GameService: quiz prompt is text like "大壮：利贞", content is symbol.
                                                Text(question.prompt)
                                                    .font(AppConstants.Fonts.bold(24))
                                                    .foregroundColor(Color(hex: "1F2937"))
                                                    .multilineTextAlignment(.center)
                                                    .lineSpacing(10)
                                            } else {
                                                // Prompt is the main question
                                                Text(question.prompt)
                                                    .font(AppConstants.Fonts.bold(24))
                                                    .foregroundColor(Color(hex: "1F2937"))
                                                    .multilineTextAlignment(.center)
                                                    .lineSpacing(10)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 20)
                                    }
                                    .padding(24)
                                    .background(Color(hex: "086B52").opacity(0.05))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(hex: "086B52").opacity(0.05), lineWidth: 1)
                                    )
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    
                                    // Options
                                    VStack(spacing: 16) {
                                        ForEach(question.options, id: \.self) { option in
                                            QuizOptionRow(
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
                                    
                                    // Navigation Buttons
                                    HStack(spacing: 16) {
//                                        Button(action: {
//                                            // Previous question logic not supported by GameService yet easily without index manipulation
//                                            // Skip for now as per design "Previous" might just be visual in some flows or needs service update
//                                            // The reference UI shows "Previous", but GameService moves forward.
//                                            // We will implement "Submit/Next" logic mainly.
//                                        }) {
//                                            Text("上一题")
//                                                .font(AppConstants.Fonts.bold(16))
//                                                .foregroundColor(Color(hex: "086B52"))
//                                                .frame(maxWidth: .infinity)
//                                                .frame(height: 56)
//                                                .overlay(
//                                                    RoundedRectangle(cornerRadius: 12)
//                                                        .stroke(Color(hex: "086B52"), lineWidth: 1)
//                                                )
//                                        }
                                        
                                        Button(action: submitAnswer) {
                                            Text(showingResult ? "下一题" : "提交答案")
                                                .font(AppConstants.Fonts.bold(16))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 56)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedAnswer == nil && !showingResult ? Color.gray : Color(hex: "086B52"))
                                                )
                                        }
                                        .disabled(selectedAnswer == nil && !showingResult)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    
                                    if !showingResult {
                                        Button("跳过此题") {
                                            skipQuestion()
                                        }
                                        .font(AppConstants.Fonts.medium(16))
                                        .foregroundColor(Color(hex: "086B52").opacity(0.6))
                                        .padding(.bottom, 30)
                                    }
                                }
                            }
                            .padding(.bottom, 40)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if !gameService.isGameActive {
                gameService.startGame(type: .quiz)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var gameStartView: some View {
        VStack(spacing: 30) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 80))
                .foregroundColor(Color(hex: "086B52"))
            
            Text("准备开始知识问答")
                .font(AppConstants.Fonts.bold(24))
            
            Button(action: {
                gameService.startGame(type: .quiz)
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
                
                Text("知识问答")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(Color(hex: "0F1729"))
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            // Stats Row
            HStack(spacing: 0) {
                // Progress
                HStack(alignment: .lastTextBaseline, spacing: 2) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("当前进度")
                            .font(AppConstants.Fonts.medium(12))
                            .foregroundColor(Color(hex: "086B52").opacity(0.7))
                        
                        HStack(alignment: .lastTextBaseline, spacing: 2) {
                            Text(String(format: "%02d", game.currentQuestionIndex + 1))
                                .font(AppConstants.Fonts.bold(24))
                                .foregroundColor(Color(hex: "086B52"))
                            Text("/ \(game.questions.count)")
                                .font(AppConstants.Fonts.regular(14))
                                .foregroundColor(Color(hex: "94A3B8"))
                        }
                    }
                }
                
                Spacer()
                
                // Score
                VStack(alignment: .leading, spacing: 4) {
                    Text("当前得分")
                        .font(AppConstants.Fonts.medium(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.7))
                    
                    Text("\(game.score)")
                        .font(AppConstants.Fonts.bold(24))
                        .foregroundColor(Color(hex: "086B52"))
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            
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

struct QuizOptionRow: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let showResult: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                // Radio Button / Icon
                ZStack {
                    Circle()
                        .stroke(borderColor, lineWidth: 1)
                        .frame(width: 24, height: 24)
                        .background(Circle().fill(isSelected || isCorrect || isWrong ? borderColor : Color.clear))
                    
                    if showResult {
                        if isCorrect {
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        } else if isWrong {
                            Image(systemName: "xmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                    } else if isSelected {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 8, height: 8)
                    }
                }
                
                Text(text)
                    .font(AppConstants.Fonts.medium(16))
                    .foregroundColor(textColor)
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 18)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor.opacity(showResult ? 1.0 : 0.2), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
        .disabled(showResult)
    }
    
    private var backgroundColor: Color {
        if showResult {
            if isCorrect { return Color.white }
            if isWrong { return Color.white }
        }
        return isSelected ? Color(hex: "086B52").opacity(0.05) : Color.white
    }
    
    private var borderColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "086B52")
    }
    
    private var textColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "334155")
    }
}
