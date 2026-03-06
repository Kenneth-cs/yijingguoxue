//
//  PracticeView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var storageService: StorageService

    // 人生教练 App Store 链接（点击跳转，已安装则可直接打开）
    private let coachAppStoreURL = URL(string: "https://apps.apple.com/cn/app/%E4%BA%BA%E7%94%9F%E6%95%99%E7%BB%83-%E6%88%90%E9%95%BF%E4%B8%8E%E5%86%B3%E7%AD%96%E5%8A%A9%E6%89%8B/id6753138853")!

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {

                // ── Banner（点击跳转人生教练 App）────────────────────────────
                Button(action: openCoachApp) {
                    Image("YaoGuaBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity)
                        .frame(height: 140)
                        .clipped()
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.12), radius: 10, y: 5)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal, 16)
                .padding(.top, 16)

                // ── 专项练习 ───────────────────────────────────────────────
                Text("专项练习")
                    .font(AppConstants.Fonts.bold(20))
                    .foregroundColor(Color(hex: "0F1729"))
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
                    .padding(.bottom, 12)

                // 第一行：认卦游戏 / 知识问答
                HStack(spacing: 12) {
                    NavigationLink(destination: GuessGameView()) {
                        PracticeCard(icon: "square.grid.2x2", title: "认卦游戏", subtitle: "识别六十四卦象")
                    }
                    NavigationLink(destination: QuizView()) {
                        PracticeCard(icon: "questionmark.circle", title: "知识问答", subtitle: "经传理论考核")
                    }
                }
                .padding(.horizontal, 16)

                // 第二行：卦象识别 / 爻辞匹对
                HStack(spacing: 12) {
                    NavigationLink(destination: SymbolGameView()) {
                        PracticeCard(icon: "eye", title: "卦象识别", subtitle: "快速分辨阴阳爻")
                    }
                    NavigationLink(destination: LineMatchingView()) {
                        PracticeCard(icon: "list.dash", title: "爻辞匹对", subtitle: "对应位阶与涵义")
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)

                // ── 最近记录 ───────────────────────────────────────────────
                HStack {
                    Text("最近记录")
                        .font(AppConstants.Fonts.bold(20))
                        .foregroundColor(Color(hex: "0F1729"))
                    Spacer()
                    NavigationLink(destination: GameRecordsView()) {
                        Text("查看全部")
                            .font(AppConstants.Fonts.regular(14))
                            .foregroundColor(Color(hex: "086B52"))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 24)
                .padding(.bottom, 12)

                if storageService.gameRecords.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: "tray")
                            .font(.system(size: 36))
                            .foregroundColor(Color(hex: "086B52").opacity(0.3))
                        Text("暂无游戏记录")
                            .font(AppConstants.Fonts.regular(14))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 30)
                } else {
                    VStack(spacing: 10) {
                        ForEach(storageService.gameRecords.prefix(3)) { record in
                            RecordRow(record: record)
                        }
                    }
                    .padding(.horizontal, 16)
                }

                Spacer(minLength: 40)
            }
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("练习中心")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - 跳转人生教练 App
    // 已安装：App Store 页面显示「打开」按钮直接启动
    // 未安装：App Store 页面显示「获取」按钮引导下载
    private func openCoachApp() {
        UIApplication.shared.open(coachAppStoreURL)
    }
}

// MARK: - 练习卡片
struct PracticeCard: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: "086B52").opacity(0.10))
                    .frame(width: 44, height: 44)
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(Color(hex: "086B52"))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(AppConstants.Fonts.bold(15))
                    .foregroundColor(Color(hex: "0F1729"))
                Text(subtitle)
                    .font(AppConstants.Fonts.regular(12))
                    .foregroundColor(Color(hex: "64748B"))
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.05), radius: 6, y: 2)
    }
}

// MARK: - 记录行
struct RecordRow: View {
    let record: GameRecord

    var body: some View {
        HStack(spacing: 14) {
            // 分数圆圈
            ZStack {
                Circle()
                    .fill(record.score > 0
                          ? Color(hex: "086B52")
                          : Color(hex: "086B52").opacity(0.15))
                    .frame(width: 46, height: 46)
                if record.score > 0 {
                    Text("\(record.score)")
                        .font(AppConstants.Fonts.bold(14))
                        .foregroundColor(.white)
                } else {
                    Text("--")
                        .font(AppConstants.Fonts.regular(14))
                        .foregroundColor(Color(hex: "086B52").opacity(0.5))
                }
            }

            // 名称 + 时间
            VStack(alignment: .leading, spacing: 3) {
                Text(record.gameType.rawValue)
                    .font(AppConstants.Fonts.bold(15))
                    .foregroundColor(Color(hex: "0F1729"))
                Text(record.formattedDate)
                    .font(AppConstants.Fonts.regular(12))
                    .foregroundColor(Color(hex: "64748B"))
            }

            Spacer()

            // 正确率 & 状态
            VStack(alignment: .trailing, spacing: 3) {
                if record.accuracy > 0 {
                    Text("\(record.accuracy)%")
                        .font(AppConstants.Fonts.bold(14))
                        .foregroundColor(Color(hex: "086B52"))
                    Text("正确率")
                        .font(AppConstants.Fonts.regular(11))
                        .foregroundColor(Color(hex: "94A3B8"))
                } else {
                    Text("\(record.score)分")
                        .font(AppConstants.Fonts.bold(14))
                        .foregroundColor(Color(hex: "086B52"))
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 4, y: 2)
    }
}

// MARK: - 游戏记录总览页
struct GameRecordsView: View {
    @EnvironmentObject var storageService: StorageService

    var body: some View {
        ScrollView {
            if storageService.gameRecords.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "tray")
                        .font(.system(size: 48))
                        .foregroundColor(Color(hex: "94A3B8"))
                    Text("暂无游戏记录")
                        .font(AppConstants.Fonts.regular(16))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 80)
            } else {
                VStack(spacing: 10) {
                    ForEach(storageService.gameRecords) { record in
                        RecordRow(record: record)
                    }
                }
                .padding(16)
            }
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("游戏记录")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 透明色扩展（兼容旧代码）
extension Color {
    static let transparent = Color.white.opacity(0)
}

