//
//  EventTracker.swift
//  易经国学堂
//
//  数据埋点上报服务 - 统一管理所有分析事件
//

import Foundation
import UIKit

/// 埋点事件追踪单例
/// 负责生成用户ID并上报所有分析事件到后端
final class EventTracker {

    // MARK: - Singleton
    static let shared = EventTracker()

    // MARK: - Private Constants
    private let kApiBase   = "https://www.superindividual.youqukeji.cn"
    private let kApiKey    = "cplt_960de2824798753f015d4d1e17666b97cbbc61c1491cec5339db567b9713b4a6"
    private let kProjectId = "cmoydglev00j5oyc4penjkdkm"

    // MARK: - User / Device Identity
    /// 设备唯一标识（IDFV）
    private let deviceId: String
    /// 当前用户 ID（无账号体系时使用 device_ 前缀）
    private(set) var currentUserId: String

    private init() {
        let idfv = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        self.deviceId      = idfv
        self.currentUserId = "device_\(idfv)"
    }

    // MARK: - Public Methods

    /// 未来接入账号登录后，调用此方法将真实用户 ID 绑定
    func updateUserId(with realUserId: String) {
        currentUserId = realUserId
    }

    /// 统一事件上报入口
    /// - Parameters:
    ///   - eventId:   事件唯一标识，如 `app_launch`
    ///   - eventName: 事件中文名称，如 `App启动`
    ///   - params:    业务附加参数（可选）
    func trackEvent(eventId: String, eventName: String, params: [String: Any]? = nil) {
        let body: [String: Any] = [
            "projectId": kProjectId,
            "userId":    currentUserId,
            "deviceId":  deviceId,
            "eventId":   eventId,
            "eventName": eventName,
            "params":    params ?? [:],
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
            "osVersion":  UIDevice.current.systemVersion,
            "occurredAt": ISO8601DateFormatter().string(from: Date())
        ]

        guard let url = URL(string: "\(kApiBase)/api/events") else { return }
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("application/json",        forHTTPHeaderField: "Content-Type")
        req.setValue("Bearer \(kApiKey)",        forHTTPHeaderField: "Authorization")

        do {
            req.httpBody = try JSONSerialization.data(withJSONObject: body)
            #if DEBUG
            print("[EventTracker] ➡️ 上报事件: \(eventId) | \(eventName) | params: \(params ?? [:])")
            #endif
            URLSession.shared.dataTask(with: req) { data, response, error in
                #if DEBUG
                if let error = error {
                    print("[EventTracker] ❌ 网络错误: \(error.localizedDescription)")
                } else if let http = response as? HTTPURLResponse {
                    let body = data.flatMap { String(data: $0, encoding: .utf8) } ?? ""
                    print("[EventTracker] ✅ 响应 HTTP \(http.statusCode): \(body)")
                }
                #endif
            }.resume()
        } catch {
            #if DEBUG
            print("[EventTracker] ❌ 序列化失败: \(error)")
            #endif
        }
    }
}

// MARK: - Convenience Event Methods

extension EventTracker {

    // MARK: 基础活跃
    /// App 启动 / 从后台切到前台
    func trackAppLaunch(isFirstOpen: Bool) {
        trackEvent(
            eventId:   "app_launch",
            eventName: "App启动",
            params:    ["is_first_open": isFirstOpen]
        )
    }

    // MARK: 学习百科
    /// 进入百科主页
    func trackWikiViewPage() {
        trackEvent(eventId: "wiki_view_page", eventName: "浏览百科主页")
    }

    /// 点击百科文章
    func trackWikiClickArticle(articleId: String, articleName: String, category: String) {
        trackEvent(
            eventId:   "wiki_click_article",
            eventName: "点击百科内容",
            params:    [
                "article_id":   articleId,
                "article_name": articleName,
                "category":     category
            ]
        )
    }

    // MARK: 游戏与训练
    /// 点击游戏入口
    func trackGameClickEntrance(gameType: String) {
        trackEvent(
            eventId:   "game_click_entrance",
            eventName: "点击游戏入口",
            params:    ["game_type": gameType]
        )
    }

    /// 开始游戏训练
    func trackGameStartTraining(gameType: String) {
        trackEvent(
            eventId:   "game_start_training",
            eventName: "开始游戏训练",
            params:    ["game_type": gameType]
        )
    }

    /// 完成游戏训练
    func trackGameFinishTraining(gameType: String, score: Int, durationSec: Int) {
        trackEvent(
            eventId:   "game_finish_training",
            eventName: "完成游戏训练",
            params:    [
                "game_type":    gameType,
                "score":        score,
                "duration_sec": durationSec
            ]
        )
    }

    // MARK: 运营Banner
    /// 点击首页 Banner
    func trackHomeClickBanner(bannerId: String = "b_home_001",
                              bannerName: String = "首页Banner",
                              targetUrl: String = "") {
        trackEvent(
            eventId:   "home_click_banner",
            eventName: "点击首页Banner",
            params:    [
                "banner_id":   bannerId,
                "banner_name": bannerName,
                "target_url":  targetUrl
            ]
        )
    }

    /// 点击练习中心 Banner
    func trackPracticeClickBanner(bannerId: String = "b_practice_001",
                                  bannerName: String = "练习中心Banner",
                                  targetUrl: String = "") {
        trackEvent(
            eventId:   "practice_click_banner",
            eventName: "点击练习中心Banner",
            params:    [
                "banner_id":   bannerId,
                "banner_name": bannerName,
                "target_url":  targetUrl
            ]
        )
    }
}