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
    @StateObject private var notificationService = NotificationService.shared

    init() {
        setupAppearance()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataService)
                .environmentObject(storageService)
                .environmentObject(notificationService)
                .onAppear {
                    // 启动时申请权限并（如已开启）调度通知
                    notificationService.requestPermission()
                }
        }
    }
    
    /// 配置全局外观
    private func setupAppearance() {
        // 全局 tint 颜色：所有返回按钮、链接控件统一为主题绿
        let themeGreen = UIColor(red: 0.03, green: 0.42, blue: 0.32, alpha: 1.0)
        UIView.appearance().tintColor = themeGreen

        // 配置导航栏外观
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()

        // 大标题（如首页"易经国学堂"）：楷体，加粗，深色
        let largeTitleFont = UIFont(name: "STKaiti", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold)
        navigationBarAppearance.largeTitleTextAttributes = [
            .font: largeTitleFont,
            .foregroundColor: UIColor(red: 0.06, green: 0.09, blue: 0.16, alpha: 1.0)
        ]

        // 普通标题（子页面 inline 模式）：楷体，标准大小
        let titleFont = UIFont(name: "STKaiti", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .semibold)
        navigationBarAppearance.titleTextAttributes = [
            .font: titleFont,
            .foregroundColor: UIColor(red: 0.06, green: 0.09, blue: 0.16, alpha: 1.0)
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().tintColor = themeGreen
        
        // 配置TabBar外观
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}
