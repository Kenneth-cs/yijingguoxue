//
//  ProfileView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {

                    // ── 用户信息卡片 ─────────────────────────────────────
                    userCard
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                    // ── 学习统计 2x2 ─────────────────────────────────────
                    statsGrid
                        .padding(.horizontal, 16)
                        .padding(.top, 16)

                    // ── 学习中心 ─────────────────────────────────────────
                    sectionHeader("学习中心")
                        .padding(.horizontal, 16)
                        .padding(.top, 28)
                        .padding(.bottom, 10)

                    studyCenterCard
                        .padding(.horizontal, 16)

                    // ── 应用设置 ─────────────────────────────────────────
                    sectionHeader("应用设置")
                        .padding(.horizontal, 16)
                        .padding(.top, 28)
                        .padding(.bottom, 10)

                    settingsCard
                        .padding(.horizontal, 16)

                    Spacer(minLength: 40)
                }
            }
            .background(Color(hex: "F5F7F9").ignoresSafeArea())
            .navigationTitle("个人中心")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    // MARK: - 用户信息卡片
    private var userCard: some View {
        HStack(spacing: 14) {
            // 头像
            Image("Avatar")
                .resizable()
                .scaledToFill()
                .frame(width: 58, height: 58)
                .clipShape(Circle())

            Text("易经学者")
                .font(AppConstants.Fonts.bold(18))
                .foregroundColor(Color(hex: "0F1729"))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(Color(hex: "C4CEDD"))
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 6, y: 2)
    }

    // MARK: - 学习统计 2x2 网格
    private var statsGrid: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                statCard(
                    title: "已学完",
                    value: "\(storageService.studyProgress.learnedHexagrams.count)",
                    unit: nil
                )
                statCard(
                    title: "我的收藏",
                    value: "\(storageService.studyProgress.favoriteHexagrams.count)",
                    unit: nil
                )
            }
            HStack(spacing: 10) {
                statCard(
                    title: "连续天数",
                    value: "\(storageService.studyProgress.studyDays)",
                    unit: nil
                )
                statCard(
                    title: "学习时长",
                    value: studyMinutes,
                    unit: "分钟"
                )
            }
        }
    }

    /// 学习时长（分钟）
    private var studyMinutes: String {
        let minutes = Int(storageService.studyProgress.totalStudyTime / 60)
        return "\(max(minutes, 0))"
    }

    private func statCard(title: String, value: String, unit: String?) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(AppConstants.Fonts.regular(12))
                .foregroundColor(Color(hex: "64748B"))

            HStack(alignment: .lastTextBaseline, spacing: 4) {
                Text(value)
                    .font(AppConstants.Fonts.bold(26))
                    .foregroundColor(Color(hex: "086B52"))
                if let unit = unit {
                    Text(unit)
                        .font(AppConstants.Fonts.regular(12))
                        .foregroundColor(Color(hex: "086B52").opacity(0.6))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .background(Color(hex: "086B52").opacity(0.05))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "086B52").opacity(0.10), lineWidth: 0.5)
        )
    }

    // MARK: - 区块标题
    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(AppConstants.Fonts.bold(13))
            .foregroundColor(Color(hex: "94A3B8"))
            .tracking(0.8)
    }

    // MARK: - 学习中心卡片
    private var studyCenterCard: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: FavoritesView()) {
                menuRow(icon: "bookmark.fill", title: "我的收藏", showDivider: true)
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: NotesView()) {
                menuRow(icon: "doc.text.fill", title: "学习笔记", showDivider: true)
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: GameRecordsView()) {
                menuRow(icon: "trophy.fill", title: "练习记录", showDivider: false)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 6, y: 2)
    }

    // MARK: - 应用设置卡片
    private var settingsCard: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: AboutView()) {
                settingsRow(title: "关于应用", isShare: false, showDivider: true)
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: PrivacyPolicyView()) {
                settingsRow(title: "隐私政策", isShare: false, showDivider: true)
            }
            .buttonStyle(PlainButtonStyle())

            NavigationLink(destination: UserAgreementView()) {
                settingsRow(title: "用户协议", isShare: false, showDivider: true)
            }
            .buttonStyle(PlainButtonStyle())

            Button(action: shareApp) {
                settingsRow(title: "分享应用", isShare: true, showDivider: false)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: Color.black.opacity(0.04), radius: 6, y: 2)
    }

    // MARK: - 菜单行（带图标）
    private func menuRow(icon: String, title: String, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: "086B52").opacity(0.10))
                        .frame(width: 38, height: 38)
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "086B52"))
                }

                Text(title)
                    .font(AppConstants.Fonts.medium(16))
                    .foregroundColor(Color(hex: "0F1729"))

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(Color(hex: "C4CEDD"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 15)

            if showDivider {
                Divider()
                    .padding(.leading, 68)
            }
        }
    }

    // MARK: - 设置行（无图标）
    private func settingsRow(title: String, isShare: Bool, showDivider: Bool) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(AppConstants.Fonts.medium(16))
                    .foregroundColor(Color(hex: "0F1729"))

                Spacer()

                Image(systemName: isShare ? "square.and.arrow.up" : "chevron.right")
                    .font(.system(size: isShare ? 15 : 13, weight: .medium))
                    .foregroundColor(Color(hex: "C4CEDD"))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 18)

            if showDivider {
                Divider()
                    .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - 分享功能
    private func shareApp() {
        let activityVC = UIActivityViewController(
            activityItems: ["易经国学堂 - 系统学习易经知识，感受中华传统文化魅力"],
            applicationActivities: nil
        )
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first,
           let rootVC = window.rootViewController {
            rootVC.present(activityVC, animated: true)
        }
    }
}

// MARK: - 收藏页
struct FavoritesView: View {
    @EnvironmentObject var dataService: DataService
    @EnvironmentObject var storageService: StorageService

    private var favoriteHexagrams: [Hexagram] {
        storageService.studyProgress.favoriteHexagrams
            .compactMap { dataService.getHexagram(by: $0) }
            .sorted { $0.id < $1.id }
    }

    var body: some View {
        ZStack {
            Color(hex: "F5F7F9").ignoresSafeArea()

            if favoriteHexagrams.isEmpty {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .fill(Color(hex: "086B52").opacity(0.08))
                            .frame(width: 88, height: 88)
                        Image(systemName: "bookmark.slash")
                            .font(.system(size: 36))
                            .foregroundColor(Color(hex: "086B52").opacity(0.4))
                    }
                    Text("还没有收藏的卦象")
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(Color(hex: "0F1729"))
                    Text("在卦象详情页点击收藏按钮即可添加")
                        .font(AppConstants.Fonts.regular(13))
                        .foregroundColor(Color(hex: "94A3B8"))
                }
            } else {
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 12) {
                        ForEach(favoriteHexagrams) { hexagram in
                            NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                                HexagramListCell(hexagram: hexagram)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(16)
                }
            }
        }
        .navigationTitle("我的收藏")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 关于页
struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Logo
                Image("Avatar")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 88, height: 88)
                    .clipShape(Circle())
                    .padding(.top, 20)

                VStack(spacing: 6) {
                    Text(AppConstants.App.name)
                        .font(AppConstants.Fonts.bold(22))
                        .foregroundColor(Color(hex: "0F1729"))
                    Text("版本 \(AppConstants.App.version)")
                        .font(AppConstants.Fonts.regular(14))
                        .foregroundColor(Color(hex: "94A3B8"))
                }

                Divider().padding(.horizontal, 32)

                VStack(alignment: .leading, spacing: 14) {
                    Text("应用介绍")
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(Color(hex: "0F1729"))
                    Text("易经国学堂是一款专注于易经学习的 iOS 应用，通过现代化的交互方式帮助用户系统学习易经知识，感受中华传统文化魅力。")
                        .font(AppConstants.Fonts.regular(15))
                        .foregroundColor(Color(hex: "64748B"))
                        .lineSpacing(5)

                    Text("主要功能")
                        .font(AppConstants.Fonts.bold(16))
                        .foregroundColor(Color(hex: "0F1729"))
                        .padding(.top, 6)

                    VStack(alignment: .leading, spacing: 10) {
                        AboutFeatureRow(icon: "book.fill", text: "六十四卦详解")
                        AboutFeatureRow(icon: "circle.grid.3x3", text: "八卦基础知识")
                        AboutFeatureRow(icon: "gamecontroller", text: "互动学习游戏")
                        AboutFeatureRow(icon: "calendar", text: "每日一卦")
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("关于应用")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 15))
                .foregroundColor(Color(hex: "086B52"))
                .frame(width: 22)
            Text(text)
                .font(AppConstants.Fonts.regular(15))
                .foregroundColor(Color(hex: "0F1729"))
        }
    }
}

// MARK: - 隐私政策
struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("易经国学堂非常重视您的隐私保护。\n\n本应用不收集任何个人信息，所有数据均存储在您的设备本地。\n\n我们不会：\n• 收集您的个人信息\n• 追踪您的使用行为\n• 向第三方分享数据\n• 使用任何分析工具\n\n您的学习记录、收藏、笔记等所有数据都安全地存储在您的设备上，只有您能够访问。")
                .font(AppConstants.Fonts.regular(15))
                .foregroundColor(Color(hex: "64748B"))
                .lineSpacing(6)
                .padding(20)
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("隐私政策")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 用户协议
struct UserAgreementView: View {
    var body: some View {
        ScrollView {
            Text("易经国学堂用户协议\n\n1. 应用定位\n本应用是一款教育学习工具，旨在帮助用户学习和了解易经传统文化知识。\n\n2. 禁止用途\n严禁将本应用用于：\n• 占卜、算命等迷信活动\n• 商业预测\n• 其他违背科学精神的用途\n\n3. 免责声明\n本应用内容仅供学习参考，不构成任何决策建议。\n\n4. 知识产权\n应用内容来源于公开资料，著作权归原作者所有。")
                .font(AppConstants.Fonts.regular(15))
                .foregroundColor(Color(hex: "64748B"))
                .lineSpacing(6)
                .padding(20)
        }
        .background(Color(hex: "F5F7F9").ignoresSafeArea())
        .navigationTitle("用户协议")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - StatBox（保留兼容旧代码）
struct StatBox: View {
    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            Text(value)
                .font(.title3).fontWeight(.bold)
            Text(title)
                .font(.caption).foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - FeatureRow（保留兼容）
struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.blue).frame(width: 24)
            Text(text).font(.body)
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}
