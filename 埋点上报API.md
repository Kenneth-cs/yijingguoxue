
APIkey:
cplt_960de2824798753f015d4d1e17666b97cbbc61c1491cec5339db567b9713b4a6


iOS Swift 接入示例
private let kApiBase = "https://www.superindividual.youqukeji.cn"
private let kApiKey  = "cplt_你的API Key"

func trackEvent(eventId: String, eventName: String, params: [String: Any]? = nil) {
    let body: [String: Any] = [
        "projectId": "cmoydglev00j5oyc4penjkdkm",
        "deviceId": UIDevice.current.identifierForVendor?.uuidString ?? "unknown",
        "eventId": eventId, "eventName": eventName,
        "params": params ?? [:],
        "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0",
        "osVersion": UIDevice.current.systemVersion,
        "occurredAt": ISO8601DateFormatter().string(from: Date())
    ]
    var req = URLRequest(url: URL(string: "\(kApiBase)/api/events")!)
    req.httpMethod = "POST"
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
    req.setValue("Bearer \(kApiKey)", forHTTPHeaderField: "Authorization")
    req.httpBody = try? JSONSerialization.data(withJSONObject: body)
    URLSession.shared.dataTask(with: req).resume()
}

// ── 使用示例 ──────────────────────────────────────────────
// 记账成功
trackEvent(
    eventId: "record_submit_success",
    eventName: "记账成功",
    params: ["category": "餐饮", "amount_level": "level_1_under100"]
)

// 点击记一笔入口
trackEvent(eventId: "record_click_add", eventName: "点击记一笔入口")

// 完成引导
trackEvent(
    eventId: "onboarding_complete",
    eventName: "完成引导",
    params: ["steps_skipped": 0]
)