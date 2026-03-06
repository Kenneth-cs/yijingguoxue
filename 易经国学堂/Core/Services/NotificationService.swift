//
//  NotificationService.swift
//  易经国学堂
//
//  每日个性化推送通知服务
//

import Foundation
import UserNotifications

class NotificationService: NSObject, ObservableObject {
    static let shared = NotificationService()

    // MARK: - 持久化 Key
    private let kEnabled   = "notification_enabled"
    private let kHour      = "notification_hour"
    private let kMinute    = "notification_minute"

    // MARK: - 发布属性（供 UI 绑定）
    @Published var isEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isEnabled, forKey: kEnabled)
            isEnabled ? scheduleAllNotifications() : cancelAllNotifications()
        }
    }
    @Published var hour: Int {
        didSet {
            UserDefaults.standard.set(hour, forKey: kHour)
            if isEnabled { scheduleAllNotifications() }
        }
    }
    @Published var minute: Int {
        didSet {
            UserDefaults.standard.set(minute, forKey: kMinute)
            if isEnabled { scheduleAllNotifications() }
        }
    }

    private override init() {
        isEnabled = UserDefaults.standard.bool(forKey: "notification_enabled")
        hour      = UserDefaults.standard.object(forKey: "notification_hour")   != nil
                    ? UserDefaults.standard.integer(forKey: "notification_hour") : 8
        minute    = UserDefaults.standard.object(forKey: "notification_minute") != nil
                    ? UserDefaults.standard.integer(forKey: "notification_minute") : 0
        super.init()
    }

    // MARK: - 30+ 条个性化提醒文案
    // 按易经主题分类：学习激励、处事哲学、自然智慧、修身养性
    private let messages: [(title: String, body: String)] = [
        // 学习激励
        ("📖 每日一卦，厚积薄发", "天行健，君子以自强不息。今日打开易经，读一卦，悟一理。"),
        ("🌅 晨读易经，启迪智慧", "日出而作，学而时习之。今天你的每日一卦等你来揭晓！"),
        ("✨ 学易经，知变通", "穷则变，变则通，通则久。打开今日卦象，感受变化之道。"),
        ("🎯 坚持学习，水滴石穿", "不积跬步，无以至千里。你已坚持学习，今日继续！"),
        ("📚 易学深处，别有洞天", "学如逆水行舟，不进则退。今天的易经知识等你来探索。"),
        ("🌟 每日精进，成就自我", "君子学以聚之，问以辨之。今日一卦，又是一次成长。"),
        ("🔥 知行合一，从易开始", "知而不行，只是未知。今天用易经的智慧指导你的行动。"),
        ("💡 易理通透，处处是道", "大道至简，万物归一。今日的卦象或许正是你的答案。"),

        // 处事哲学
        ("⚖️ 刚柔并济，中庸之道", "亢龙有悔，满招损，谦受益。今天反思一下，你在哪个位置？"),
        ("🌊 顺势而为，知进退", "飞龙在天，利见大人。时机成熟，方可大展宏图。"),
        ("🤝 厚德载物，以和为贵", "地势坤，君子以厚德载物。今日修德，广结善缘。"),
        ("🔮 居安思危，未雨绸缪", "君子安而不忘危。今天做好准备，才能从容应对未来。"),
        ("🌿 柔弱胜刚强，以退为进", "曲则全，枉则直。有时候退一步，是为了走更远的路。"),
        ("🎋 谦谦君子，温润如玉", "谦谦君子，用涉大川，吉。谦逊是最有力量的品格。"),
        ("🌀 否极泰来，逆境生机", "否极泰来，终见光明。困境只是暂时的，坚持就是胜利。"),
        ("🦅 时乘六龙，御天而行", "潜龙勿用，见龙在田，各有其时。把握当下，静待时机。"),

        // 自然智慧
        ("🌙 观天察地，悟道自然", "仰则观象于天，俯则观法于地。大自然是最好的老师。"),
        ("☀️ 阴阳相生，万物化育", "一阴一阳之谓道。平衡才是生命真正的状态。"),
        ("💧 上善若水，处下不争", "水善利万物而不争，处众人之所恶。今日学水之德。"),
        ("🌱 生生不息，易道之本", "天地之大德曰生。每一天都是新的开始，充满无限可能。"),
        ("🌈 云行雨施，品物流形", "云行雨施，天下平也。施惠于人，方能成就大格局。"),
        ("🍃 随风潜入夜，润物细无声", "风行水上，涣。如清风化雨，影响在无声无息之间。"),
        ("⛰️ 山泽通气，刚柔相推", "山上有泽，咸。感而遂通天下之故。以诚感人，无往不利。"),
        ("🔥 火明而照远，泽深而载厚", "明两作，离，大人以继明照于四方。用智慧照亮前路。"),

        // 修身养性
        ("🧘 慎独自守，内圣外王", "君子慎其独也。无人看见时的坚守，才是真正的品格。"),
        ("💎 玉不琢，不成器", "磨砺自我，方成大器。今日练习，是对未来最好的投资。"),
        ("🌺 花开自有时，急不得", "勿以善小而不为，勿以恶小而为之。积小善，成大德。"),
        ("🕊️ 宁静致远，淡泊明志", "致虚极，守静笃。在喧嚣中保持内心的宁静，是一种智慧。"),
        ("🌙 月满则亏，持盈保泰", "日中则昃，月盈则食。谦退知足，方能持久安泰。"),
        ("🎯 志存高远，脚踏实地", "君子以果行育德。立大志，从小事做起，今日进一步。"),
        ("🌸 随缘而安，不强求", "无咎者，善补过也。接受不完美，从错误中成长。"),
        ("🦋 蜕变成长，破茧成蝶", "革，水火相息，二女同居，其志不相得，曰革。改变是成长的开始。"),
        ("🌊 海纳百川，有容乃大", "君子以容民畜众。广博的胸怀，才能成就广博的人生。"),
        ("⚡ 雷厉风行，令出必行", "洊雷，震，君子以恐惧修省。雷声警醒，今日自我反省一次。"),
    ]

    // MARK: - 权限申请
    // 首次允许通知时自动开启每日提醒开关
    func requestPermission(completion: @escaping (Bool) -> Void = { _ in }) {
        let firstLaunchKey = "notification_permission_asked"
        let alreadyAsked = UserDefaults.standard.bool(forKey: firstLaunchKey)

        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]
        ) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    if !alreadyAsked {
                        // 首次授权成功：自动打开每日提醒开关
                        UserDefaults.standard.set(true, forKey: firstLaunchKey)
                        // 直接写 UserDefaults + 调度，避免 didSet 二次触发
                        UserDefaults.standard.set(true, forKey: self.kEnabled)
                        self.isEnabled = true
                        self.scheduleAllNotifications()
                    } else if self.isEnabled {
                        self.scheduleAllNotifications()
                    }
                } else {
                    UserDefaults.standard.set(true, forKey: firstLaunchKey)
                }
                completion(granted)
            }
        }
    }

    // MARK: - 同步系统通知权限状态（切换回 App 时调用）
    func syncAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                // 系统权限被关闭时，同步关闭 App 内开关
                if settings.authorizationStatus == .denied && self.isEnabled {
                    UserDefaults.standard.set(false, forKey: self.kEnabled)
                    self.isEnabled = false
                }
            }
        }
    }

    // MARK: - 调度未来 64 天的每日通知（覆盖完整 64 卦轮回）
    func scheduleAllNotifications() {
        cancelAllNotifications()
        guard isEnabled else { return }

        UNUserNotificationCenter.current().getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                self._scheduleNotifications()
            }
        }
    }

    private func _scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        // 打乱文案顺序，保证每次调度顺序随机
        let shuffled = messages.shuffled()
        let total = shuffled.count

        for dayOffset in 0..<64 {
            let msg = shuffled[dayOffset % total]

            let content = UNMutableNotificationContent()
            content.title = msg.title
            content.body  = msg.body
            content.sound = .default
            content.badge = 1

            // 计算触发日期
            var dateComponents = DateComponents()
            dateComponents.hour   = hour
            dateComponents.minute = minute

            // 从明天开始（offset=0 表示明天）
            let calendar = Calendar.current
            guard let triggerDate = calendar.date(
                byAdding: .day, value: dayOffset + 1, to: Date()
            ) else { continue }

            var components     = calendar.dateComponents([.year, .month, .day], from: triggerDate)
            components.hour    = hour
            components.minute  = minute
            components.second  = 0

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components, repeats: false
            )

            let request = UNNotificationRequest(
                identifier: "daily_yijing_\(dayOffset)",
                content: content,
                trigger: trigger
            )
            center.add(request, withCompletionHandler: nil)
        }
    }

    // MARK: - 取消所有通知
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

    // MARK: - 格式化显示时间
    var timeString: String {
        String(format: "%02d:%02d", hour, minute)
    }
}
