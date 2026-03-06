//
//  HexagramDetailView.swift
//  易经国学堂
//
//  重构为锚点滚动模式：所有板块一次性展示，Tab 栏吸顶，点击跳转对应板块。
//

import SwiftUI

struct HexagramDetailView: View {
    @EnvironmentObject var storageService: StorageService
    @Environment(\.presentationMode) var presentationMode
    let hexagram: Hexagram

    @State private var isFavorite = false
    @State private var activeTab = 0 // 0:卦辞 1:白话 2:爻辞

    // 各板块的 ScrollViewReader ID
    private let idGuaci  = "sec_guaci"
    private let idBaihua = "sec_baihua"
    private let idYaoci  = "sec_yaoci"

    var body: some View {
        ZStack {
            Color(red: 0.96, green: 0.97, blue: 0.97).ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    // 使用 pinnedViews 让 Section header（Tab 栏）吸顶
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {

                        // ── 头部区域（随页面滚动，不吸顶）─────────────────────
                        Section {
                            headerCard
                        }

                        // ── 主内容区域（Tab 栏吸顶）──────────────────────────
                        Section(header: anchorTabBar(proxy: proxy)) {
                            VStack(spacing: 28) {
                                // 卦辞板块
                                guaciSection
                                    .id(idGuaci)

                                // 白话释义板块
                                baihuaSection
                                    .id(idBaihua)

                                // 爻辞板块
                                yaociSection
                                    .id(idYaoci)
                            }
                            .padding(.top, 20)
                            .padding(.bottom, 100)
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(AppConstants.Colors.deepGreen)
                        .font(.system(size: 16, weight: .semibold))
                }
            }
            ToolbarItem(placement: .principal) {
                Text("卦象详情")
                    .font(AppConstants.Fonts.bold(18))
                    .foregroundColor(AppConstants.Colors.textPrimary)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? AppConstants.Colors.gold : AppConstants.Colors.textTertiary)
                }
            }
        }
        .onAppear {
            isFavorite = storageService.isFavorite(hexagram.id)
            storageService.markHexagramAsLearned(hexagram.id)
        }
    }

    // MARK: - 吸顶 Tab 栏
    /// 点击后平滑滚动到对应板块，并高亮对应 Tab
    private func anchorTabBar(proxy: ScrollViewProxy) -> some View {
        HStack(spacing: 0) {
            anchorTab(title: "卦辞",   index: 0, sectionId: idGuaci,  proxy: proxy)
            anchorTab(title: "白话",   index: 1, sectionId: idBaihua, proxy: proxy)
            anchorTab(title: "爻辞",   index: 2, sectionId: idYaoci,  proxy: proxy)
        }
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(AppConstants.Colors.deepGreen.opacity(0.12)),
            alignment: .bottom
        )
    }

    private func anchorTab(title: String, index: Int, sectionId: String, proxy: ScrollViewProxy) -> some View {
        Button {
            activeTab = index
            withAnimation(.easeInOut(duration: 0.35)) {
                proxy.scrollTo(sectionId, anchor: .top)
            }
        } label: {
            VStack(spacing: 10) {
                Text(title)
                    .font(activeTab == index ? AppConstants.Fonts.bold(14) : AppConstants.Fonts.regular(14))
                    .foregroundColor(activeTab == index ? AppConstants.Colors.deepGreen : AppConstants.Colors.textSecondary)
                    .padding(.top, 14)

                // 高亮指示线
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(activeTab == index ? AppConstants.Colors.deepGreen : .clear)
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - 头部卡片
    private var headerCard: some View {
        VStack(spacing: 20) {
            // 卦象符号
            HexagramSymbolView(hexagram: hexagram, size: 90, color: AppConstants.Colors.deepGreen)
                .padding(24)
                .frame(width: 160, height: 160)
                .background(AppConstants.Colors.deepGreen.opacity(0.05))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(AppConstants.Colors.deepGreen.opacity(0.10), lineWidth: 0.5)
                )

            // 卦名信息
            VStack(spacing: 8) {
                Text("第\(numberToChinese(hexagram.id))卦")
                    .font(AppConstants.Fonts.bold(14))
                    .tracking(1.4)
                    .foregroundColor(AppConstants.Colors.deepGreen)

                HStack(alignment: .lastTextBaseline, spacing: 8) {
                    Text(hexagram.chineseName)
                        .font(Font.custom("Songti SC Bold", size: 30))
                        .foregroundColor(AppConstants.Colors.textPrimary)

                    if let pinyin = hexagram.pinyin, !pinyin.isEmpty {
                        Text("(\(pinyin.capitalized))")
                            .font(Font.custom("Songti SC", size: 20))
                            .foregroundColor(AppConstants.Colors.textSecondary)
                    }
                }

                // 结构 & 意象标签
                HStack(spacing: 8) {
                    TagView(text: hexagram.structure)
                    TagView(text: hexagram.image)
                }

                // 核心引语
                if !hexagram.summary.isEmpty {
                    Text("\u{201C}\(hexagram.summary)\u{201D}")
                        .font(AppConstants.Fonts.regular(16))
                        .lineSpacing(6)
                        .foregroundColor(AppConstants.Colors.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.top, 4)
                        .padding(.horizontal, 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .padding(.horizontal, 24)
        .background(Color.white)
    }

    // MARK: - 卦辞板块
    private var guaciSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 板块标题
            DetailSectionHeader(sfSymbol: "book.closed.fill", title: "卦辞", subtitle: "Judgement")
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 0) {
                // 卦辞原文
                VStack(alignment: .leading, spacing: 10) {
                    Text(hexagram.description)
                        .font(AppConstants.Fonts.bold(18))
                        .lineSpacing(10)
                        .foregroundColor(AppConstants.Colors.textPrimary)
                }
                .padding(20)

                // 彖传
                if !hexagram.tuan.isEmpty {
                    Divider().padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("《彖》曰")
                            .font(AppConstants.Fonts.bold(13))
                            .foregroundColor(AppConstants.Colors.deepGreen)

                        Text(hexagram.tuan)
                            .font(AppConstants.Fonts.regular(14))
                            .lineSpacing(8)
                            .foregroundColor(AppConstants.Colors.textSecondary)
                    }
                    .padding(20)
                }

                // 大象传
                if !hexagram.greatXiang.isEmpty {
                    Divider().padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("《象》曰")
                            .font(AppConstants.Fonts.bold(13))
                            .foregroundColor(AppConstants.Colors.deepGreen)

                        Text(hexagram.greatXiang)
                            .font(AppConstants.Fonts.regular(14))
                            .lineSpacing(8)
                            .foregroundColor(AppConstants.Colors.textSecondary)
                    }
                    .padding(20)
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .cardShadow()
            .padding(.horizontal, 16)
        }
    }

    // MARK: - 白话释义板块
    private var baihuaSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            DetailSectionHeader(sfSymbol: "text.alignleft", title: "白话释义", subtitle: "Modern")
                .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 0) {
                // 释义
                if !hexagram.interpretation.isEmpty {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("【释义】")
                            .font(AppConstants.Fonts.bold(15))
                            .foregroundColor(AppConstants.Colors.deepGreen)

                        Text(hexagram.interpretation)
                            .font(AppConstants.Fonts.regular(15))
                            .lineSpacing(8)
                            .foregroundColor(AppConstants.Colors.textPrimary)
                    }
                    .padding(20)
                }

                // 运势
                if !hexagram.fortune.isEmpty {
                    Divider().padding(.horizontal, 20)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("【运势】")
                            .font(AppConstants.Fonts.bold(15))
                            .foregroundColor(AppConstants.Colors.deepGreen)

                        Text(hexagram.fortune)
                            .font(AppConstants.Fonts.regular(15))
                            .lineSpacing(8)
                            .foregroundColor(AppConstants.Colors.textPrimary)
                    }
                    .padding(20)
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .cardShadow()
            .padding(.horizontal, 16)
        }
    }

    // MARK: - 爻辞板块
    private var yaociSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            DetailSectionHeader(sfSymbol: "list.bullet.rectangle", title: "爻辞", subtitle: "Line Statements")
                .padding(.horizontal, 16)

            VStack(spacing: 12) {
                ForEach(hexagram.lines, id: \.position) { line in
                    LineItemView(line: line)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // MARK: - Helpers
    private func toggleFavorite() {
        storageService.toggleFavorite(hexagram.id)
        isFavorite.toggle()
    }

    private func numberToChinese(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        formatter.locale = Locale(identifier: "zh_CN")
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

// MARK: - 板块标题组件
struct DetailSectionHeader: View {
    let sfSymbol: String
    let title: String
    let subtitle: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: sfSymbol)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppConstants.Colors.deepGreen)

            Text(title)
                .font(AppConstants.Fonts.bold(18))
                .foregroundColor(AppConstants.Colors.textPrimary)

            Text("· \(subtitle)")
                .font(AppConstants.Fonts.regular(13))
                .foregroundColor(AppConstants.Colors.textSecondary)

            Spacer()
        }
    }
}

// MARK: - 标签组件（保持不变）
struct TagView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(AppConstants.Fonts.regular(12))
            .foregroundColor(AppConstants.Colors.deepGreen)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(AppConstants.Colors.deepGreen.opacity(0.08))
            .cornerRadius(100)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(AppConstants.Colors.deepGreen.opacity(0.2), lineWidth: 0.5)
            )
    }
}

// MARK: - 单爻条目组件
struct LineItemView: View {
    let line: Hexagram.Line

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 爻位 + 阴阳标签
            HStack {
                HStack(spacing: 6) {
                    Text(linePositionName)
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(AppConstants.Colors.deepGreen)

                    if let english = linePositionEnglish {
                        Text("(\(english))")
                            .font(AppConstants.Fonts.regular(12))
                            .foregroundColor(AppConstants.Colors.textSecondary)
                    }
                }

                Spacer()

                Text(line.isYang ? "阳爻" : "阴爻")
                    .font(AppConstants.Fonts.regular(12))
                    .foregroundColor(AppConstants.Colors.textTertiary)
            }

            // 爻辞原文
            Text(line.text)
                .font(AppConstants.Fonts.bold(15))
                .lineSpacing(6)
                .foregroundColor(AppConstants.Colors.textPrimary)

            // 白话解释
            Text(line.interpretation)
                .font(AppConstants.Fonts.regular(14))
                .lineSpacing(6)
                .foregroundColor(AppConstants.Colors.textSecondary)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .cardShadow()
        .overlay(
            // 左侧绿色装饰条
            Rectangle()
                .frame(width: 3)
                .foregroundColor(AppConstants.Colors.deepGreen)
                .cornerRadius(1.5)
                .padding(.vertical, 10),
            alignment: .leading
        )
    }

    private var linePositionName: String {
        let positions = ["初", "二", "三", "四", "五", "上"]
        let i = line.position - 1
        guard i >= 0, i < positions.count else { return "第\(line.position)爻" }
        return "\(positions[i])\(line.isYang ? "九" : "六")"
    }

    private var linePositionEnglish: String? {
        let names = ["Initial", "Second", "Third", "Fourth", "Fifth", "Top"]
        let suffixes = ["Six", "Nine"]
        let i = line.position - 1
        guard i >= 0, i < names.count else { return nil }
        return "\(names[i]) \(line.isYang ? suffixes[1] : suffixes[0])"
    }
}

// MARK: - 卡片阴影修饰
private extension View {
    func cardShadow() -> some View {
        self.shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    NavigationView {
        HexagramDetailView(hexagram: Hexagram.example)
            .environmentObject(StorageService.shared)
    }
}
