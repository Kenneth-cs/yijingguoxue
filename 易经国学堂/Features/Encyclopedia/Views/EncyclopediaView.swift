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
        .background(AppConstants.Colors.background)
    }
}

// MARK: - Hexagram Card View (优化设计)
struct HexagramCardView: View {
    let hexagram: Hexagram
    let isFavorite: Bool
    
    var body: some View {
        HStack(spacing: 14) {
            // 卦象符号 - 带装饰背景
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(AppConstants.Colors.elegantGradient)
                    .frame(width: 65, height: 75)
                
                HexagramSymbolView(hexagram: hexagram, size: 38)
            }
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 6) {
                    Text(hexagram.displayName)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(AppConstants.Colors.primary)
                        .lineLimit(1)
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(AppConstants.Colors.accent)
                    }
                }
                
                Text(hexagram.trigramDescription)
                    .font(.system(size: 13))
                    .foregroundColor(AppConstants.Colors.primaryLight)
                
                Text(hexagram.description)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppConstants.Colors.accent.opacity(0.6))
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(
            color: .black.opacity(AppConstants.UI.shadowOpacity),
            radius: 6,
            y: 3
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
        .background(AppConstants.Colors.background)
    }
}

// MARK: - Trigram Card View (优化设计)
struct TrigramCardView: View {
    let trigram: Trigram
    
    var body: some View {
        HStack(spacing: 16) {
            // 卦象符号 - 优雅背景
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(AppConstants.Colors.elegantGradient)
                    .frame(width: 70, height: 70)
                
                Text(trigram.symbol)
                    .font(.system(size: 36))
            }
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 6) {
                Text(trigram.name)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppConstants.Colors.primary)
                
                HStack(spacing: 12) {
                    HStack(spacing: 4) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 10))
                        Text(trigram.element)
                            .font(.system(size: 12))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 10))
                        Text(trigram.direction)
                            .font(.system(size: 12))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 10))
                        Text(trigram.symbolism)
                            .font(.system(size: 12))
                    }
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(AppConstants.Colors.accent.opacity(0.6))
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(
            color: .black.opacity(AppConstants.UI.shadowOpacity),
            radius: 6,
            y: 3
        )
    }
}

// MARK: - Trigram Detail View (优化版)
struct TrigramDetailView: View {
    let trigram: Trigram
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // 顶部卦象展示卡片
                VStack(spacing: 16) {
                    // 卦名
                    Text(trigram.name)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.primary)
                    
                    // 卦象符号
                    Text(trigram.symbol)
                        .font(.system(size: 120))
                        .padding(.vertical, 20)
                    
                    // 二进制表示
                    Text(trigram.binary)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                        .tracking(8)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(
                    LinearGradient(
                        colors: [Color(.systemGray6), Color(.systemGray5)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                
                // 核心属性卡片
                VStack(spacing: 0) {
                    AttributeRow(
                        icon: "flame.fill",
                        iconColor: .orange,
                        title: "五行",
                        value: trigram.element
                    )
                    
                    Divider().padding(.leading, 60)
                    
                    AttributeRow(
                        icon: "location.fill",
                        iconColor: .blue,
                        title: "方位",
                        value: trigram.direction
                    )
                    
                    Divider().padding(.leading, 60)
                    
                    AttributeRow(
                        icon: "sparkles",
                        iconColor: .purple,
                        title: "象征",
                        value: trigram.symbolism
                    )
                    
                    Divider().padding(.leading, 60)
                    
                    AttributeRow(
                        icon: "waveform.path.ecg",
                        iconColor: .green,
                        title: "性质",
                        value: trigram.nature
                    )
                    
                    Divider().padding(.leading, 60)
                    
                    AttributeRow(
                        icon: "person.3.fill",
                        iconColor: .red,
                        title: "家庭",
                        value: trigram.family
                    )
                }
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
                
                // 详细说明卡片
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "text.alignleft")
                            .font(.system(size: 16))
                            .foregroundColor(.blue)
                        
                        Text("详细说明")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    
                    Text(trigram.description)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .lineSpacing(6)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 5, y: 2)
            }
            .padding(16)
        }
        .navigationTitle(trigram.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Attribute Row (优化的属性行)
struct AttributeRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            // 图标
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(iconColor)
            }
            
            // 标题
            Text(title)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.secondary)
                .frame(width: 50, alignment: .leading)
            
            // 值
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
    }
}


#Preview {
    EncyclopediaView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

