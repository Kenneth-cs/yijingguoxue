//
//  HomeView.swift
//  易经国学堂
//
//  UI 已按照设计稿重构：绿色主题，白色背景，匹配截图布局
//  Created on 2025/11/17.
//

import SwiftUI

// MARK: - 主题颜色（全局复用）
private let themeGreen    = Color(red: 0.03, green: 0.42, blue: 0.32)   // #0B6B52
private let textDark      = Color(red: 0.06, green: 0.09, blue: 0.16)
private let textMid       = Color(red: 0.28, green: 0.33, blue: 0.41)
private let textLight     = Color(red: 0.58, green: 0.64, blue: 0.72)
private let textLabel     = Color(red: 0.39, green: 0.45, blue: 0.55)

struct HomeView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    welcomeBanner
                    dailyHexagramCard
                    quickAccessRow
                    learningOverviewSection
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
            .background(Color.white.ignoresSafeArea())
            // 导航栏样式：白底 + 绿色标题
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("易经学院")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(themeGreen)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.setup(dataService: dataService, storageService: storageService)
        }
    }
}

// MARK: - 欢迎横幅
extension HomeView {
    private var welcomeBanner: some View {
        ZStack(alignment: .leading) {
            // 深绿渐变背景
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.04, green: 0.47, blue: 0.36),
                            Color(red: 0.02, green: 0.28, blue: 0.22)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // 右侧装饰圆圈（层叠半透明）
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.07))
                        .frame(width: 110, height: 110)
                        .offset(x: 30, y: -18)
                    Circle()
                        .fill(Color.white.opacity(0.05))
                        .frame(width: 75, height: 75)
                        .offset(x: -5, y: 20)
                    Circle()
                        .fill(Color.white.opacity(0.04))
                        .frame(width: 50, height: 50)
                        .offset(x: 40, y: 22)
                }
                .padding(.trailing, -10)
            }

            // 左侧内容
            HStack(spacing: 14) {
                // 太极图标圆形背景
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 50, height: 50)
                    Text("☯")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("欢迎学习易经")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)

                    Text("探索中华传统文化，领悟天地之道")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.80))

                    // 金色下划线装饰
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(red: 0.95, green: 0.78, blue: 0.25))
                        .frame(width: 44, height: 2.5)
                        .padding(.top, 2)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .frame(height: 108)
    }
}

// MARK: - 今日一卦卡片
extension HomeView {
    private var dailyHexagramCard: some View {
        Group {
            if let hexagram = viewModel.dailyHexagram {
                NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                    hexagramCardContent(hexagram: hexagram)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                hexagramCardContent(hexagram: nil)
            }
        }
    }

    /// 卡片主体内容（hexagram 为 nil 时显示占位）
    private func hexagramCardContent(hexagram: Hexagram?) -> some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── 顶部：标签 + 六爻图标 ──────────────────
            HStack(alignment: .center) {
                Text("今日一卦")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(themeGreen)
                Spacer()
                hexagramMenuIcon
            }
            .padding(.bottom, 12)

            // ── 卦名 ──────────────────────────────────
            Text(hexagram.map { "第\($0.id)卦 \($0.chineseName)" } ?? "加载中…")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(textDark)
                .padding(.bottom, 10)

            // ── 卦辞（最多展示 2 行）──────────────────
            Text(hexagram.map { hexagram in "\u{201C}\(hexagram.description)\u{201D}" } ?? "")
                .font(.system(size: 14))
                .foregroundColor(textMid)
                .lineSpacing(5)
                .lineLimit(3)
                .padding(.bottom, 16)

            // ── 分隔线 ────────────────────────────────
            Rectangle()
                .fill(themeGreen.opacity(0.06))
                .frame(height: 1)
                .padding(.bottom, 12)

            // ── 底部：卦卦位 + 查看详情 ──────────────
            HStack {
                Text(hexagram.map { "\($0.lowerTrigram)下\($0.upperTrigram)上 · \($0.name)卦" } ?? "")
                    .font(.system(size: 12))
                    .foregroundColor(textLight)

                Spacer()

                Text("查看详情")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(themeGreen)
                    .cornerRadius(8)
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(themeGreen.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.10), radius: 6, x: 0, y: 4)
    }

    /// 右上角六爻样式图标
    private var hexagramMenuIcon: some View {
        VStack(spacing: 5) {
            // 模拟六爻：实线 / 断线 / 实线 共 3 组
            ForEach(0..<3) { i in
                if i == 2 {
                    // 第三行：断线（阴爻样式）
                    HStack(spacing: 4) {
                        RoundedRectangle(cornerRadius: 9)
                            .fill(themeGreen.opacity(0.25))
                            .frame(width: 11, height: 3.5)
                        RoundedRectangle(cornerRadius: 9)
                            .fill(themeGreen.opacity(0.25))
                            .frame(width: 11, height: 3.5)
                    }
                } else {
                    RoundedRectangle(cornerRadius: 9)
                        .fill(themeGreen)
                        .frame(width: 26, height: 3.5)
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(themeGreen.opacity(0.06))
        .cornerRadius(8)
    }
}

// MARK: - 快速入口（四宫格横排）
extension HomeView {

    /// 四个入口定义
    private struct QuickEntry {
        let title: String
        let icon: String
    }

    private var entries: [QuickEntry] {
        [
            QuickEntry(title: "浏览卦象", icon: "square.grid.2x2"),
            QuickEntry(title: "八卦基础", icon: "circle.hexagongrid"),
            QuickEntry(title: "认卦游戏", icon: "gamecontroller"),
            QuickEntry(title: "我的收藏", icon: "heart"),
        ]
    }

    private var quickAccessRow: some View {
        HStack(spacing: 0) {
            // 浏览卦象
            NavigationLink(destination: EncyclopediaView(initialSegment: 0)) {
                quickEntryItem(title: "浏览卦象", icon: "square.grid.2x2")
            }
            .buttonStyle(PlainButtonStyle())

            // 八卦基础
            NavigationLink(destination: EncyclopediaView(initialSegment: 1)) {
                quickEntryItem(title: "八卦基础", icon: "circle.hexagongrid")
            }
            .buttonStyle(PlainButtonStyle())

            // 认卦游戏
            NavigationLink(destination: PracticeView()) {
                quickEntryItem(title: "认卦游戏", icon: "gamecontroller")
            }
            .buttonStyle(PlainButtonStyle())

            // 我的收藏
            NavigationLink(destination: FavoritesView()) {
                quickEntryItem(title: "我的收藏", icon: "heart")
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 16)
        .background(themeGreen.opacity(0.05))
        .cornerRadius(12)
    }

    /// 单个快速入口项
    private func quickEntryItem(title: String, icon: String) -> some View {
        VStack(spacing: 10) {
            // 白色圆角方块图标背景
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .frame(width: 48, height: 48)
                    .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)

                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(themeGreen)
            }

            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(textDark)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - 学习概览（三格统计卡片）
extension HomeView {
    private var learningOverviewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("学习概览")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(textDark)

            HStack(spacing: 10) {
                learnedHexagramCard
                favoritesCard
                streakCard
            }
        }
    }

    /// 已学卦象卡片（带进度条）
    private var learnedHexagramCard: some View {
        let learned = storageService.studyProgress.learnedHexagrams.count
        let progress = min(Double(learned) / 64.0, 1.0)

        return VStack(alignment: .leading, spacing: 8) {
            // 小图标 + 标签
            HStack(spacing: 4) {
                Image(systemName: "book")
                    .font(.system(size: 11))
                    .foregroundColor(textLabel)
                Text("已学卦象")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(textLabel)
            }

            // 数值
            HStack(alignment: .bottom, spacing: 2) {
                Text("\(learned)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(themeGreen)
                Text("/ 64")
                    .font(.system(size: 13))
                    .foregroundColor(textLight)
                    .padding(.bottom, 2)
            }

            // 进度条
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 9999)
                        .fill(themeGreen.opacity(0.10))
                        .frame(height: 4)
                    RoundedRectangle(cornerRadius: 9999)
                        .fill(themeGreen)
                        .frame(width: max(geo.size.width * CGFloat(progress), 4), height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .statCardStyle()
    }

    /// 我的收藏卡片
    private var favoritesCard: some View {
        let count = storageService.studyProgress.favoriteHexagrams.count

        return VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "bookmark")
                    .font(.system(size: 11))
                    .foregroundColor(textLabel)
                Text("我的收藏")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(textLabel)
            }

            Text("\(count)")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(themeGreen)

            Text(count == 0 ? "暂无收藏" : "共\(count)卦")
                .font(.system(size: 10))
                .foregroundColor(textLight)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .statCardStyle()
    }

    /// 连续学习卡片
    private var streakCard: some View {
        let days = storageService.studyProgress.studyDays

        return VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "flame")
                    .font(.system(size: 11))
                    .foregroundColor(textLabel)
                Text("连续学习")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(textLabel)
            }

            HStack(alignment: .bottom, spacing: 2) {
                Text("\(days)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(themeGreen)
                Text("天")
                    .font(.system(size: 13))
                    .foregroundColor(textLight)
                    .padding(.bottom, 2)
            }

            Text("打败了 12% 用户")
                .font(.system(size: 10))
                .foregroundColor(textLight)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .statCardStyle()
    }
}

// MARK: - 统计卡片样式修饰器
private extension View {
    func statCardStyle() -> some View {
        self
            .background(Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(themeGreen.opacity(0.10), lineWidth: 0.5)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}
