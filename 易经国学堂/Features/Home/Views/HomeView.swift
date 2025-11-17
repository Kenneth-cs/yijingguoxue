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
            .background(Color(.systemGroupedBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.setup(dataService: dataService, storageService: storageService)
        }
    }
    
    // MARK: - Welcome Card
    private var welcomeCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("欢迎学习易经")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("探索中华传统文化，领悟天地之道")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            LinearGradient(
                colors: [Color(.systemGray6), Color(.systemGray5)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    // MARK: - Daily Hexagram Card
    private var dailyHexagramCard: some View {
        Group {
            if let hexagram = viewModel.dailyHexagram {
                NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("📅 每日一卦")
                                .font(.headline)
                            Spacer()
                            Text(Date().chineseDateString)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack(spacing: 15) {
                            Text(hexagram.symbol)
                                .font(.system(size: 50))
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(hexagram.chineseName)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                
                                Text(hexagram.description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        
                        Text("点击查看详情 →")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(AppConstants.UI.cornerRadius)
                    .shadow(color: .black.opacity(0.05), radius: 5)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                Text("加载中...")
                    .foregroundColor(.secondary)
            }
        }
    }
    
    // MARK: - Study Progress Card
    private var studyProgressCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("学习进度")
                .font(.headline)
            
            HStack(spacing: 20) {
                ProgressStatItem(
                    title: "已学习",
                    value: "\(storageService.studyProgress.learnedHexagrams.count)",
                    total: "64",
                    icon: "book.fill",
                    color: .blue
                )
                
                ProgressStatItem(
                    title: "已收藏",
                    value: "\(storageService.studyProgress.favoriteHexagrams.count)",
                    total: "",
                    icon: "star.fill",
                    color: .yellow
                )
                
                ProgressStatItem(
                    title: "连续天数",
                    value: "\(storageService.studyProgress.studyDays)",
                    total: "天",
                    icon: "flame.fill",
                    color: .orange
                )
            }
            
            // 进度条
            ProgressView(value: Double(storageService.studyProgress.progressPercentage), total: 100)
                .tint(AppConstants.Colors.primary)
            
            Text("已完成 \(storageService.studyProgress.progressPercentage)%")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 5)
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

// MARK: - Progress Stat Item
struct ProgressStatItem: View {
    let title: String
    let value: String
    let total: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(color)
                .font(.title3)
            
            HStack(alignment: .bottom, spacing: 2) {
                Text(value)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if !total.isEmpty {
                    Text(total)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Quick Access Button
struct QuickAccessButton: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview {
    HomeView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

