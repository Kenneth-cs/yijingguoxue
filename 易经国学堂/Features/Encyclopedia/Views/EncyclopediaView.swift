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
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Hexagram Card View
struct HexagramCardView: View {
    let hexagram: Hexagram
    let isFavorite: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            // 卦象符号
            Text(hexagram.symbol)
                .font(.system(size: 40))
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(hexagram.displayName)
                        .font(.headline)
                    
                    if isFavorite {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                    }
                }
                
                Text(hexagram.trigramDescription)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(hexagram.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 3)
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
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Trigram Card View
struct TrigramCardView: View {
    let trigram: Trigram
    
    var body: some View {
        HStack(spacing: 15) {
            // 卦象符号
            Text(trigram.symbol)
                .font(.system(size: 40))
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            
            // 卦象信息
            VStack(alignment: .leading, spacing: 4) {
                Text(trigram.name)
                    .font(.headline)
                
                HStack(spacing: 15) {
                    Label(trigram.symbolism, systemImage: "cloud.sun")
                        .font(.caption)
                    
                    Label(trigram.element, systemImage: "flame")
                        .font(.caption)
                    
                    Label(trigram.direction, systemImage: "location")
                        .font(.caption)
                }
                .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
        .shadow(color: .black.opacity(0.05), radius: 3)
    }
}

// MARK: - Trigram Detail View (临时实现)
struct TrigramDetailView: View {
    let trigram: Trigram
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 卦象展示
                HStack {
                    Spacer()
                    Text(trigram.symbol)
                        .font(.system(size: 100))
                    Spacer()
                }
                .padding()
                
                // 基本信息
                VStack(alignment: .leading, spacing: 12) {
                    InfoRow(title: "五行", value: trigram.element)
                    InfoRow(title: "方位", value: trigram.direction)
                    InfoRow(title: "象征", value: trigram.symbolism)
                    InfoRow(title: "性质", value: trigram.nature)
                    InfoRow(title: "家庭", value: trigram.family)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(AppConstants.UI.cornerRadius)
                
                // 详细说明
                VStack(alignment: .leading, spacing: 8) {
                    Text("详细说明")
                        .font(.headline)
                    
                    Text(trigram.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(AppConstants.UI.cornerRadius)
            }
            .padding()
        }
        .navigationTitle(trigram.name)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Info Row
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .leading)
            
            Text(value)
                .font(.body)
        }
    }
}

#Preview {
    EncyclopediaView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

