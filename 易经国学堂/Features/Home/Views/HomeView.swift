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
            ScrollView {
                VStack(spacing: AppConstants.UI.sectionSpacing) {
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
            .background(AppConstants.Colors.background)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.setup(dataService: dataService, storageService: storageService)
        }
    }
    
    // MARK: - Welcome Card (易经主题设计)
    private var welcomeCard: some View {
        ZStack {
            // 背景渐变
            AppConstants.Colors.primaryGradient
            
            // 装饰性八卦图案（半透明）
            HStack {
                Spacer()
                Image(systemName: "circle.hexagongrid.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.white.opacity(0.1))
                    .rotationEffect(.degrees(15))
                    .offset(x: 30, y: -10)
            }
            
            // 内容
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 8) {
                    Text("☯️")
                        .font(.title)
                    
                    Text("欢迎学习易经")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Text("探索中华传统文化，领悟天地之道")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.9))
                
                // 装饰性分隔线
                Rectangle()
                    .fill(AppConstants.Colors.accent)
                    .frame(width: 60, height: 3)
                    .cornerRadius(1.5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
        }
        .frame(height: 140)
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(color: AppConstants.Colors.primary.opacity(0.3), radius: 10, y: 5)
    }
    
    // MARK: - Daily Hexagram Card (优化设计)
    private var dailyHexagramCard: some View {
        Group {
            if let hexagram = viewModel.dailyHexagram {
                NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                    VStack(spacing: 0) {
                        // 标题栏 - 金色渐变背景
                        HStack {
                            HStack(spacing: 6) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 14))
                                Text("每日一卦")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(Date().chineseDateString)
                                .font(.system(size: 13))
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 14)
                        .background(AppConstants.Colors.accentGradient)
                        
                        // 卦象内容区
                        HStack(spacing: 16) {
                            // 卦象符号 - 带装饰边框
                            ZStack {
                                Circle()
                                    .fill(AppConstants.Colors.elegantGradient)
                                    .frame(width: 80, height: 80)
                                
                                HexagramSymbolView(hexagram: hexagram, size: 40)
                            }
                            
                            // 卦象信息
                            VStack(alignment: .leading, spacing: 8) {
                                Text(hexagram.chineseName)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(AppConstants.Colors.primary)
                                
                                Text(hexagram.trigramDescription)
                                    .font(.system(size: 14))
                                    .foregroundColor(AppConstants.Colors.primaryLight)
                                
                                Text(hexagram.description)
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            // 箭头指示
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.system(size: 24))
                                .foregroundColor(AppConstants.Colors.accent)
                        }
                        .padding(20)
                        .background(Color(.systemBackground))
                    }
                    .cornerRadius(AppConstants.UI.cornerRadius)
                    .shadow(
                        color: AppConstants.Colors.accent.opacity(AppConstants.UI.shadowOpacity),
                        radius: AppConstants.UI.shadowRadius,
                        y: 4
                    )
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                ProgressView("加载中...")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Study Progress Card (优化设计)
    private var studyProgressCard: some View {
        VStack(spacing: 0) {
            // 标题区
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 14))
                    Text("学习进度")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(AppConstants.Colors.primary)
                
                Spacer()
                
                Text("\(storageService.studyProgress.progressPercentage)%")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(AppConstants.Colors.accent)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)
            
            // 进度条 - 优雅设计
            ZStack(alignment: .leading) {
                // 背景
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppConstants.Colors.elegantGradient)
                    .frame(height: 12)
                
                // 进度
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppConstants.Colors.primaryGradient)
                    .frame(
                        width: CGFloat(storageService.studyProgress.progressPercentage) / 100 * (UIScreen.main.bounds.width - 72),
                        height: 12
                    )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            // 统计数据
            HStack(spacing: 0) {
                ProgressStatItem(
                    title: "已学习",
                    value: "\(storageService.studyProgress.learnedHexagrams.count)",
                    total: "/64",
                    icon: "book.fill",
                    color: AppConstants.Colors.primary
                )
                
                Divider()
                    .frame(height: 50)
                    .padding(.horizontal, 8)
                
                ProgressStatItem(
                    title: "已收藏",
                    value: "\(storageService.studyProgress.favoriteHexagrams.count)",
                    total: "",
                    icon: "star.fill",
                    color: AppConstants.Colors.accent
                )
                
                Divider()
                    .frame(height: 50)
                    .padding(.horizontal, 8)
                
                ProgressStatItem(
                    title: "连续天数",
                    value: "\(storageService.studyProgress.studyDays)",
                    total: "天",
                    icon: "flame.fill",
                    color: AppConstants.Colors.cinnabar
                )
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(
            color: .black.opacity(AppConstants.UI.shadowOpacity),
            radius: AppConstants.UI.shadowRadius,
            y: 4
        )
    }
    
    // MARK: - Quick Access Section (优化设计)
    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 14))
                Text("快速入口")
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(AppConstants.Colors.primary)
            .padding(.horizontal, 4)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: DeviceType.gridColumns), spacing: 12) {
                NavigationLink(destination: EncyclopediaView(initialSegment: 0)) {
                    QuickAccessButton(
                        title: "浏览卦象",
                        icon: "hexagon.fill",
                        gradient: AppConstants.Colors.primaryGradient,
                        iconColor: .white
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: EncyclopediaView(initialSegment: 1)) {
                    QuickAccessButton(
                        title: "八卦基础",
                        icon: "circle.hexagongrid.fill",
                        gradient: LinearGradient(
                            colors: [AppConstants.Colors.jade, AppConstants.Colors.bamboo],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        iconColor: .white
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: PracticeView()) {
                    QuickAccessButton(
                        title: "认卦游戏",
                        icon: "gamecontroller.fill",
                        gradient: LinearGradient(
                            colors: [Color(hex: "9B59B6"), Color(hex: "BB8FCE")],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        iconColor: .white
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: FavoritesView()) {
                    QuickAccessButton(
                        title: "我的收藏",
                        icon: "star.fill",
                        gradient: AppConstants.Colors.accentGradient,
                        iconColor: .white
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

// MARK: - Progress Stat Item (优化设计)
struct ProgressStatItem: View {
    let title: String
    let value: String
    let total: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            // 图标背景
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 44, height: 44)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18))
            }
            
            // 数值
            HStack(alignment: .bottom, spacing: 1) {
                Text(value)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                
                if !total.isEmpty {
                    Text(total)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                        .offset(y: -2)
                }
            }
            
            // 标题
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Quick Access Button (优化设计)
struct QuickAccessButton: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let iconColor: Color
    
    var body: some View {
        VStack(spacing: 12) {
            // 图标
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.2))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)
            }
            
            // 标题
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(iconColor)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 110)
        .background(gradient)
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(
            color: .black.opacity(0.15),
            radius: 8,
            y: 4
        )
    }
}

#Preview {
    HomeView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

