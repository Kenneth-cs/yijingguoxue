//
//  SymbolGameView.swift
//  易经国学堂
//
//  Created on 2026/03/06.
//

import SwiftUI

struct SymbolGameView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameService = GameService.shared
    @EnvironmentObject var dataService: DataService
    
    @State private var selectedAnswer: String? = nil
    @State private var showingResult = false
    @State private var isCorrect = false
    
    // Timer state
    @State private var timeRemaining = 15
    @State private var timer: Timer? = nil
    @State private var isActive = false
    
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
                        gameType: .symbolRecognition,
                        game: game,
                        onRestart: {
                            gameService.startGame(type: .symbolRecognition)
                            selectedAnswer = nil
                            showingResult = false
                            resetTimer()
                        },
                        onExit: {
                            stopTimer()
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
                                // Stats Cards (Timer & Accuracy)
                                HStack(spacing: 16) {
                                    // Timer Card
                                    VStack(spacing: 8) {
                                        Text("剩余时间")
                                            .font(AppConstants.Fonts.bold(10))
                                            .foregroundColor(Color(hex: "64748B"))
                                        
                                        Text(String(format: "00:%02d", timeRemaining))
                                            .font(AppConstants.Fonts.bold(20))
                                            .foregroundColor(timeRemaining < 5 ? .red : Color(hex: "086B52"))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color(hex: "086B52").opacity(0.05))
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(hex: "086B52").opacity(0.1), lineWidth: 1)
                                    )
                                    
                                    // Accuracy Card
                                    VStack(spacing: 8) {
                                        Text("准确性")
                                            .font(AppConstants.Fonts.bold(10))
                                            .foregroundColor(Color(hex: "64748B"))
                                        
                                        let accuracy = game.questions.count > 0 ? Int(Double(game.correctCount) / Double(max(1, game.currentQuestionIndex)) * 100) : 0
                                        Text("\(accuracy)%")
                                            .font(AppConstants.Fonts.bold(20))
                                            .foregroundColor(Color(hex: "0F1729"))
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(Color(hex: "F1F5F9"))
                                    .cornerRadius(12)
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 20)
                                
                                if let question = game.currentQuestion,
                                   let hexagram = dataService.getHexagram(by: question.hexagramId) {
                                    
                                    // Main Card（缩小卦象区域高度）
                                    VStack(spacing: 16) {
                                        // Hexagram Symbol
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 20)
                                                .fill(Color.white)
                                                .shadow(color: Color(hex: "086B52").opacity(0.05), radius: 10, y: 8)
                                            
                                            VStack(spacing: 16) {
                                                // Binary Symbol（缩小size从160到110）
                                                HexagramSymbolView(hexagram: hexagram, size: 110, color: Color(hex: "0F1729"))
                                                
                                                VStack(spacing: 6) {
                                                    Text("STEP \(game.currentQuestionIndex + 1)")
                                                        .font(AppConstants.Fonts.bold(10))
                                                        .foregroundColor(Color(hex: "086B52"))
                                                        .padding(.horizontal, 12)
                                                        .padding(.vertical, 4)
                                                        .background(Color(hex: "086B52").opacity(0.1))
                                                        .cornerRadius(12)
                                                    
                                                    Text("快速识别当前卦象")
                                                        .font(AppConstants.Fonts.medium(14))
                                                        .foregroundColor(Color(hex: "94A3B8"))
                                                }
                                            }
                                            .padding(.vertical, 20)
                                        }
                                        .frame(height: 240)
                                        .padding(.horizontal, 20)
                                        
                                        // Options Grid
                                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
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
                                                        submitAnswer()
                                                    }
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 20)
                                        
                                        // Skip Button
                                        if !showingResult {
                                            Button("跳过此题") {
                                                skipQuestion()
                                            }
                                            .font(AppConstants.Fonts.medium(16))
                                            .foregroundColor(Color(hex: "086B52").opacity(0.6))
                                            .padding(.top, 10)
                                            .padding(.bottom, 30)
                                        }
                                    }
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
                gameService.startGame(type: .symbolRecognition)
                resetTimer()
            }
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    // MARK: - Subviews
    
    private var gameStartView: some View {
        VStack(spacing: 30) {
            Image(systemName: "eye")
                .font(.system(size: 80))
                .foregroundColor(Color(hex: "086B52"))
            
            Text("准备开始卦象识别")
                .font(AppConstants.Fonts.bold(24))
            
            Button(action: {
                gameService.startGame(type: .symbolRecognition)
                resetTimer()
            }) {
                Text("开始挑战")
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
                        stopTimer()
                        _ = gameService.endGame()
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(Color(hex: "0F1729"))
                    }
                    Spacer()
                }
                
                Text("卦象识别挑战")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(Color(hex: "0F1729"))
            }
            .padding(.horizontal, 16)
            .frame(height: 44)
            
            // Progress & Streak
            HStack(alignment: .top) {
                // Progress
                VStack(alignment: .leading, spacing: 4) {
                    Text("当前进度")
                        .font(AppConstants.Fonts.medium(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.7))
                    
                    HStack(alignment: .lastTextBaseline, spacing: 2) {
                        Text(String(format: "%02d", game.currentQuestionIndex + 1))
                            .font(AppConstants.Fonts.bold(24))
                            .foregroundColor(Color(hex: "0F1729"))
                        Text("/ \(game.questions.count)")
                            .font(AppConstants.Fonts.regular(14))
                            .foregroundColor(Color(hex: "94A3B8"))
                    }
                }
                
                Spacer()
                
                // Streak
                VStack(alignment: .trailing, spacing: 4) {
                    Text("连胜纪录")
                        .font(AppConstants.Fonts.medium(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.7))
                    
                    HStack(spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "086B52"))
                        Text("\(game.maxStreak)") // Using maxStreak or currentStreak? Reference says "连胜纪录" which usually means max streak or current streak. Let's use currentStreak for "Combo" feel or maxStreak for record. Reference shows "5" with bolt. Let's assume current streak.
                            .font(AppConstants.Fonts.bold(24))
                            .foregroundColor(Color(hex: "086B52"))
                    }
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
    
    private func startTimer() {
        stopTimer()
        isActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // Time's up!
                handleTimeout()
            }
        }
    }
    
    private func stopTimer() {
        isActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func resetTimer() {
        timeRemaining = 15 // 15 seconds per question
        startTimer()
    }
    
    private func handleTimeout() {
        stopTimer()
        // Treat as wrong answer or skip
        isCorrect = false
        showingResult = true
        
        // Auto move next after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            nextQuestion()
        }
    }
    
    private func submitAnswer() {
        stopTimer()
        if let answer = selectedAnswer {
            isCorrect = gameService.answerQuestion(answer)
            showingResult = true
            
            // Auto move next after delay for speed game feel
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                nextQuestion()
            }
        }
    }
    
    private func skipQuestion() {
        stopTimer()
        gameService.skipQuestion()
        nextQuestion()
    }
    
    private func nextQuestion() {
        selectedAnswer = nil
        showingResult = false
        isCorrect = false
        
        if var game = gameService.currentGame {
            game.moveToNextQuestion()
            gameService.currentGame = game
            
            if game.isFinished {
                _ = gameService.endGame()
            } else {
                resetTimer()
            }
        }
    }
}
