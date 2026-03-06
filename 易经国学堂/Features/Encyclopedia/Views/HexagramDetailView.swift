//
//  HexagramDetailView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct HexagramDetailView: View {
    @EnvironmentObject var storageService: StorageService
    let hexagram: Hexagram
    
    @State private var isFavorite = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 卦象展示
                hexagramHeader
                
                // 卦辞
                hexagramDescription
                
                // 白话释义
                interpretation
                
                // 爻辞
                linesSection
            }
            .padding()
        }
        .navigationTitle(hexagram.chineseName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            isFavorite = storageService.isFavorite(hexagram.id)
            storageService.markHexagramAsLearned(hexagram.id)
        }
    }
    
    // MARK: - Hexagram Header
    private var hexagramHeader: some View {
        VStack(spacing: 15) {
            // 垂直卦象符号
            HexagramSymbolView(hexagram: hexagram, size: 120)
            
            // 卦名
            Text(hexagram.chineseName)
                .font(.title)
                .fontWeight(.bold)
            
            // 组成信息
            HStack(spacing: 20) {
                Label(hexagram.trigramDescription, systemImage: "square.split.2x1")
                
                Label("阳\(hexagram.yangCount) 阴\(hexagram.yinCount)", systemImage: "circle.grid.cross")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            LinearGradient(
                colors: [Color(.systemGray6), Color(.systemGray5)],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    // MARK: - Hexagram Description
    private var hexagramDescription: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("卦辞")
                .font(.headline)
            
            Text(hexagram.description)
                .font(.title3)
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemBackground))
                .cornerRadius(8)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    // MARK: - Interpretation
    private var interpretation: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("白话释义")
                .font(.headline)
            
            Text(hexagram.interpretation)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    // MARK: - Lines Section
    private var linesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("爻辞")
                .font(.headline)
                .padding(.horizontal)
            
            ForEach(hexagram.lines.reversed(), id: \.position) { line in
                LineCardView(line: line)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(AppConstants.UI.cornerRadius)
    }
    
    // MARK: - Actions
    private func toggleFavorite() {
        storageService.toggleFavorite(hexagram.id)
        isFavorite.toggle()
    }
}

// MARK: - Line Card View
struct LineCardView: View {
    let line: Hexagram.Line
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // 爻位标识
                Text(linePositionName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(line.isYang ? .blue : .red)
                
                // 阴阳标识
                Image(systemName: line.isYang ? "circle.fill" : "circle")
                    .font(.caption)
                    .foregroundColor(line.isYang ? .blue : .red)
                
                Spacer()
            }
            
            // 爻辞
            Text(line.text)
                .font(.body)
                .fontWeight(.medium)
            
            // 白话解释
            Text(line.interpretation)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineSpacing(2)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
    
    private var linePositionName: String {
        let positions = ["初", "二", "三", "四", "五", "上"]
        let positionIndex = line.position - 1
        guard positionIndex >= 0, positionIndex < positions.count else {
            return "第\(line.position)爻"
        }
        
        let prefix = line.isYang ? "九" : "六"
        return "\(positions[positionIndex])\(prefix)"
    }
}

#Preview {
    NavigationView {
        HexagramDetailView(hexagram: Hexagram.example)
            .environmentObject(StorageService.shared)
    }
}

