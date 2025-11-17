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
    
    /// 配置全局外观
    private func setupAppearance() {
        // 配置导航栏外观
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        // 配置TabBar外观
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
