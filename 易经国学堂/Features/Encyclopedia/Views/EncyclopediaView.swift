//
//  EncyclopediaView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct EncyclopediaView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    @State private var searchText = ""
    @State private var selectedSegment: Int
    
    // 添加初始化参数，允许指定默认选中的tab
    init(initialSegment: Int = 0) {
        _selectedSegment = State(initialValue: initialSegment)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // 宣纸背景
                PaperBackground()
                
                VStack(spacing: 0) {
                    // 分段控制器
                    Picker("类型", selection: $selectedSegment) {
                        Text("六十四卦").tag(0)
                        Text("八卦").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .padding(.horizontal, DeviceType.isPad ? 40 : 0)
                    .centerContent()
                    
                    // 内容区域
                    if selectedSegment == 0 {
                        HexagramListView(searchText: searchText)
                    } else {
                        TrigramListView()
                    }
                }
            }
            .navigationTitle("易经百科")
            .searchable(text: $searchText, prompt: "搜索卦象")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Hexagram List View
struct HexagramListView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService
    let searchText: String
    
    private var filteredHexagrams: [Hexagram] {
        if searchText.isEmpty {
            return dataService.hexagrams
        } else {
            return dataService.searchHexagrams(query: searchText)
        }
    }
    
    var body: some View {
        ScrollView {
            if DeviceType.isPad {
                // iPad: 使用网格布局
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(filteredHexagrams) { hexagram in
                        NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                            HexagramCardView(
                                hexagram: hexagram,
                                isFavorite: storageService.isFavorite(hexagram.id)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
                .centerContent()
            } else {
                // iPhone: 使用垂直列表
                LazyVStack(spacing: 12) {
                    ForEach(filteredHexagrams) { hexagram in
                        NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                            HexagramCardView(
                                hexagram: hexagram,
                                isFavorite: storageService.isFavorite(hexagram.id)
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
        }
    }
}

// MARK: - Hexagram Card View (新中式)
struct HexagramCardView: View {
    let hexagram: Hexagram
    let isFavorite: Bool
    
    var body: some View {
        HStack(spacing: 14) {
            // 卦象符号 - 带装饰背景
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppConstants.Colors.symbolGradient)
                    .frame(width: 65, height: 75)
                
                HexagramSymbolView(hexagram: hexagram, size: 38)
            }
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(hexagram.displayName)
                        .font(AppConstants.Fonts.headline)
                        .foregroundColor(AppConstants.Colors.textPrimary)
                        .lineLimit(1)
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(AppConstants.Colors.gold)
                    }
                }
                
                Text(hexagram.trigramDescription)
                    .font(AppConstants.Fonts.subheadline)
                    .foregroundColor(AppConstants.Colors.textSecondary)
                
                Text(hexagram.description)
                    .font(AppConstants.Fonts.caption)
                    .foregroundColor(AppConstants.Colors.textSecondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppConstants.Colors.cinnabar.opacity(0.6))
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(AppConstants.Colors.cardBackground)
        .cornerRadius(AppConstants.UI.cardCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.UI.cardCornerRadius)
                .strokeBorder(AppConstants.Colors.gold.opacity(0.15), lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(AppConstants.UI.shadowOpacity),
            radius: AppConstants.UI.cardShadowRadius,
            y: AppConstants.UI.cardShadowY
        )
    }
}

// MARK: - Trigram List View
struct TrigramListView: View {
    @EnvironmentObject var dataService: DataService
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(dataService.trigrams) { trigram in
                    NavigationLink(destination: TrigramDetailView(trigram: trigram)) {
                        TrigramCardView(trigram: trigram)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}

// MARK: - Trigram Card View (新中式)
struct TrigramCardView: View {
    let trigram: Trigram
    
    var body: some View {
        HStack(spacing: 16) {
            // 卦象符号 - 优雅背景
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppConstants.Colors.accentGradient)
                    .frame(width: 70, height: 70)
                
                Text(trigram.symbol)
                    .font(.system(size: 36))
            }
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 6) {
                Text(trigram.name)
                    .font(AppConstants.Fonts.title3)
                    .foregroundColor(AppConstants.Colors.textPrimary)
                
                HStack(spacing: 12) {
                    AttributeTag(
                        icon: "flame.fill",
                        text: trigram.element,
                        color: getElementColor(trigram.element)
                    )
                    
                    AttributeTag(
                        icon: "location.fill",
                        text: trigram.direction,
                        color: AppConstants.Colors.indigo
                    )
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppConstants.Colors.cinnabar.opacity(0.6))
        }
        .padding(16)
        .background(AppConstants.Colors.cardBackground)
        .cornerRadius(AppConstants.UI.cardCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: AppConstants.UI.cardCornerRadius)
                .strokeBorder(AppConstants.Colors.cinnabar.opacity(0.15), lineWidth: 1)
        )
        .shadow(
            color: Color.black.opacity(AppConstants.UI.shadowOpacity),
            radius: AppConstants.UI.cardShadowRadius,
            y: AppConstants.UI.cardShadowY
        )
    }
    
    // 根据五行返回对应颜色
    private func getElementColor(_ element: String) -> Color {
        switch element {
        case "木": return AppConstants.Colors.woodColor
        case "火": return AppConstants.Colors.fireColor
        case "土": return AppConstants.Colors.earthColor
        case "金": return AppConstants.Colors.metalColor
        case "水": return AppConstants.Colors.waterColor
        default: return AppConstants.Colors.jade
        }
    }
}

// MARK: - Trigram Detail View (新中式优化版)
struct TrigramDetailView: View {
    let trigram: Trigram
    
    var body: some View {
        ZStack {
            // 宣纸背景
            PaperBackground()
            
            ScrollView {
                VStack(spacing: 24) {
                    // 顶部卦象展示 - 圆形容器
                    ZenCard(useAccentGradient: true, padding: 30) {
                        VStack(spacing: 20) {
                            // 卦名 - 使用宋体
                            Text(trigram.name)
                                .font(AppConstants.Fonts.largeTitle)
                                .foregroundColor(AppConstants.Colors.textPrimary)
                            
                            // 卦象符号 - 带装饰容器
                            SymbolContainer(symbol: trigram.symbol, size: 100, showGlow: true)
                                .padding(.vertical, 10)
                            
                            // 二进制表示 - 金色强调
                            Text(trigram.binary)
                                .font(AppConstants.Fonts.headline)
                                .foregroundColor(AppConstants.Colors.gold)
                                .tracking(10)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(
                                    Capsule()
                                        .fill(AppConstants.Colors.gold.opacity(0.1))
                                )
                        }
                    }
                    
                    // 核心属性 - 网格布局
                    ZenCard(padding: 16) {
                        VStack(spacing: 16) {
                            SectionHeader(
                                icon: "star.circle.fill",
                                title: "核心属性",
                                iconColor: AppConstants.Colors.cinnabar
                            )
                            
                            // 第一行：五行、方位
                            HStack(spacing: 12) {
                                AttributeGridItem(
                                    icon: "flame.fill",
                                    iconColor: getElementColor(trigram.element),
                                    title: "五行",
                                    value: trigram.element
                                )
                                
                                AttributeGridItem(
                                    icon: "location.fill",
                                    iconColor: AppConstants.Colors.indigo,
                                    title: "方位",
                                    value: trigram.direction
                                )
                            }
                            
                            // 第二行：象征、性质
                            HStack(spacing: 12) {
                                AttributeGridItem(
                                    icon: "sparkles",
                                    iconColor: AppConstants.Colors.gold,
                                    title: "象征",
                                    value: trigram.symbolism
                                )
                                
                                AttributeGridItem(
                                    icon: "waveform.path.ecg",
                                    iconColor: AppConstants.Colors.jade,
                                    title: "性质",
                                    value: trigram.nature
                                )
                            }
                            
                            // 第三行：家庭（居中）
                            AttributeGridItem(
                                icon: "person.3.fill",
                                iconColor: AppConstants.Colors.cinnabar,
                                title: "家庭",
                                value: trigram.family
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }
                    
                    // 详细说明
                    ZenCard(padding: 20) {
                        VStack(alignment: .leading, spacing: 16) {
                            SectionHeader(
                                icon: "text.book.closed.fill",
                                title: "详细说明",
                                iconColor: AppConstants.Colors.deepGreen
                            )
                            
                            // 装饰性分隔线
                            ZenDivider()
                                .padding(.vertical, 4)
                            
                            // 说明文字 - 首字下沉效果
                            Text(trigram.description)
                                .font(AppConstants.Fonts.bodyText)
                                .foregroundColor(AppConstants.Colors.textPrimary)
                                .lineSpacing(8)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    // 底部装饰
                    TraditionalPattern(opacity: 0.08, size: 40)
                        .padding(.top, 20)
                }
                .padding(16)
            }
        }
        .navigationTitle(trigram.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // 根据五行返回对应颜色
    private func getElementColor(_ element: String) -> Color {
        switch element {
        case "木": return AppConstants.Colors.woodColor
        case "火": return AppConstants.Colors.fireColor
        case "土": return AppConstants.Colors.earthColor
        case "金": return AppConstants.Colors.metalColor
        case "水": return AppConstants.Colors.waterColor
        default: return AppConstants.Colors.jade
        }
    }
}



#Preview {
    EncyclopediaView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

