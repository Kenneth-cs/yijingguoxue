//
//  HexagramSymbolView.swift
//  易经国学堂
//
//  Created on 2025/11/29.
//

import SwiftUI

/// 卦象符号视图 - 垂直显示六爻（从上到下）
struct HexagramSymbolView: View {
    let hexagram: Hexagram
    let size: CGFloat
    let color: Color
    
    init(hexagram: Hexagram, size: CGFloat = 120, color: Color = .primary) {
        self.hexagram = hexagram
        self.size = size
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: size * 0.12) {
            // 从上往下显示六爻（position 6 到 1）
            ForEach(hexagram.lines.reversed(), id: \.position) { line in
                LineSymbol(isYang: line.isYang, width: size, color: color)
            }
        }
        .frame(width: size * 1.3) // 限制整体宽度
        .padding(.vertical, size * 0.25)
        .padding(.horizontal, size * 0.15)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

/// 单个爻的符号视图
struct LineSymbol: View {
    let isYang: Bool
    let width: CGFloat
    let color: Color
    
    // 爻的实际显示宽度和高度
    private var lineWidth: CGFloat { width }
    private var lineHeight: CGFloat { width * 0.08 }
    private var gapWidth: CGFloat { width * 0.15 }
    
    var body: some View {
        if isYang {
            // 阳爻 - 实线
            Rectangle()
                .fill(color)
                .frame(width: lineWidth, height: lineHeight)
                .cornerRadius(lineHeight * 0.2)
        } else {
            // 阴爻 - 断线（中间有间隔）
            HStack(spacing: gapWidth) {
                Rectangle()
                    .fill(color)
                    .frame(width: (lineWidth - gapWidth) / 2, height: lineHeight)
                    .cornerRadius(lineHeight * 0.2)
                
                Rectangle()
                    .fill(color)
                    .frame(width: (lineWidth - gapWidth) / 2, height: lineHeight)
                    .cornerRadius(lineHeight * 0.2)
            }
        }
    }
}

/// 从二进制字符串创建卦象
struct BinaryHexagramView: View {
    let binary: String
    let size: CGFloat
    let color: Color
    
    init(binary: String, size: CGFloat = 120, color: Color = .primary) {
        self.binary = binary
        self.size = size
        self.color = color
    }
    
    var body: some View {
        VStack(spacing: size * 0.12) {
            // 从上往下遍历二进制字符串（index 0 到 5）
            ForEach(Array(binary.enumerated()), id: \.offset) { index, char in
                LineSymbol(isYang: char == "1", width: size, color: color)
            }
        }
        .frame(width: size * 1.3) // 限制整体宽度
        .padding(.vertical, size * 0.25)
        .padding(.horizontal, size * 0.15)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 5)
    }
}

#Preview("阳爻") {
    LineSymbol(isYang: true, width: 150, color: .primary)
        .padding()
}

#Preview("阴爻") {
    LineSymbol(isYang: false, width: 150, color: .primary)
        .padding()
}

#Preview("乾卦") {
    HexagramSymbolView(hexagram: Hexagram.example)
        .padding()
}

#Preview("二进制卦象") {
    BinaryHexagramView(binary: "101010")
        .padding()
}
