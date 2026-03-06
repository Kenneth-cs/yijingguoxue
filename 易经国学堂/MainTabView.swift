//
//  MainTabView.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        // 纯白背景（匹配设计图二）
        appearance.backgroundColor = UIColor.white

        // 顶部细分隔线（浅灰）
        appearance.shadowColor = UIColor(red: 0.03, green: 0.42, blue: 0.32, alpha: 0.10)

        // 选中颜色：主题绿
        let selectedColor = UIColor(red: 0.03, green: 0.42, blue: 0.32, alpha: 1.0) // #0B6B52
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor,
            .font: UIFont(name: "Songti SC", size: 11) ?? UIFont.systemFont(ofSize: 11, weight: .medium)
        ]

        // 未选中颜色：中灰（匹配图二的灰色标签）
        let normalColor = UIColor(red: 0.38, green: 0.43, blue: 0.53, alpha: 1.0) // #606878
        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: normalColor,
            .font: UIFont(name: "Songti SC", size: 11) ?? UIFont.systemFont(ofSize: 11)
        ]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = normalColor
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // 首页 - 自定义图标
            HomeView()
                .tabItem {
                    Label {
                        Text("首页")
                    } icon: {
                        Image("tab_首页")
                            .renderingMode(.template)
                    }
                }
                .tag(0)

            // 百科 - 自定义图标
            NavigationView {
                EncyclopediaView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label {
                    Text("百科")
                } icon: {
                    Image("tab_百科")
                        .renderingMode(.template)
                }
            }
            .tag(1)

            // 练习 - 自定义图标
            PracticeView()
                .tabItem {
                    Label {
                        Text("练习")
                    } icon: {
                        Image("tab_练习")
                            .renderingMode(.template)
                    }
                }
                .tag(2)

            // 我的 - 自定义图标
            ProfileView()
                .tabItem {
                    Label {
                        Text("我的")
                    } icon: {
                        Image("tab_我的")
                            .renderingMode(.template)
                    }
                }
                .tag(3)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(DataService.shared)
        .environmentObject(StorageService.shared)
}

