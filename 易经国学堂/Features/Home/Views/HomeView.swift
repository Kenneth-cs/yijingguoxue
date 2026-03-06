//
//  HomeView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // 宣纸背景
                PaperBackground()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // 欢迎卡片
                        welcomeCard
                        
                        // 每日一卦
                        dailyHexagramCard
                        
                        // 学习进度
                        studyProgressCard
                        
                        // 快速入口
                        quickAccessSection
                    }
                    .padding(DeviceType.value(iPad: 24, iPhone: 16))
                    .centerContent()
                }
                .navigationTitle("易经国学堂")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.setup(dataService: dataService, storageService: storageService)
        }
    }
    
    // MARK: - Welcome Card (新中式)
    private var welcomeCard: some View {
        ZenCard(useAccentGradient: true, padding: 20) {
            HStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("欢迎学习易经")
                        .font(AppConstants.Fonts.title2)
                        .foregroundColor(AppConstants.Colors.textPrimary)
                    
                    Text("探索中华传统文化，领悟天地之道")
                        .font(AppConstants.Fonts.callout)
                        .foregroundColor(AppConstants.Colors.textSecondary)
                        .lineSpacing(4)
                }
                
                Spacer()
                
                // 装饰性图案
                TraditionalPattern(opacity: 0.15, size: 50)
            }
        }
    }
    
    // MARK: - Daily Hexagram Card (新中式)
    private var dailyHexagramCard: some View {
        Group {
            if let hexagram = viewModel.dailyHexagram {
                NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                    ZenCard(padding: 18) {
                        VStack(alignment: .leading, spacing: 14) {
                            // 标题栏
                            HStack {
                                HStack(spacing: 8) {
                                    Image(systemName: "calendar")
                                        .foregroundColor(AppConstants.Colors.cinnabar)
                                    Text("每日一卦")
                                        .font(AppConstants.Fonts.headline)
                                        .foregroundColor(AppConstants.Colors.textPrimary)
                                }
                                
                                Spacer()
                                
                                Text(Date().chineseDateString)
                                    .font(AppConstants.Fonts.caption)
                                    .foregroundColor(AppConstants.Colors.textSecondary)
                            }
                            
                            ZenDivider()
                            
                            // 卦象和信息
                            HStack(alignment: .center, spacing: 16) {
                                // 卦象符号带装饰
                                ZStack {
                                    Circle()
                                        .fill(AppConstants.Colors.symbolGradient)
                                        .frame(width: 75, height: 75)
                                    
                                    HexagramSymbolView(hexagram: hexagram, size: 40)
                                }
                                
                                // 卦象信息
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(hexagram.displayName)
                                        .font(AppConstants.Fonts.title3)
                                        .foregroundColor(AppConstants.Colors.textPrimary)
                                    
                                    Text(hexagram.description)
                                        .font(AppConstants.Fonts.subheadline)
                                        .foregroundColor(AppConstants.Colors.textSecondary)
                                        .lineLimit(2)
                                        .lineSpacing(4)
                                }
                                
                                Spacer()
                            }
                            
                            // 查看详情提示
                            HStack {
                                Spacer()
                                Text("点击查看详情")
                                    .font(AppConstants.Fonts.caption)
                                    .foregroundColor(AppConstants.Colors.cinnabar)
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(AppConstants.Colors.cinnabar)
                            }
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Text("加载中...")
                    .foregroundColor(AppConstants.Colors.textSecondary)
            }
        }
    }
    
    // MARK: - Study Progress Card (新中式)
    private var studyProgressCard: some View {
        ZenCard(padding: 18) {
            VStack(alignment: .leading, spacing: 14) {
                SectionHeader(
                    icon: "chart.bar.fill",
                    title: "学习进度",
                    iconColor: AppConstants.Colors.deepGreen
                )
                
                HStack(spacing: 16) {
                    ProgressStatItem(
                        title: "已学习",
                        value: "\(storageService.studyProgress.learnedHexagrams.count)",
                        total: "64",
                        icon: "book.fill",
                        color: AppConstants.Colors.indigo
                    )
                    
                    ProgressStatItem(
                        title: "已收藏",
                        value: "\(storageService.studyProgress.favoriteHexagrams.count)",
                        total: "",
                        icon: "star.fill",
                        color: AppConstants.Colors.gold
                    )
                    
                    ProgressStatItem(
                        title: "连续天数",
                        value: "\(storageService.studyProgress.studyDays)",
                        total: "天",
                        icon: "flame.fill",
                        color: AppConstants.Colors.cinnabar
                    )
                }
                
                // 进度条
                VStack(alignment: .leading, spacing: 6) {
                    ProgressView(value: Double(storageService.studyProgress.progressPercentage), total: 100)
                        .tint(AppConstants.Colors.cinnabar)
                        .scaleEffect(y: 1.5)
                    
                    Text("已完成 \(storageService.studyProgress.progressPercentage)%")
                        .font(AppConstants.Fonts.caption)
                        .foregroundColor(AppConstants.Colors.textSecondary)
                }
                .padding(.top, 4)
            }
        }
    }
    
    // MARK: - Quick Access Section
    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("快速入口")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: DeviceType.gridColumns), spacing: 15) {
                NavigationLink(destination: EncyclopediaView(initialSegment: 0)) {
                    QuickAccessButton(
                        title: "浏览卦象",
                        icon: "square.grid.2x2",
                        color: .blue
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: EncyclopediaView(initialSegment: 1)) {
                    QuickAccessButton(
                        title: "八卦基础",
                        icon: "circle.grid.3x3",
                        color: .green
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: PracticeView()) {
                    QuickAccessButton(
                        title: "认卦游戏",
                        icon: "gamecontroller",
                        color: .purple
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: FavoritesView()) {
                    QuickAccessButton(
                        title: "我的收藏",
                        icon: "star",
                        color: .orange
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

// MARK: - Progress Stat Item (新中式)
struct ProgressStatItem: View {
    let title: String
    let value: String
    let total: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 6) {
            // 图标
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18, weight: .semibold))
            }
            
            // 数值
            HStack(alignment: .bottom, spacing: 2) {
                Text(value)
                    .font(AppConstants.Fonts.title3)
                    .fontWeight(.bold)
                    .foregroundColor(AppConstants.Colors.textPrimary)
                
                if !total.isEmpty {
                    Text(total)
                        .font(AppConstants.Fonts.caption2)
                        .foregroundColor(AppConstants.Colors.textSecondary)
                        .padding(.bottom, 2)
                }
            }
            
            // 标题
            Text(title)
                .font(AppConstants.Fonts.caption)
                .foregroundColor(AppConstants.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Quick Access Button (新中式)
struct QuickAccessButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            // 图标圆形背景
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(color)
            }
            
            Text(title)
                .font(AppConstants.Fonts.subheadline)
                .fontWeight(.medium)
                .foregroundColor(AppConstants.Colors.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(AppConstants.Colors.cardBackground)
        .cornerRadius(AppConstants.UI.cardCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.UI.cardCornerRadius)
                .strokeBorder(color.opacity(0.2), lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(AppConstants.UI.shadowOpacity),
            radius: AppConstants.UI.cardShadowRadius,
            y: AppConstants.UI.cardShadowY
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

