//
//  ZenComponents.swift
//  易经国学堂
//
//  新中式禅意UI组件
//  Created on 2025/11/17.
//

import SwiftUI

// MARK: - 宣纸质感背景
struct PaperBackground: View {
    var body: some View {
        ZStack {
            // 基础宣纸色
            AppConstants.Colors.paperBackground
                .ignoresSafeArea()
            
            // 微妙的纹理效果（通过渐变模拟）
            LinearGradient(
                colors: [
                    Color.white.opacity(0.3),
                    Color.clear,
                    Color.black.opacity(0.02)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .blendMode(.overlay)
        }
    }
}

// MARK: - 禅意卡片容器
struct ZenCard<Content: View>: View {
    let content: Content
    var useAccentGradient: Bool = false
    var padding: CGFloat = 20
    
    init(
        useAccentGradient: Bool = false,
        padding: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.useAccentGradient = useAccentGradient
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        content
            .padding(padding)
            .background(
                ZStack {
                    // 卡片背景
                    if useAccentGradient {
                        AppConstants.Colors.accentGradient
                    } else {
                        AppConstants.Colors.cardGradient
                    }
                    
                    // 微妙的边框
                    RoundedRectangle(cornerRadius: AppConstants.UI.cardCornerRadius)
                        .strokeBorder(
                            AppConstants.Colors.textTertiary.opacity(0.1),
                            lineWidth: 0.5
                        )
                }
            )
            .cornerRadius(AppConstants.UI.cardCornerRadius)
            .shadow(
                color: Color.black.opacity(AppConstants.UI.shadowOpacity),
                radius: AppConstants.UI.cardShadowRadius,
                y: AppConstants.UI.cardShadowY
            )
    }
}

// MARK: - 传统纹样装饰
struct TraditionalPattern: View {
    var opacity: Double = 0.05
    var size: CGFloat = 60
    
    var body: some View {
        Image(systemName: "cloud")
            .font(.system(size: size))
            .foregroundColor(AppConstants.Colors.gold)
            .opacity(opacity)
            .rotationEffect(.degrees(15))
    }
}

// MARK: - 属性标签（用于五行、方位等）
struct AttributeTag: View {
    let icon: String
    let text: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))
            
            Text(text)
                .font(AppConstants.Fonts.caption)
        }
        .foregroundColor(color)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color.opacity(0.12))
        .cornerRadius(8)
    }
}

// MARK: - 属性网格项（用于八卦详情页）
struct AttributeGridItem: View {
    let icon: String
    let iconColor: Color
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            // 图标圆形背景
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.15))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(iconColor)
            }
            
            // 标题
            Text(title)
                .font(AppConstants.Fonts.caption)
                .foregroundColor(AppConstants.Colors.textSecondary)
            
            // 值
            Text(value)
                .font(AppConstants.Fonts.headline)
                .foregroundColor(AppConstants.Colors.textPrimary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(AppConstants.Colors.cardBackground)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(iconColor.opacity(0.2), lineWidth: 1)
        )
    }
}

// MARK: - 卦象符号容器（带装饰背景）
struct SymbolContainer: View {
    let symbol: String
    var size: CGFloat = 100
    var showGlow: Bool = false
    
    var body: some View {
        ZStack {
            // 背景圆形
            Circle()
                .fill(AppConstants.Colors.symbolGradient)
                .frame(width: size * 1.8, height: size * 1.8)
            
            // 内圈装饰
            Circle()
                .strokeBorder(
                    AppConstants.Colors.gold.opacity(0.3),
                    lineWidth: 2
                )
                .frame(width: size * 1.5, height: size * 1.5)
            
            // 符号
            Text(symbol)
                .font(.system(size: size, weight: .light))
                .foregroundColor(AppConstants.Colors.textPrimary)
            
            // 发光效果（可选）
            if showGlow {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                AppConstants.Colors.gold.opacity(0.3),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: size * 0.5,
                            endRadius: size * 1.2
                        )
                    )
                    .frame(width: size * 2, height: size * 2)
                    .blendMode(.screen)
            }
        }
    }
}

// MARK: - 分隔线（中式风格）
struct ZenDivider: View {
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(AppConstants.Colors.gold.opacity(0.5))
                .frame(width: 4, height: 4)
            
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [
                            AppConstants.Colors.textTertiary.opacity(0.3),
                            AppConstants.Colors.gold.opacity(0.5),
                            AppConstants.Colors.textTertiary.opacity(0.3)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 1)
            
            Circle()
                .fill(AppConstants.Colors.gold.opacity(0.5))
                .frame(width: 4, height: 4)
        }
    }
}

// MARK: - 章节标题（带装饰）
struct SectionHeader: View {
    let icon: String
    let title: String
    var iconColor: Color = AppConstants.Colors.cinnabar
    
    var body: some View {
        HStack(spacing: 10) {
            // 装饰线
            Rectangle()
                .fill(iconColor)
                .frame(width: 4, height: 20)
                .cornerRadius(2)
            
            // 图标
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(iconColor)
            
            // 标题
            Text(title)
                .font(AppConstants.Fonts.title3)
                .foregroundColor(AppConstants.Colors.textPrimary)
            
            Spacer()
        }
    }
}

// MARK: - 预览
#Preview("禅意卡片") {
    ZStack {
        PaperBackground()
        
        VStack(spacing: 20) {
            ZenCard {
                VStack(alignment: .leading, spacing: 12) {
                    Text("乾卦")
                        .font(AppConstants.Fonts.title1)
                    
                    Text("乾为天，纯阳之卦，象征刚健、进取、创造。")
                        .font(AppConstants.Fonts.bodyText)
                        .foregroundColor(AppConstants.Colors.textSecondary)
                }
            }
            
            ZenCard(useAccentGradient: true) {
                SymbolContainer(symbol: "☰", size: 80)
            }
        }
        .padding()
    }
}

