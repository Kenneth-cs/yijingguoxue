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
        // 配置TabBar外观
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        // 设置选中状态的颜色 - 使用更明显的蓝色
        let selectedColor = UIColor.systemBlue
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
        ]
        
        // 设置未选中状态的颜色
        let normalColor = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: normalColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // 设置全局的tintColor
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = normalColor
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 首页
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
                .tag(0)
            
            // 百科
            EncyclopediaView()
                .tabItem {
                    Label("百科", systemImage: "book.fill")
                }
                .tag(1)
            
            // 练习
            PracticeView()
                .tabItem {
                    Label("练习", systemImage: "gamecontroller.fill")
                }
                .tag(2)
            
            // 我的
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
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

