# 易经学堂 - 技术设计文档

## 一、技术方案概述

### 1.1 技术选型原则
- **简单优先**：使用成熟稳定的技术栈
- **原生开发**：保证性能和用户体验
- **本地存储**：无需后端服务器
- **易于维护**：代码结构清晰，便于迭代

### 1.2 核心技术栈

```
开发语言：Swift 5.9+
框架：SwiftUI + Combine
最低版本：iOS 14.0
数据存储：本地存储（UserDefaults + JSON文件）
架构模式：MVVM
依赖管理：Swift Package Manager（可选少量依赖）
```

### 1.3 为什么选择这个方案

| 技术 | 理由 |
|------|------|
| SwiftUI | 现代化UI框架，开发效率高，代码简洁 |
| MVVM | 清晰的架构分层，便于测试和维护 |
| 本地存储 | 无需后端，降低成本，离线可用 |
| Swift原生 | 最佳性能，无第三方依赖风险 |

## 二、系统架构设计

### 2.1 整体架构图

```
┌─────────────────────────────────────────┐
│           Presentation Layer            │
│      (SwiftUI Views + ViewModels)       │
├─────────────────────────────────────────┤
│           Business Logic Layer          │
│         (Services + Use Cases)          │
├─────────────────────────────────────────┤
│            Data Layer                   │
│  (Repository + Local Storage Manager)   │
├─────────────────────────────────────────┤
│            Data Source                  │
│  (JSON Files + UserDefaults + Cache)    │
└─────────────────────────────────────────┘
```

### 2.2 目录结构

```
YiJingApp/
├── App/
│   ├── YiJingApp.swift                 # App入口
│   └── AppDelegate.swift               # 应用代理（如需）
├── Core/
│   ├── Models/                         # 数据模型
│   │   ├── Hexagram.swift             # 卦象模型
│   │   ├── Trigram.swift              # 八卦模型
│   │   ├── StudyNote.swift            # 学习笔记模型
│   │   ├── StudyProgress.swift        # 学习进度模型
│   │   └── GameRecord.swift           # 游戏记录模型
│   ├── Services/                       # 业务服务
│   │   ├── DataService.swift          # 数据服务
│   │   ├── StorageService.swift       # 存储服务
│   │   ├── GameService.swift          # 游戏服务
│   │   └── NotificationService.swift  # 通知服务
│   └── Utilities/                      # 工具类
│       ├── Constants.swift            # 常量定义
│       ├── Extensions.swift           # 扩展
│       └── DateHelper.swift           # 日期工具
├── Features/                           # 功能模块
│   ├── Home/                          # 首页模块
│   │   ├── Views/
│   │   │   ├── HomeView.swift
│   │   │   └── DailyHexagramCard.swift
│   │   └── ViewModels/
│   │       └── HomeViewModel.swift
│   ├── Encyclopedia/                  # 百科模块
│   │   ├── Views/
│   │   │   ├── EncyclopediaView.swift
│   │   │   ├── HexagramListView.swift
│   │   │   ├── HexagramDetailView.swift
│   │   │   └── TrigramView.swift
│   │   └── ViewModels/
│   │       └── EncyclopediaViewModel.swift
│   ├── Practice/                      # 练习模块
│   │   ├── Views/
│   │   │   ├── PracticeView.swift
│   │   │   ├── MemoryGameView.swift
│   │   │   └── QuizView.swift
│   │   └── ViewModels/
│   │       └── PracticeViewModel.swift
│   └── Profile/                       # 我的模块
│       ├── Views/
│       │   ├── ProfileView.swift
│       │   ├── FavoritesView.swift
│       │   ├── NotesView.swift
│       │   └── SettingsView.swift
│       └── ViewModels/
│           └── ProfileViewModel.swift
├── Resources/                         # 资源文件
│   ├── Data/                         # 数据文件
│   │   ├── hexagrams.json           # 六十四卦数据
│   │   ├── trigrams.json            # 八卦数据
│   │   └── quiz_questions.json      # 题库数据
│   ├── Assets.xcassets/             # 图片资源
│   └── Localizable.strings          # 多语言（如需）
└── Supporting Files/
    ├── Info.plist
    └── PrivacyPolicy.md             # 隐私政策
```

## 三、数据模型设计

### 3.1 核心数据模型

#### Hexagram（卦象模型）

```swift
struct Hexagram: Identifiable, Codable {
    let id: Int                      // 卦序（1-64）
    let name: String                 // 卦名，如"乾"
    let chineseName: String          // 完整名称，如"乾为天"
    let upperTrigram: String         // 上卦（三画卦名）
    let lowerTrigram: String         // 下卦
    let binary: String               // 二进制表示，如"111111"
    let description: String          // 卦辞
    let interpretation: String       // 白话释义
    let lines: [Line]                // 六爻
    let symbol: String               // 卦象符号（用于显示）
    
    struct Line: Codable {
        let position: Int            // 爻位（1-6）
        let text: String             // 爻辞
        let interpretation: String   // 白话解释
    }
}
```

#### Trigram（八卦模型）

```swift
struct Trigram: Identifiable, Codable {
    let id: String                   // 八卦名称
    let name: String                 // 名称（乾、坤等）
    let binary: String               // 三爻二进制，如"111"
    let element: String              // 五行属性
    let direction: String            // 方位
    let symbolism: String            // 象征意义
    let nature: String               // 性质
    let family: String               // 家庭关系（父、母等）
    let description: String          // 详细说明
}
```

#### StudyNote（学习笔记）

```swift
struct StudyNote: Identifiable, Codable {
    let id: UUID
    let hexagramId: Int              // 关联的卦象ID
    var content: String              // 笔记内容
    let createdAt: Date              // 创建时间
    var updatedAt: Date              // 更新时间
}
```

#### StudyProgress（学习进度）

```swift
struct StudyProgress: Codable {
    var learnedHexagrams: Set<Int>   // 已学习的卦象ID
    var favoriteHexagrams: Set<Int>  // 收藏的卦象ID
    var studyDays: Int               // 连续学习天数
    var lastStudyDate: Date?         // 最后学习日期
    var totalStudyTime: TimeInterval // 总学习时长（可选）
}
```

#### GameRecord（游戏记录）

```swift
struct GameRecord: Identifiable, Codable {
    let id: UUID
    let gameType: GameType           // 游戏类型
    let score: Int                   // 得分
    let totalQuestions: Int          // 总题数
    let correctAnswers: Int          // 正确数
    let date: Date                   // 游戏日期
    
    enum GameType: String, Codable {
        case memoryGame = "认卦游戏"
        case quiz = "知识问答"
    }
}
```

### 3.2 数据文件格式

#### hexagrams.json

```json
[
  {
    "id": 1,
    "name": "乾",
    "chineseName": "乾为天",
    "upperTrigram": "乾",
    "lowerTrigram": "乾",
    "binary": "111111",
    "symbol": "☰☰",
    "description": "乾：元，亨，利，贞。",
    "interpretation": "乾卦象征天，具有刚健的性质...",
    "lines": [
      {
        "position": 1,
        "text": "初九：潜龙勿用。",
        "interpretation": "处于最下位的阳爻..."
      },
      {
        "position": 2,
        "text": "九二：见龙在田，利见大人。",
        "interpretation": "龙出现在田野上..."
      }
      // ... 其他爻
    ]
  }
  // ... 其他63卦
]
```

#### trigrams.json

```json
[
  {
    "id": "qian",
    "name": "乾",
    "binary": "111",
    "element": "金",
    "direction": "西北",
    "symbolism": "天",
    "nature": "刚健",
    "family": "父",
    "description": "乾为天，性质刚健..."
  }
  // ... 其他7个八卦
]
```

## 四、核心功能实现

### 4.1 数据加载服务

```swift
class DataService {
    static let shared = DataService()
    
    private(set) var hexagrams: [Hexagram] = []
    private(set) var trigrams: [Trigram] = []
    
    private init() {
        loadData()
    }
    
    func loadData() {
        // 从Bundle加载JSON文件
        hexagrams = loadJSON(filename: "hexagrams")
        trigrams = loadJSON(filename: "trigrams")
    }
    
    func getHexagram(by id: Int) -> Hexagram? {
        return hexagrams.first { $0.id == id }
    }
    
    func searchHexagrams(keyword: String) -> [Hexagram] {
        guard !keyword.isEmpty else { return hexagrams }
        return hexagrams.filter { 
            $0.name.contains(keyword) || 
            $0.chineseName.contains(keyword) ||
            $0.description.contains(keyword)
        }
    }
    
    private func loadJSON<T: Decodable>(filename: String) -> [T] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let decoded = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return decoded
    }
}
```

### 4.2 存储服务

```swift
class StorageService {
    static let shared = StorageService()
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - 学习进度
    
    func saveProgress(_ progress: StudyProgress) {
        if let encoded = try? encoder.encode(progress) {
            userDefaults.set(encoded, forKey: "studyProgress")
        }
    }
    
    func loadProgress() -> StudyProgress {
        if let data = userDefaults.data(forKey: "studyProgress"),
           let progress = try? decoder.decode(StudyProgress.self, from: data) {
            return progress
        }
        return StudyProgress(
            learnedHexagrams: [],
            favoriteHexagrams: [],
            studyDays: 0,
            lastStudyDate: nil,
            totalStudyTime: 0
        )
    }
    
    // MARK: - 学习笔记
    
    func saveNotes(_ notes: [StudyNote]) {
        if let encoded = try? encoder.encode(notes) {
            userDefaults.set(encoded, forKey: "studyNotes")
        }
    }
    
    func loadNotes() -> [StudyNote] {
        if let data = userDefaults.data(forKey: "studyNotes"),
           let notes = try? decoder.decode([StudyNote].self, from: data) {
            return notes
        }
        return []
    }
    
    // MARK: - 游戏记录
    
    func saveGameRecords(_ records: [GameRecord]) {
        if let encoded = try? encoder.encode(records) {
            userDefaults.set(encoded, forKey: "gameRecords")
        }
    }
    
    func loadGameRecords() -> [GameRecord] {
        if let data = userDefaults.data(forKey: "gameRecords"),
           let records = try? decoder.decode([GameRecord].self, from: data) {
            return records
        }
        return []
    }
    
    // MARK: - 每日一卦
    
    func getTodayHexagramId() -> Int {
        let today = Calendar.current.startOfDay(for: Date())
        let key = "dailyHexagram_\(today.timeIntervalSince1970)"
        
        if let savedId = userDefaults.object(forKey: key) as? Int {
            return savedId
        }
        
        // 生成今日卦象（基于日期的伪随机）
        let daysSince1970 = Int(today.timeIntervalSince1970 / 86400)
        let hexagramId = (daysSince1970 % 64) + 1
        
        userDefaults.set(hexagramId, forKey: key)
        return hexagramId
    }
}
```

### 4.3 游戏服务

```swift
class GameService {
    static let shared = GameService()
    
    // MARK: - 认卦游戏
    
    func generateMemoryGameQuestion(difficulty: Difficulty) -> MemoryQuestion {
        let hexagrams = DataService.shared.hexagrams
        let correctHexagram = hexagrams.randomElement()!
        
        var options = [correctHexagram.name]
        
        // 生成干扰项
        let optionCount = difficulty == .easy ? 4 : 6
        while options.count < optionCount {
            let random = hexagrams.randomElement()!
            if !options.contains(random.name) {
                options.append(random.name)
            }
        }
        
        return MemoryQuestion(
            hexagram: correctHexagram,
            options: options.shuffled(),
            correctAnswer: correctHexagram.name
        )
    }
    
    // MARK: - 知识问答
    
    func generateQuizQuestions(count: Int = 10) -> [QuizQuestion] {
        // 从题库中随机抽取题目
        // 实际实现中可以从quiz_questions.json加载
        return []
    }
    
    enum Difficulty {
        case easy, medium, hard
    }
    
    struct MemoryQuestion {
        let hexagram: Hexagram
        let options: [String]
        let correctAnswer: String
    }
    
    struct QuizQuestion: Identifiable {
        let id: UUID = UUID()
        let question: String
        let options: [String]
        let correctAnswer: String
        let explanation: String
    }
}
```

## 五、UI层实现要点

### 5.1 主界面结构

```swift
struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("首页", systemImage: "house.fill")
                }
                .tag(0)
            
            EncyclopediaView()
                .tabItem {
                    Label("百科", systemImage: "book.fill")
                }
                .tag(1)
            
            PracticeView()
                .tabItem {
                    Label("练习", systemImage: "gamecontroller.fill")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person.fill")
                }
                .tag(3)
        }
    }
}
```

### 5.2 卦象详情页实现思路

```swift
struct HexagramDetailView: View {
    let hexagram: Hexagram
    @StateObject private var viewModel: HexagramDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // 卦象图示
                HexagramSymbolView(hexagram: hexagram)
                
                // 基本信息
                VStack(alignment: .leading, spacing: 8) {
                    Text(hexagram.chineseName)
                        .font(.title)
                        .bold()
                    Text("上卦：\(hexagram.upperTrigram)  下卦：\(hexagram.lowerTrigram)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // 卦辞
                SectionView(title: "卦辞") {
                    Text(hexagram.description)
                }
                
                // 白话释义
                SectionView(title: "释义") {
                    Text(hexagram.interpretation)
                }
                
                // 六爻
                SectionView(title: "爻辞") {
                    ForEach(hexagram.lines, id: \.position) { line in
                        LineView(line: line)
                    }
                }
                
                // 操作按钮
                HStack(spacing: 20) {
                    Button(action: { viewModel.toggleFavorite() }) {
                        Label(
                            viewModel.isFavorite ? "已收藏" : "收藏",
                            systemImage: viewModel.isFavorite ? "star.fill" : "star"
                        )
                    }
                    
                    Button(action: { viewModel.showAddNote() }) {
                        Label("添加笔记", systemImage: "note.text")
                    }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle("卦象详情")
    }
}
```

### 5.3 卦象图示绘制

```swift
struct HexagramSymbolView: View {
    let hexagram: Hexagram
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(0..<6, id: \.self) { index in
                LineSymbol(isYang: isYangLine(at: index))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(12)
    }
    
    private func isYangLine(at index: Int) -> Bool {
        let binaryIndex = hexagram.binary.index(
            hexagram.binary.startIndex,
            offsetBy: 5 - index
        )
        return hexagram.binary[binaryIndex] == "1"
    }
}

struct LineSymbol: View {
    let isYang: Bool
    
    var body: some View {
        if isYang {
            // 阳爻 - 实线
            Rectangle()
                .fill(Color.primary)
                .frame(height: 8)
        } else {
            // 阴爻 - 断线
            HStack(spacing: 12) {
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 8)
                Rectangle()
                    .fill(Color.primary)
                    .frame(height: 8)
            }
        }
    }
}
```

## 六、性能优化

### 6.1 数据加载优化

```swift
// 懒加载大型数据
class DataService {
    private lazy var hexagrams: [Hexagram] = {
        return loadJSON(filename: "hexagrams")
    }()
    
    // 缓存搜索结果
    private var searchCache: [String: [Hexagram]] = [:]
    
    func searchHexagrams(keyword: String) -> [Hexagram] {
        if let cached = searchCache[keyword] {
            return cached
        }
        let results = performSearch(keyword)
        searchCache[keyword] = results
        return results
    }
}
```

### 6.2 列表性能优化

```swift
// 使用LazyVStack减少渲染开销
struct HexagramListView: View {
    let hexagrams: [Hexagram]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(hexagrams) { hexagram in
                    NavigationLink(destination: HexagramDetailView(hexagram: hexagram)) {
                        HexagramRow(hexagram: hexagram)
                    }
                }
            }
            .padding()
        }
    }
}
```

### 6.3 图片资源优化

- 使用Asset Catalog管理图片
- 提供1x、2x、3x三种分辨率
- 使用SF Symbols减少自定义图标
- 图片压缩优化

## 七、数据安全与隐私

### 7.1 数据存储

```swift
// 所有用户数据存储在应用沙盒内
// 路径：Library/Preferences/
// 使用UserDefaults存储，系统自动加密
```

### 7.2 隐私政策

```
数据收集说明：
- 本应用不收集任何个人信息
- 所有数据本地存储
- 不会上传任何数据到服务器
- 不使用第三方分析SDK
- 不包含广告
```

### 7.3 权限申请

```swift
// Info.plist配置
NSUserNotificationsUsageDescription: "用于发送每日学习提醒"

// 仅在用户开启提醒时请求通知权限
func requestNotificationPermission() {
    UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound]) { granted, error in
            // Handle permission result
        }
}
```

## 八、测试策略

### 8.1 单元测试

```swift
// 测试数据加载
func testLoadHexagrams() {
    let service = DataService.shared
    XCTAssertEqual(service.hexagrams.count, 64)
}

// 测试搜索功能
func testSearchHexagrams() {
    let results = DataService.shared.searchHexagrams(keyword: "乾")
    XCTAssertTrue(results.count > 0)
}

// 测试存储功能
func testSaveAndLoadProgress() {
    let progress = StudyProgress(...)
    StorageService.shared.saveProgress(progress)
    let loaded = StorageService.shared.loadProgress()
    XCTAssertEqual(progress.studyDays, loaded.studyDays)
}
```

### 8.2 UI测试

```swift
// 测试导航流程
func testNavigationFlow() {
    let app = XCUIApplication()
    app.launch()
    
    // 点击百科Tab
    app.tabBars.buttons["百科"].tap()
    
    // 点击第一个卦象
    app.scrollViews.buttons.firstMatch.tap()
    
    // 验证详情页显示
    XCTAssertTrue(app.navigationBars["卦象详情"].exists)
}
```

### 8.3 手动测试清单

- [ ] 所有页面在不同屏幕尺寸下显示正常
- [ ] 深色模式适配正常
- [ ] 横屏显示正常（iPad）
- [ ] 离线使用正常
- [ ] 数据持久化正常
- [ ] 内存占用合理（< 100MB）
- [ ] 冷启动时间 < 2秒

## 九、构建与部署

### 9.1 版本号管理

```
Version: 1.0.0
Build: 1

版本号规则：
主版本.次版本.修订号
- 主版本：重大功能更新
- 次版本：功能增加
- 修订号：bug修复
```

### 9.2 构建配置

```swift
// Debug配置
- 开启日志输出
- 使用测试数据
- 不开启代码混淆

// Release配置
- 关闭日志输出
- 使用正式数据
- 开启代码优化
- 移除调试符号
```

### 9.3 App Store提交

**提交前检查清单：**
- [ ] 应用图标（1024x1024）
- [ ] 启动页设计
- [ ] 应用截图（6.5寸、5.5寸）
- [ ] 应用描述和关键词
- [ ] 隐私政策URL
- [ ] 支持URL（可选）
- [ ] 分级评定
- [ ] 测试账号（如需）

**关键信息：**
```
应用名称：易经学堂
副标题：传统文化学习工具
分类：教育 > 参考
关键词：易经,国学,传统文化,文化学习
描述：强调教育属性，突出学习功能
```

## 十、依赖管理

### 10.1 最小依赖原则

```swift
// 尽量使用系统框架，减少第三方依赖

推荐使用：
- SwiftUI（UI框架）
- Combine（响应式编程）
- Foundation（基础库）

可选依赖：
- 无（MVP版本无需第三方库）
```

### 10.2 如需添加依赖

```swift
// Package.swift
dependencies: [
    // 如需要：JSON解析增强
    // .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.0")
]
```

## 十一、维护与监控

### 11.1 日志系统

```swift
enum LogLevel {
    case debug, info, warning, error
}

class Logger {
    static func log(_ message: String, level: LogLevel = .info) {
        #if DEBUG
        print("[\(level)] \(message)")
        #endif
    }
}
```

### 11.2 错误处理

```swift
enum AppError: Error {
    case dataLoadFailed
    case storageFailed
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .dataLoadFailed:
            return "数据加载失败，请重启应用"
        case .storageFailed:
            return "数据保存失败"
        case .invalidData:
            return "数据格式错误"
        }
    }
}
```

### 11.3 崩溃监控

```swift
// 使用Xcode Organizer查看崩溃日志
// 不使用第三方崩溃监控SDK（避免审核问题）
```

## 十二、开发时间估算

### 12.1 MVP版本（P0功能）

| 模块 | 工作量（人天） |
|------|---------------|
| 项目搭建 | 0.5 |
| 数据模型设计 | 1 |
| 数据文件准备 | 3 |
| 数据服务层 | 2 |
| 存储服务层 | 2 |
| 六十四卦列表 | 2 |
| 卦象详情页 | 3 |
| 搜索功能 | 1 |
| 认卦游戏 | 3 |
| 收藏功能 | 1 |
| 设置页面 | 1 |
| UI美化 | 2 |
| 测试调试 | 3 |
| **总计** | **24.5天** |

### 12.2 完整版本（P0+P1）

在MVP基础上增加约15天，总计约40天。

## 十三、技术风险与应对

### 13.1 数据文件体积

**风险**：64卦完整数据可能导致安装包过大
**应对**：
- 数据精简，只保留核心内容
- JSON压缩
- 分批加载（如需）

### 13.2 性能问题

**风险**：列表滑动卡顿
**应对**：
- 使用LazyVStack
- 图片资源优化
- 避免复杂计算在主线程

### 13.3 兼容性问题

**风险**：不同iOS版本表现不一致
**应对**：
- 设置最低支持iOS 14
- 在多个设备上测试
- 避免使用最新API

## 十四、后续技术演进

### 14.1 V2.0功能技术准备

**起卦功能实现思路：**
```swift
// 模拟"学习用"起卦工具
class DivinationSimulator {
    // 使用随机数模拟摇卦过程
    func simulateCoinToss() -> [Int] {
        return (0..<6).map { _ in
            // 返回6、7、8、9表示老阴、少阳、少阴、老阳
            Int.random(in: 6...9)
        }
    }
    
    func getHexagramFromLines(_ lines: [Int]) -> Hexagram {
        // 根据爻辞转换为卦象
        // 实现逻辑...
    }
}

// 注意：所有文案使用"模拟"、"学习"、"演示"等词汇
```

### 14.2 云同步（可选）

如后期需要：
- 使用iCloud CloudKit同步
- 无需自建服务器
- 符合隐私要求

### 14.3 Widget支持

```swift
// iOS 14+ Widget
// 显示每日一卦
struct DailyHexagramWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "DailyHexagram", provider: Provider()) { entry in
            DailyHexagramView(entry: entry)
        }
        .configurationDisplayName("每日一卦")
        .description("每天学习一个卦象")
    }
}
```

## 十五、附录

### 15.1 开发环境

```
Xcode: 15.0+
macOS: 13.0+
Swift: 5.9+
iOS Deployment Target: 14.0
```

### 15.2 参考资料

- [SwiftUI官方文档](https://developer.apple.com/documentation/swiftui/)
- [App Store审核指南](https://developer.apple.com/app-store/review/guidelines/)
- [iOS人机交互指南](https://developer.apple.com/design/human-interface-guidelines/)

### 15.3 Git工作流

```bash
# 分支策略
main      # 主分支，对应生产版本
develop   # 开发分支
feature/* # 功能分支

# 提交规范
feat: 新功能
fix: bug修复
docs: 文档更新
style: 代码格式
refactor: 重构
test: 测试
chore: 构建/工具
```

---

**文档版本**：V1.0  
**创建日期**：2025年11月17日  
**最后更新**：2025年11月17日  
**负责人**：技术团队

