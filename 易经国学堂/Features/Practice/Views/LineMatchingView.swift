//
//  LineMatchingView.swift
//  易经国学堂
//
//  Created on 2026/03/06.
//

import SwiftUI

struct LineMatchingView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameService = GameService.shared
    @EnvironmentObject var dataService: DataService
    
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
                        gameType: .lineMatch,
                        game: game,
                        onRestart: {
                            gameService.startGame(type: .lineMatch)
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
                                if let question = game.currentQuestion,
                                   let hexagram = dataService.getHexagram(by: question.hexagramId) {
                                    
                                    // Main Card
                                    VStack(spacing: 0) {
                                        // Hexagram Symbol with Highlight
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color(hex: "086B52").opacity(0.1))
                                                .frame(width: 132, height: 24)
                                            
                                            Text("当前卦象: \(hexagram.chineseName)")
                                                .font(AppConstants.Fonts.bold(12))
                                                .foregroundColor(Color(hex: "086B52"))
                                        }
                                        .padding(.top, 20)
                                        
                                        // Symbol
                                        HexagramSymbolView(
                                            hexagram: hexagram,
                                            size: 100,
                                            color: Color(hex: "086B52"),
                                            highlightPosition: question.linePosition,
                                            highlightColor: Color(hex: "F59E0B") // Highlight with Amber/Orange
                                        )
                                        .padding(.vertical, 20)
                                        
                                        // Question Text
                                        Text("\(hexagram.chineseName) 的第 \(question.linePosition ?? 0) 爻爻辞是？")
                                            .font(AppConstants.Fonts.bold(20))
                                            .foregroundColor(Color(hex: "086B52"))
                                            .multilineTextAlignment(.center)
                                            .padding(.bottom, 30)
                                            .padding(.horizontal, 20)
                                    }
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: Color(hex: "086B52").opacity(0.05), radius: 10, y: 8)
                                    .padding(.horizontal, 20)
                                    .padding(.top, 20)
                                    
                                    // Options List
                                    VStack(spacing: 16) {
                                        ForEach(Array(question.options.enumerated()), id: \.element) { index, option in
                                            let optionLabel = ["A", "B", "C", "D"][index % 4]
                                            LineOptionRow(
                                                label: optionLabel,
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
                                    
                                    // Action Buttons
                                    VStack(spacing: 16) {
                                        Button(action: submitAnswer) {
                                            Text(showingResult ? "下一题" : "提交答案")
                                                .font(AppConstants.Fonts.bold(18))
                                                .foregroundColor(.white)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 56)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 12)
                                                        .fill(selectedAnswer == nil && !showingResult ? Color.gray : Color(hex: "086B52"))
                                                )
                                        }
                                        .disabled(selectedAnswer == nil && !showingResult)
                                        
                                        if !showingResult {
                                            Button("跳过此题") {
                                                skipQuestion()
                                            }
                                            .font(AppConstants.Fonts.medium(14))
                                            .foregroundColor(Color(hex: "086B52"))
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 30)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            if !gameService.isGameActive {
                gameService.startGame(type: .lineMatch)
            }
        }
    }
    
    // MARK: - Subviews
    
    private var gameStartView: some View {
        VStack(spacing: 30) {
            Image(systemName: "link")
                .font(.system(size: 80))
                .foregroundColor(Color(hex: "086B52"))
            
            Text("准备开始爻辞配对")
                .font(AppConstants.Fonts.bold(24))
            
            Button(action: {
                gameService.startGame(type: .lineMatch)
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
                
                Text("爻辞配对")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(Color(hex: "0F1729"))
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            // Stats Row (Simplified for this view based on reference)
            // Reference doesn't show progress bar in header explicitly like others, but consistent header is good.
            // I'll keep consistent header style.
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

struct LineOptionRow: View {
    let label: String
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let isWrong: Bool
    let showResult: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 12) {
                // Label Circle (A, B, C, D)
                ZStack {
                    Circle()
                        .fill(labelBackgroundColor)
                        .frame(width: 24, height: 24)
                    
                    Text(label)
                        .font(AppConstants.Fonts.bold(12))
                        .foregroundColor(labelTextColor)
                }
                .padding(.top, 2)
                
                VStack(alignment: .leading, spacing: 4) {
                    // Main Text (Yao Ci)
                    // The text might contain "白话：..." part.
                    // Let's split it if needed or just display.
                    // GameService returns full line text.
                    // Reference shows "六四：..." then "白话：..."
                    // Hexagram.Line.text usually contains both if data is rich, or just Yao Ci.
                    // Assuming text is just Yao Ci for now, or full text.
                    // Let's display it as is.
                    Text(text)
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(Color(hex: "0F1729"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    // If we had translation separately we would show it here.
                    // For now, just the text.
                }
                
                Spacer()
                
                // Checkmark/Xmark
                if showResult {
                    if isCorrect {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color(hex: "086B52"))
                    } else if isWrong {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(16)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
        .disabled(showResult)
    }
    
    private var labelBackgroundColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red.opacity(0.1) }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "086B52").opacity(0.1)
    }
    
    private var labelTextColor: Color {
        if showResult {
            if isCorrect { return .white }
            if isWrong { return .red }
        }
        return isSelected ? .white : Color(hex: "086B52")
    }
    
    private var backgroundColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52").opacity(0.05) }
            if isWrong { return Color.white }
        }
        return isSelected ? Color(hex: "086B52").opacity(0.05) : Color.white
    }
    
    private var borderColor: Color {
        if showResult {
            if isCorrect { return Color(hex: "086B52") }
            if isWrong { return Color.red }
        }
        return isSelected ? Color(hex: "086B52") : Color(hex: "086B52").opacity(0.1)
    }
}
