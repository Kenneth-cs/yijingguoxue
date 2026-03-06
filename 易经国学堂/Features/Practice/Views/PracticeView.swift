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
            ZStack {
                Color(hex: "F5F7F9")
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Banner
                        dailyChallengeBanner
                        
                        // Game Options
                        gameOptionsSection
                        
                        // Recent Records
                        recentRecordsSection
                    }
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("练习中心")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Banner
    private var dailyChallengeBanner: some View {
        ZStack(alignment: .leading) {
            // Background Image
            Image("PracticeBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)
            
            // Overlay Gradient for text readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.transparent]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(12)
            
            // Content
            VStack(alignment: .leading, spacing: 12) {
                Text("开启每日挑战")
                    .font(AppConstants.Fonts.bold(24))
                    .foregroundColor(.white)
                
                Text("通过趣味练习巩固易经知识，提升感悟。")
                    .font(AppConstants.Fonts.medium(14))
                    .foregroundColor(.white.opacity(0.9))
                    .lineLimit(2)
                
                Button(action: {
                    // Start a random game or specific challenge
                    // For now, let's start Symbol Recognition as "Daily Challenge"
                    // Or maybe push a random game view.
                    // Since we can't easily push from here without NavigationLink or state,
                    // let's just make it visual for now or link to one game.
                }) {
                    Text("开始挑战")
                        .font(AppConstants.Fonts.bold(14))
                        .foregroundColor(Color(hex: "086B52"))
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.top, 8)
            }
            .padding(24)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .shadow(color: Color.black.opacity(0.1), radius: 10, y: 5)
    }
    
// MARK: - Game Options Section
    private var gameOptionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("专项练习")
                .font(AppConstants.Fonts.bold(20))
                .foregroundColor(Color(hex: "0F1729"))
                .padding(.horizontal, 16)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                // 认卦游戏
                NavigationLink(destination: GuessGameView()) {
                    GameOptionCard(
                        title: "认卦游戏",
                        subtitle: "识别六十四卦象",
                        icon: "square.grid.2x2", // Using SF Symbol as placeholder for custom icon
                        color: Color(hex: "086B52")
                    )
                }
                
                // 知识问答
                NavigationLink(destination: QuizView()) {
                    GameOptionCard(
                        title: "知识问答",
                        subtitle: "经传理论考核",
                        icon: "questionmark.circle",
                        color: Color(hex: "086B52")
                    )
                }
                
                // 卦象识别
                NavigationLink(destination: SymbolGameView()) {
                    GameOptionCard(
                        title: "卦象识别",
                        subtitle: "快速分辨阴阳爻",
                        icon: "eye",
                        color: Color(hex: "086B52")
                    )
                }
                
                // 爻辞配对
                NavigationLink(destination: LineMatchingView()) {
                    GameOptionCard(
                        title: "爻辞匹对", // UI uses "匹对"
                        subtitle: "对应位阶与涵义",
                        icon: "list.dash",
                        color: Color(hex: "086B52")
                    )
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    // MARK: - Recent Records Section
    private var recentRecordsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("最近记录")
                    .font(AppConstants.Fonts.bold(20))
                    .foregroundColor(Color(hex: "0F1729"))
                
                Spacer()
                
                NavigationLink(destination: GameRecordsView()) {
                    Text("查看全部")
                        .font(AppConstants.Fonts.medium(14))
                        .foregroundColor(Color(hex: "086B52"))
                }
            }
            .padding(.horizontal, 16)
            
            if storageService.gameRecords.isEmpty {
                Text("暂无记录")
                    .font(AppConstants.Fonts.regular(14))
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
            } else {
                VStack(spacing: 12) {
                    ForEach(storageService.gameRecords.prefix(3)) { record in
                        GameRecordRow(record: record)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Helper Views

struct GameOptionCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(AppConstants.Fonts.bold(16))
                    .foregroundColor(Color(hex: "0F1729"))
                
                Text(subtitle)
                    .font(AppConstants.Fonts.regular(12))
                    .foregroundColor(Color(hex: "64748B"))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
    }
}

// Extension for transparent color
extension Color {
    static let transparent = Color.white.opacity(0)
}

// MARK: - Game Record Row
struct GameRecordRow: View {
    let record: GameRecord
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color(hex: "086B52").opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: record.gameType.icon)
                    .font(.system(size: 18))
                    .foregroundColor(Color(hex: "086B52"))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.gameType.rawValue)
                    .font(AppConstants.Fonts.bold(16))
                    .foregroundColor(Color(hex: "0F1729"))
                
                Text(record.formattedDate)
                    .font(AppConstants.Fonts.regular(12))
                    .foregroundColor(Color(hex: "64748B"))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(record.score)分")
                    .font(AppConstants.Fonts.bold(16))
                    .foregroundColor(Color(hex: "086B52"))
                
                if record.accuracy > 0 {
                    Text("\(record.accuracy)% 正确")
                        .font(AppConstants.Fonts.regular(12))
                        .foregroundColor(Color(hex: "64748B"))
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, y: 2)
    }
}

// MARK: - Game Records View
struct GameRecordsView: View {
    @EnvironmentObject var storageService: StorageService
    
    var body: some View {
        ZStack {
            Color(hex: "F5F7F9")
                .ignoresSafeArea()
            
            if storageService.gameRecords.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(Color(hex: "94A3B8"))
                    Text("暂无游戏记录")
                        .font(AppConstants.Fonts.medium(16))
                        .foregroundColor(Color(hex: "64748B"))
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(storageService.gameRecords) { record in
                            GameRecordRow(record: record)
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("游戏记录")
        .navigationBarTitleDisplayMode(.inline)
    }
}
