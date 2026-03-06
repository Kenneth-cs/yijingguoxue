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
    @State private var selectedSegment = 0 // 0: 六十四卦, 1: 八经卦
    
    init(initialSegment: Int = 0) {
        _selectedSegment = State(initialValue: initialSegment)
    }
    
    var body: some View {
        ZStack {
            // 背景色
            Color(red: 0.96, green: 0.97, blue: 0.97).ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 1. 顶部搜索栏
                searchBar
                
                // 2. 分段控制器
                segmentControl
                
                // 3. 内容列表
                ScrollView {
                    LazyVStack(spacing: 16) {
                        if selectedSegment == 0 {
                            hexagramList
                        } else {
                            trigramList
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 100) // 留出底部 TabBar 空间
                }
            }
        }
        .navigationTitle("易经百科") // 实际上 UI 可能隐藏了原生导航栏，用自定义的
        .navigationBarHidden(true)
    }
    
    // MARK: - 1. Search Bar
    private var searchBar: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(AppConstants.Colors.deepGreen.opacity(0.6))
                
                TextField("搜索卦辞、象传或关键词", text: $searchText)
                    .font(AppConstants.Fonts.regular(16))
                    .foregroundColor(AppConstants.Colors.textPrimary)
            }
            .padding(12)
            .background(AppConstants.Colors.deepGreen.opacity(0.05))
            .cornerRadius(8)
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 12)
        .background(Color.white)
    }
    
    // MARK: - 2. Segment Control
    private var segmentControl: some View {
        HStack(spacing: 0) {
            segmentButton(title: "六十四卦", index: 0)
            segmentButton(title: "八经卦", index: 1)
        }
        .padding(.horizontal, 16)
        .background(Color.white)
    }
    
    private func segmentButton(title: String, index: Int) -> some View {
        Button(action: { selectedSegment = index }) {
            VStack(spacing: 12) {
                Text(title)
                    .font(AppConstants.Fonts.bold(14))
                    .foregroundColor(selectedSegment == index ? AppConstants.Colors.deepGreen : AppConstants.Colors.textTertiary)
                    .padding(.top, 16)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(selectedSegment == index ? AppConstants.Colors.deepGreen : .clear)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - 3. Lists
    
    private var hexagramList: some View {
        ForEach(filteredHexagrams) { hexagram in
            NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                HexagramListCell(hexagram: hexagram)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var trigramList: some View {
        ForEach(dataService.trigrams) { trigram in
            NavigationLink(destination: TrigramDetailView(trigram: trigram)) {
                TrigramListCell(trigram: trigram)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    // MARK: - Helpers
    private var filteredHexagrams: [Hexagram] {
        if searchText.isEmpty {
            return dataService.hexagrams
        } else {
            return dataService.searchHexagrams(query: searchText)
        }
    }
}

// MARK: - List Cells

struct HexagramListCell: View {
    let hexagram: Hexagram
    
    var body: some View {
        HStack(spacing: 16) {
            // 左侧：序号图片 (绿色块)
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppConstants.Colors.deepGreen)
                    .frame(width: 56, height: 56)
                
                Text(hexagram.symbol)
                    .font(.system(size: 36))
                    .foregroundColor(.white.opacity(0.9))
                    .offset(y: -2)
                
                // 序号
                Text(String(format: "%02d", hexagram.id))
                    .font(AppConstants.Fonts.bold(10))
                    .foregroundColor(.white.opacity(0.6))
                    .padding(4)
                    .background(Color.black.opacity(0.2))
                    .cornerRadius(4)
                    .offset(x: 18, y: 18)
            }
            
            // 中间：信息
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text("\(hexagram.id). \(hexagram.chineseName)")
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(AppConstants.Colors.textPrimary)
                    
                    Text(hexagram.structure) // 结构/方位
                        .font(AppConstants.Fonts.regular(12))
                        .foregroundColor(AppConstants.Colors.deepGreen)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(AppConstants.Colors.deepGreen.opacity(0.1))
                        .cornerRadius(100)
                }
                
                Text(hexagram.summary)
                    .font(AppConstants.Fonts.regular(14))
                    .foregroundColor(AppConstants.Colors.textSecondary)
                    .lineLimit(2)
                    .lineSpacing(4)
            }
            
            Spacer()
            
            // 右侧：阴阳标记 (如果有)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

struct TrigramListCell: View {
    let trigram: Trigram
    
    var body: some View {
        HStack(spacing: 16) {
            // 左侧：卦符
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(AppConstants.Colors.deepGreen)
                    .frame(width: 56, height: 56)
                
                Text(trigram.symbol)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            
            // 中间：信息
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Text(trigram.name)
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(AppConstants.Colors.textPrimary)
                    
                    Text(trigram.direction)
                        .font(AppConstants.Fonts.regular(12))
                        .foregroundColor(AppConstants.Colors.deepGreen)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(AppConstants.Colors.deepGreen.opacity(0.1))
                        .cornerRadius(100)
                }
                
                Text(trigram.nature)
                    .font(AppConstants.Fonts.regular(14))
                    .foregroundColor(AppConstants.Colors.textSecondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

#Preview {
    EncyclopediaView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}
