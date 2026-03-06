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
        
        // TabBar 背景色（白色，与卡片一致）
        appearance.backgroundColor = UIColor.white
        
        // 选中状态 - 深绿色
        let selectedColor = UIColor(red: 0.106, green: 0.369, blue: 0.310, alpha: 1.0) // #1B5E4F
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: selectedColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .semibold)
        ]
        
        // 未选中状态 - 中灰色
        let normalColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0) // #999999
        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: normalColor,
            .font: UIFont.systemFont(ofSize: 10, weight: .regular)
        ]
        
        // 顶部分隔线（极淡）
        appearance.shadowColor = UIColor(white: 0, alpha: 0.08)
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        UITabBar.appearance().tintColor = selectedColor
        UITabBar.appearance().unselectedItemTintColor = normalColor
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 首页
            HomeView()
                .tabItem {
                    Label("首页", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            // 百科
            NavigationView {
                EncyclopediaView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("百科", systemImage: selectedTab == 1 ? "books.vertical.fill" : "books.vertical")
            }
            .tag(1)
            
            // 练习
            PracticeView()
                .tabItem {
                    Label("练习", systemImage: selectedTab == 2 ? "graduationcap.fill" : "graduationcap")
                }
                .tag(2)
            
            // 我的
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: selectedTab == 3 ? "person.fill" : "person")
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

