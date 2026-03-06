//
//  TrigramDetailView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

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
