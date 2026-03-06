//
//  HomeView.swift
//  易经国学堂
//
//  按照参考设计图重构 - 绿色主题现代风格
//

import SwiftUI

// MARK: - 绿色主题色常量
private enum GreenTheme {
    static let primary     = Color(hex: "1B5E4F")   // 深绿（主色）
    static let primaryMid  = Color(hex: "2D7A5E")   // 中绿
    static let bg          = Color(hex: "F2F2F7")   // 页面底色（浅灰）
    static let card        = Color.white             // 卡片白色
    static let textMain    = Color(hex: "1A1A1A")   // 主文字
    static let textSub     = Color(hex: "666666")   // 次文字
    static let textHint    = Color(hex: "AAAAAA")   // 提示文字
}

struct HomeView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                GreenTheme.bg.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        welcomeBanner          // 欢迎横幅
                        dailyHexagramCard      // 今日一卦
                        quickAccessRow         // 快速入口
                        learningOverview       // 学习概览
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 30)
                }
                // 自定义导航标题颜色（绿色居中）
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("易经学院")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(GreenTheme.primary)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            viewModel.setup(dataService: dataService, storageService: storageService)
        }
    }
    
    // MARK: - 欢迎横幅（深绿渐变卡片）
    private var welcomeBanner: some View {
        ZStack(alignment: .topTrailing) {
            // 深绿渐变背景
            LinearGradient(
                colors: [Color(hex: "1B5E4F"), Color(hex: "0D3B2D")],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .cornerRadius(16)
            
            // 右上角装饰性半透明圆圈（仿截图效果）
            BannerDecorativeCircles()
            
            // 内容层
            HStack(spacing: 14) {
                // App 图标（渐变圆形）
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color(hex: "A855F7"), Color(hex: "EC4899")],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 54, height: 54)
                    
                    // 阴阳鱼符号
                    Text("☯")
                        .font(.system(size: 28))
                        .foregroundColor(.white)
                }
                
                // 文案区域
                VStack(alignment: .leading, spacing: 5) {
                    Text("欢迎学习易经")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("探索中华传统文化，领悟天地之道")
                        .font(.system(size: 13))
                        .foregroundColor(.white.opacity(0.82))
                    
                    // 金色下划线装饰
                    Rectangle()
                        .fill(Color(hex: "D4AF37"))
                        .frame(width: 40, height: 2.5)
                        .cornerRadius(1.5)
                        .padding(.top, 4)
                }
                
                Spacer()
            }
            .padding(20)
        }
        .frame(height: 120)
        .shadow(color: Color.black.opacity(0.15), radius: 12, y: 5)
    }
    
    // MARK: - 今日一卦
    private var dailyHexagramCard: some View {
        Group {
            if let hexagram = viewModel.dailyHexagram {
                // 可点击跳转详情
                NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                    DailyHexagramContent(hexagram: hexagram)
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                // 加载占位
                DailyHexagramContent(hexagram: nil)
            }
        }
    }
    
    // MARK: - 快速入口（4个图标横排）
    private var quickAccessRow: some View {
        HStack(spacing: 0) {
            // 浏览卦象
            NavigationLink(destination: EncyclopediaView(initialSegment: 0)) {
                QuickAccessIcon(
                    title: "浏览卦象",
                    systemImage: "books.vertical.fill",
                    iconColor: Color(hex: "FF7A30"),
                    bgColor: Color(hex: "FFF1E6")
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // 八卦基础
            NavigationLink(destination: EncyclopediaView(initialSegment: 1)) {
                QuickAccessIcon(
                    title: "八卦基础",
                    systemImage: "circle.hexagongrid.fill",
                    iconColor: GreenTheme.primary,
                    bgColor: Color(hex: "E6F4EF")
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // 认卦游戏
            NavigationLink(destination: PracticeView()) {
                QuickAccessIcon(
                    title: "认卦游戏",
                    systemImage: "gamecontroller.fill",
                    iconColor: Color(hex: "7B5EA7"),
                    bgColor: Color(hex: "F0EBF8")
                )
            }
            .buttonStyle(PlainButtonStyle())
            
            // 我的收藏
            NavigationLink(destination: ProfileView()) {
                QuickAccessIcon(
                    title: "我的收藏",
                    systemImage: "star.fill",
                    iconColor: Color(hex: "F5A623"),
                    bgColor: Color(hex: "FEF6E4")
                )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 4)
    }
    
    // MARK: - 学习概览（3个统计卡片）
    private var learningOverview: some View {
        let learned   = storageService.studyProgress.learnedHexagrams.count
        let favorites = storageService.studyProgress.favoriteHexagrams.count
        let days      = storageService.studyProgress.studyDays
        // 连续学习天数换算成"打败了N%用户"（简单线性映射，最多95%）
        let beatPercent = min(days * 5, 95)
        
        return VStack(alignment: .leading, spacing: 12) {
            Text("学习概览")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(GreenTheme.textMain)
            
            HStack(spacing: 10) {
                // 已学卦象
                StatCard(
                    icon: "book.closed.fill",
                    iconColor: GreenTheme.primary,
                    iconBg: Color(hex: "E6F4EF"),
                    title: "已学卦象",
                    value: "\(learned)",
                    valueSuffix: "/ 64",
                    subText: nil,
                    showProgress: true,
                    progressValue: Double(learned) / 64.0,
                    progressColor: GreenTheme.primary
                )
                
                // 我的收藏
                StatCard(
                    icon: "bookmark.fill",
                    iconColor: Color(hex: "F5A623"),
                    iconBg: Color(hex: "FEF6E4"),
                    title: "我的收藏",
                    value: "\(favorites)",
                    valueSuffix: nil,
                    subText: favorites == 0 ? "暂无收藏" : "已收\(favorites)卦",
                    showProgress: false,
                    progressValue: 0,
                    progressColor: .clear
                )
                
                // 连续学习
                StatCard(
                    icon: "flame.fill",
                    iconColor: Color(hex: "FF7A30"),
                    iconBg: Color(hex: "FFF1E6"),
                    title: "连续学习",
                    value: "\(days)",
                    valueSuffix: "天",
                    subText: "打败了\(beatPercent)%用户",
                    showProgress: false,
                    progressValue: 0,
                    progressColor: .clear
                )
            }
        }
    }
}

// MARK: - 今日一卦内容视图
private struct DailyHexagramContent: View {
    let hexagram: Hexagram?
    
    private let primaryGreen = Color(hex: "1B5E4F")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            // 顶部标题行
            HStack {
                Text("今日一卦")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(primaryGreen)
                
                Spacer()
                
                // 三横线图标（仿截图菜单图标）
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(primaryGreen)
            }
            
            // 卦象名称（大字）
            if let h = hexagram {
                Text("第\(h.id)卦  \(h.chineseName)")
                    .font(.system(size: 22, weight: .bold, design: .serif))
                    .foregroundColor(Color(hex: "1A1A1A"))
                
                // 卦辞（带引号）
                Text("「\(h.description)」")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: "3A3A3A"))
                    .lineSpacing(7)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            } else {
                Text("正在加载...")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(hex: "CCCCCC"))
            }
            
            // 底部：来源 + 查看详情按钮
            HStack(alignment: .center) {
                if let h = hexagram {
                    Text("\(h.lowerTrigram)下\(h.upperTrigram)上·\(h.name)卦")
                        .font(.system(size: 12))
                        .foregroundColor(Color(hex: "AAAAAA"))
                }
                
                Spacer()
                
                Text("查看详情")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(primaryGreen)
                    .cornerRadius(22)
            }
        }
        .padding(18)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 8, y: 3)
    }
}

// MARK: - 快速入口图标组件
private struct QuickAccessIcon: View {
    let title: String
    let systemImage: String
    let iconColor: Color
    let bgColor: Color
    
    var body: some View {
        VStack(spacing: 10) {
            // 圆角方形图标容器
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(bgColor)
                    .frame(width: 54, height: 54)
                
                Image(systemName: systemImage)
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(Color(hex: "333333"))
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - 学习统计卡片组件
private struct StatCard: View {
    let icon: String
    let iconColor: Color
    let iconBg: Color
    let title: String
    let value: String
    let valueSuffix: String?
    let subText: String?
    let showProgress: Bool
    let progressValue: Double
    let progressColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 图标（左上角）
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconBg)
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                Spacer()
            }
            
            // 数值（大字 + 后缀）
            HStack(alignment: .bottom, spacing: 2) {
                Text(value)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(hex: "1A1A1A"))
                
                if let suffix = valueSuffix {
                    Text(suffix)
                        .font(.system(size: 11))
                        .foregroundColor(Color(hex: "AAAAAA"))
                        .padding(.bottom, 3)
                }
            }
            
            // 标题
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color(hex: "666666"))
            
            // 副文字（可选）
            if let sub = subText {
                Text(sub)
                    .font(.system(size: 11))
                    .foregroundColor(Color(hex: "AAAAAA"))
            }
            
            // 进度条（可选）
            if showProgress {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color(hex: "E8E8E8"))
                            .frame(height: 3)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(progressColor)
                            .frame(
                                width: max(3, geo.size.width * CGFloat(progressValue)),
                                height: 3
                            )
                    }
                }
                .frame(height: 3)
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, y: 2)
    }
}

// MARK: - 欢迎横幅装饰圆圈
private struct BannerDecorativeCircles: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 120, height: 120)
                    .position(x: geo.size.width - 25, y: 20)
                
                Circle()
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 90, height: 90)
                    .position(x: geo.size.width - 80, y: 50)
                
                Circle()
                    .fill(Color.white.opacity(0.07))
                    .frame(width: 65, height: 65)
                    .position(x: geo.size.width - 30, y: 90)
                
                Circle()
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 50, height: 50)
                    .position(x: geo.size.width - 115, y: 15)
            }
        }
        .clipped()
        .cornerRadius(16)
    }
}

// MARK: - 预览
#Preview {
    HomeView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}
