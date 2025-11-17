//
//  DataService.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

/// 数据服务 - 负责加载和管理应用数据
class DataService: ObservableObject {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    // MARK: - Published Properties
    @Published private(set) var hexagrams: [Hexagram] = []
    @Published private(set) var trigrams: [Trigram] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    
    // MARK: - Private Properties
    private var hexagramsDict: [Int: Hexagram] = [:]
    private var trigramsDict: [String: Trigram] = [:]
    
    // MARK: - Initialization
    private init() {
        loadData()
    }
    
    // MARK: - Public Methods
    
    /// 加载所有数据
    func loadData() {
        isLoading = true
        errorMessage = nil
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // 加载六十四卦数据
            self.loadHexagrams()
            
            // 加载八卦数据
            self.loadTrigrams()
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    /// 根据ID获取卦象
    func getHexagram(by id: Int) -> Hexagram? {
        hexagramsDict[id]
    }
    
    /// 根据名称获取卦象
    func getHexagram(by name: String) -> Hexagram? {
        hexagrams.first { $0.name == name || $0.chineseName == name }
    }
    
    /// 根据名称获取八卦
    func getTrigram(by name: String) -> Trigram? {
        trigramsDict[name] ?? trigrams.first { $0.name == name }
    }
    
    /// 搜索卦象
    func searchHexagrams(query: String) -> [Hexagram] {
        guard !query.isEmpty else { return hexagrams }
        
        let lowercasedQuery = query.lowercased()
        return hexagrams.filter { hexagram in
            hexagram.name.lowercased().contains(lowercasedQuery) ||
            hexagram.chineseName.lowercased().contains(lowercasedQuery) ||
            hexagram.description.lowercased().contains(lowercasedQuery) ||
            hexagram.interpretation.lowercased().contains(lowercasedQuery)
        }
    }
    
    /// 获取随机卦象
    func getRandomHexagram() -> Hexagram? {
        hexagrams.randomElement()
    }
    
    /// 获取多个随机卦象（不重复）
    func getRandomHexagrams(count: Int) -> [Hexagram] {
        hexagrams.randomElements(count: count)
    }
    
    /// 根据上下卦获取卦象
    func getHexagram(upperTrigram: String, lowerTrigram: String) -> Hexagram? {
        hexagrams.first {
            $0.upperTrigram == upperTrigram && $0.lowerTrigram == lowerTrigram
        }
    }
    
    // MARK: - Private Methods
    
    /// 加载六十四卦数据
    private func loadHexagrams() {
        // 尝试从JSON文件加载
        let fileName = "\(AppConstants.DataFiles.hexagrams).\(AppConstants.DataFiles.fileExtension)"
        
        if let loadedHexagrams = Bundle.main.decode([Hexagram].self, from: fileName) {
            DispatchQueue.main.async {
                self.hexagrams = loadedHexagrams.sorted { $0.id < $1.id }
                self.hexagramsDict = Dictionary(uniqueKeysWithValues: self.hexagrams.map { ($0.id, $0) })
                print("✅ 成功加载 \(self.hexagrams.count) 个卦象")
            }
        } else {
            // 如果文件不存在，使用示例数据
            print("⚠️ 未找到卦象数据文件，使用示例数据")
            DispatchQueue.main.async {
                self.hexagrams = [Hexagram.example]
                self.hexagramsDict = [Hexagram.example.id: Hexagram.example]
                self.errorMessage = "数据文件未找到，请添加 hexagrams.json"
            }
        }
    }
    
    /// 加载八卦数据
    private func loadTrigrams() {
        // 尝试从JSON文件加载
        let fileName = "\(AppConstants.DataFiles.trigrams).\(AppConstants.DataFiles.fileExtension)"
        
        if let loadedTrigrams = Bundle.main.decode([Trigram].self, from: fileName) {
            DispatchQueue.main.async {
                self.trigrams = loadedTrigrams
                self.trigramsDict = Dictionary(uniqueKeysWithValues: self.trigrams.map { ($0.name, $0) })
                print("✅ 成功加载 \(self.trigrams.count) 个八卦")
            }
        } else {
            // 如果文件不存在，使用示例数据
            print("⚠️ 未找到八卦数据文件，使用示例数据")
            DispatchQueue.main.async {
                self.trigrams = Trigram.allTrigrams
                self.trigramsDict = Dictionary(uniqueKeysWithValues: self.trigrams.map { ($0.name, $0) })
                self.errorMessage = "数据文件未找到，请添加 trigrams.json"
            }
        }
    }
    
    /// 重新加载数据
    func reloadData() {
        hexagrams.removeAll()
        trigrams.removeAll()
        hexagramsDict.removeAll()
        trigramsDict.removeAll()
        loadData()
    }
}

// MARK: - Data Statistics
extension DataService {
    /// 获取数据统计信息
    var statistics: DataStatistics {
        DataStatistics(
            totalHexagrams: hexagrams.count,
            totalTrigrams: trigrams.count,
            pureYangHexagrams: hexagrams.filter { $0.yangCount == 6 }.count,
            pureYinHexagrams: hexagrams.filter { $0.yinCount == 6 }.count
        )
    }
    
    struct DataStatistics {
        let totalHexagrams: Int
        let totalTrigrams: Int
        let pureYangHexagrams: Int
        let pureYinHexagrams: Int
    }
}

