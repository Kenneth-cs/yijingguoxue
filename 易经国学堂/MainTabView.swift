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
        // 配置TabBar外观 - 新中式配色
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // 使用米白色背景
        appearance.backgroundColor = UIColor(red: 0.97, green: 0.96, blue: 0.94, alpha: 1.0) // #F7F5F0
        
        // 设置选中状态的颜色 - 使用朱砂红
        let selectedColor = UIColor(red: 0.75, green: 0.28, blue: 0.32, alpha: 1.0) // #C04851
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
        ]
        
        // 设置未选中状态的颜色 - 使用淡墨色
        let normalColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // #999999
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
            NavigationView {
                EncyclopediaView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
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

