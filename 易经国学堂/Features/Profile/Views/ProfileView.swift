//
//  ProfileView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    
    var body: some View {
        NavigationView {
            List {
                // 学习统计
                studyStatsSection
                
                // 功能列表
                featuresSection
                
                // 设置
                settingsSection
            }
            .navigationTitle("我的")
        }
    }
    
    // MARK: - Study Stats Section
    private var studyStatsSection: some View {
        Section {
            VStack(spacing: 15) {
                // 学习进度卡片
                HStack(spacing: 20) {
                    StatBox(
                        title: "已学习",
                        value: "\(storageService.studyProgress.learnedHexagrams.count)",
                        icon: "book.fill",
                        color: .blue
                    )
                    
                    StatBox(
                        title: "已收藏",
                        value: "\(storageService.studyProgress.favoriteHexagrams.count)",
                        icon: "star.fill",
                        color: .yellow
                    )
                    
                    StatBox(
                        title: "连续天数",
                        value: "\(storageService.studyProgress.studyDays)",
                        icon: "flame.fill",
                        color: .orange
                    )
                }
                
                // 总学习时长
                HStack {
                    Image(systemName: "clock.fill")
                        .foregroundColor(.green)
                    
                    Text("总学习时长：\(storageService.studyProgress.formattedStudyTime)")
                        .font(.subheadline)
                    
                    Spacer()
                }
            }
            .padding(.vertical, 8)
        } header: {
            Text("学习统计")
        }
    }
    
    // MARK: - Features Section
    private var featuresSection: some View {
        Section {
            NavigationLink(destination: FavoritesView()) {
                Label("我的收藏", systemImage: "star.fill")
            }
            
            NavigationLink(destination: NotesView()) {
                Label("学习笔记", systemImage: "note.text")
            }
            
            NavigationLink(destination: GameRecordsView()) {
                Label("游戏记录", systemImage: "gamecontroller.fill")
            }
        } header: {
            Text("功能")
        }
    }
    
    // MARK: - Settings Section
    private var settingsSection: some View {
        Section {
            NavigationLink(destination: AboutView()) {
                Label("关于应用", systemImage: "info.circle")
            }
            
            NavigationLink(destination: PrivacyPolicyView()) {
                Label("隐私政策", systemImage: "hand.raised")
            }
            
            NavigationLink(destination: UserAgreementView()) {
                Label("用户协议", systemImage: "doc.text")
            }
            
            Button(action: {}) {
                Label("分享应用", systemImage: "square.and.arrow.up")
            }
        } header: {
            Text("设置")
        }
    }
}

// MARK: - Stat Box
struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - Favorites View
struct FavoritesView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    
    private var favoriteHexagrams: [Hexagram] {
        storageService.studyProgress.favoriteHexagrams
            .compactMap { dataService.getHexagram(by: $0) }
            .sorted { $0.id < $1.id }
    }
    
    var body: some View {
        Group {
            if favoriteHexagrams.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "star.slash")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    
                    Text("还没有收藏")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            } else {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(favoriteHexagrams) { hexagram in
                            NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                                HexagramCardView(hexagram: hexagram, isFavorite: true)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("我的收藏")
        .background(Color(.systemGroupedBackground))
    }
}

// Note: NotesView 已移动到独立文件 NotesView.swift

// MARK: - About View
struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(systemName: "book.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text(AppConstants.App.name)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("版本 \(AppConstants.App.version)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Divider()
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("应用介绍")
                        .font(.headline)
                    
                    Text("易经国学堂是一款专注于易经学习的iOS应用。通过现代化的交互方式，帮助用户系统学习易经知识，了解中华传统文化。")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Text("主要功能")
                        .font(.headline)
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        FeatureRow(icon: "book.fill", text: "六十四卦详解")
                        FeatureRow(icon: "circle.grid.3x3", text: "八卦基础知识")
                        FeatureRow(icon: "gamecontroller", text: "互动学习游戏")
                        FeatureRow(icon: "calendar", text: "每日一卦")
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("关于应用")
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(text)
                .font(.body)
        }
    }
}

// MARK: - Privacy Policy View
struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("易经国学堂非常重视您的隐私保护。\n\n本应用不收集任何个人信息，所有数据均存储在您的设备本地。\n\n我们不会:\n• 收集您的个人信息\n• 追踪您的使用行为\n• 向第三方分享数据\n• 使用任何分析工具\n\n您的学习记录、收藏、笔记等所有数据都安全地存储在您的设备上，只有您能够访问。")
                .padding()
        }
        .navigationTitle("隐私政策")
    }
}

// MARK: - User Agreement View
struct UserAgreementView: View {
    var body: some View {
        ScrollView {
            Text("易经国学堂用户协议\n\n1. 应用定位\n本应用是一款教育学习工具，旨在帮助用户学习和了解易经传统文化知识。\n\n2. 禁止用途\n严禁将本应用用于：\n• 占卜、算命等迷信活动\n• 商业预测\n• 其他违背科学精神的用途\n\n3. 免责声明\n本应用内容仅供学习参考，不构成任何决策建议。\n\n4. 知识产权\n应用内容来源于公开资料，著作权归原作者所有。")
                .padding()
        }
        .navigationTitle("用户协议")
    }
}

#Preview {
    ProfileView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

