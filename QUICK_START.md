# 易经国学堂 - 快速开始指南

## 🚀 5分钟快速上手

### 1. 打开项目（30秒）

```bash
cd "/Users/cs/Desktop/CS/AI/易经国学堂"
open 易经国学堂.xcodeproj
```

### 2. 运行项目（1分钟）

1. 在 Xcode 顶部选择目标设备：**iPhone 14 Pro** 模拟器
2. 点击 ▶️ 按钮或按 `Cmd + R`
3. 等待编译完成（首次约30秒）
4. App 将自动启动

### 3. 体验功能（3分钟）

#### 首页 Tab
- 查看欢迎卡片
- 查看今日一卦
- 查看学习进度统计

#### 百科 Tab
- 浏览六十四卦列表（当前有10卦完整数据）
- 点击任意卦象查看详情
- 使用搜索功能
- 收藏喜欢的卦象

#### 练习 Tab  
- 查看游戏选项（界面开发中）
- 查看游戏记录

#### 我的 Tab
- 查看学习统计
- 进入我的收藏
- 查看关于页面

---

## 📁 项目结构导航

### 核心代码位置

```
易经国学堂/
├── Core/                          # 核心层
│   ├── Models/                    # 数据模型
│   │   ├── Hexagram.swift         # 卦象模型 ⭐
│   │   ├── Trigram.swift          # 八卦模型
│   │   ├── StudyProgress.swift    # 学习进度
│   │   ├── StudyNote.swift        # 学习笔记
│   │   └── GameRecord.swift       # 游戏记录
│   │
│   ├── Services/                  # 业务服务
│   │   ├── DataService.swift      # 数据服务 ⭐
│   │   ├── StorageService.swift   # 存储服务 ⭐
│   │   └── GameService.swift      # 游戏服务
│   │
│   └── Utilities/                 # 工具类
│       ├── Constants.swift        # 常量定义
│       └── Extensions.swift       # 扩展工具
│
├── Features/                      # 功能模块
│   ├── Home/                      # 首页
│   │   ├── Views/
│   │   │   └── HomeView.swift    # 首页界面 ⭐
│   │   └── ViewModels/
│   │       └── HomeViewModel.swift
│   │
│   ├── Encyclopedia/              # 百科
│   │   └── Views/
│   │       ├── EncyclopediaView.swift      # 百科主页 ⭐
│   │       └── HexagramDetailView.swift    # 卦象详情 ⭐
│   │
│   ├── Practice/                  # 练习
│   │   └── Views/
│   │       └── PracticeView.swift
│   │
│   └── Profile/                   # 我的
│       └── Views/
│           └── ProfileView.swift
│
├── Resources/                     # 资源文件
│   └── Data/
│       ├── trigrams.json         # 八卦数据 ✅ 完整
│       └── hexagrams.json        # 六十四卦数据 ⚠️ 15.6%
│
├── MainTabView.swift             # 主Tab导航 ⭐
└── YiJingApp.swift              # App入口 ⭐

⭐ = 重要文件
```

---

## 🔧 常见问题

### Q1: 编译失败怎么办？
**A:** 
1. 清理项目：`Cmd + Shift + K`
2. 清理构建文件夹：`Cmd + Shift + Alt + K`
3. 重新编译：`Cmd + B`

### Q2: 模拟器显示空白？
**A:** 
1. 检查是否选择了正确的 Scheme
2. 尝试重启模拟器
3. 重新运行项目

### Q3: 为什么只看到10个卦象？
**A:** 
目前只完成了10个卦象的完整数据，剩余54个会在 Week 2 补充完整。

### Q4: 游戏点击没反应？
**A:** 
游戏交互界面还在开发中，预计 Week 2 完成。

### Q5: 如何添加新的卦象数据？
**A:** 
编辑 `Resources/Data/hexagrams.json` 文件，按照现有格式添加新的卦象数据。

---

## 🎯 快速测试清单

### ✅ 基础功能测试
- [ ] App 能成功启动
- [ ] 四个 Tab 都能正常切换
- [ ] 首页能显示今日一卦
- [ ] 百科页能显示卦象列表
- [ ] 点击卦象能进入详情页
- [ ] 搜索功能能正常工作
- [ ] 收藏功能能正常工作（点击星标）
- [ ] 个人中心显示正确的统计数据

### ⚠️ 已知限制
- [ ] 只有10个卦象有完整数据
- [ ] 游戏界面是占位符
- [ ] 笔记功能只能查看

---

## 📚 关键文档

| 文档 | 用途 | 链接 |
|------|------|------|
| PRD | 产品需求 | [PRD.md](PRD.md) |
| 技术设计 | 架构设计 | [TECH_DESIGN.md](TECH_DESIGN.md) |
| 路线图 | 开发计划 | [ROADMAP.md](ROADMAP.md) |
| 项目状态 | 当前进度 | [PROJECT_STATUS.md](PROJECT_STATUS.md) |
| 开发日志 | 详细记录 | [DEVELOPMENT_LOG.md](DEVELOPMENT_LOG.md) |
| 本周总结 | Week 1 总结 | [WEEK1_SUMMARY.md](WEEK1_SUMMARY.md) |

---

## 🛠 开发工具

### Xcode 快捷键
- `Cmd + R`: 运行
- `Cmd + B`: 编译
- `Cmd + .`: 停止运行
- `Cmd + Shift + K`: 清理
- `Cmd + /`: 注释/取消注释
- `Cmd + [`: 左缩进
- `Cmd + ]`: 右缩进
- `Option + Cmd + [`: 折叠代码
- `Option + Cmd + ]`: 展开代码

### 模拟器快捷键
- `Cmd + Shift + H`: Home键
- `Cmd + K`: 显示/隐藏键盘
- `Cmd + 1/2/3`: 缩放比例

---

## 💡 开发提示

### 修改数据
1. **添加新卦象**：编辑 `hexagrams.json`
2. **修改八卦**：编辑 `trigrams.json`
3. **调整UI配置**：修改 `Constants.swift`
4. **添加扩展方法**：修改 `Extensions.swift`

### 调试技巧
1. 使用 `print()` 输出日志
2. 在 Xcode 控制台查看日志
3. 使用断点调试
4. 查看内存分配

### 性能优化
1. 使用 `LazyVStack` 代替 `VStack`（长列表）
2. 图片资源使用 Assets.xcassets 管理
3. 避免在主线程执行耗时操作
4. 使用 `.onAppear` 加载数据

---

## 🎨 自定义和扩展

### 修改主题色
在 `Constants.swift` 中修改：
```swift
enum Colors {
    static let primary = Color(hex: "YOUR_COLOR")
    static let secondary = Color(hex: "YOUR_COLOR")
    // ...
}
```

### 添加新的游戏类型
1. 在 `GameRecord.swift` 中添加新的 `GameType`
2. 在 `GameService.swift` 中实现游戏逻辑
3. 在 `PracticeView.swift` 中添加 UI

### 添加新的Tab
1. 在 `Features/` 下创建新模块
2. 在 `MainTabView.swift` 中添加新 Tab

---

## 📞 获取帮助

### 文档资源
- [SwiftUI 官方教程](https://developer.apple.com/tutorials/swiftui)
- [Swift 文档](https://swift.org/documentation/)
- [iOS 设计指南](https://developer.apple.com/design/human-interface-guidelines/)

### 项目相关
- 查看 `ROADMAP.md` 了解开发计划
- 查看 `TECH_DESIGN.md` 了解技术细节
- 查看 `DEVELOPMENT_LOG.md` 了解开发历史

---

## ✨ 开始体验

现在你已经准备好开始使用和开发易经国学堂了！

**建议的学习路径：**
1. 运行项目，体验现有功能
2. 阅读代码，理解架构设计
3. 查看文档，了解项目规划
4. 参与开发，贡献代码

**祝你开发愉快！** 🎉

---

*最后更新：2025年11月17日*

