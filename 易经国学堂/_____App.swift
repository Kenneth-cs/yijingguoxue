//
//  易经国学堂App.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

@main
struct YiJingApp: App {
    // 初始化服务
    @StateObject private var dataService = DataService.shared
    @StateObject private var storageService = StorageService.shared
    
    init() {
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataService)
                .environmentObject(storageService)
        }
    }
    
    /// 配置全局外观 - 易经主题
    private func setupAppearance() {
        // 配置导航栏外观 - 墨绿色主题
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .white
        
        // 标题样式
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(red: 0.11, green: 0.37, blue: 0.31, alpha: 1.0), // #1B5E4F
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(red: 0.11, green: 0.37, blue: 0.31, alpha: 1.0),
            .font: UIFont.systemFont(ofSize: 32, weight: .bold)
        ]
        
        // 按钮颜色
        UINavigationBar.appearance().tintColor = UIColor(red: 0.11, green: 0.37, blue: 0.31, alpha: 1.0)
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        // 配置TabBar外观（在MainTabView中已配置，这里保持一致）
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
