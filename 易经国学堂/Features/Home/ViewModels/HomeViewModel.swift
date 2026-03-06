import Foundation

class HomeViewModel: ObservableObject {
    @Published var dailyHexagram: Hexagram?
    
    private var dataService: DataService?
    private var storageService: StorageService?
    private var dailyHexagramId: Int? // 缓存每日卦象ID
    
    func setup(dataService: DataService, storageService: StorageService) {
        self.dataService = dataService
        self.storageService = storageService
        loadDailyHexagram()
    }
    
    private func loadDailyHexagram() {
        guard let dataService = dataService, 
              let storageService = storageService else { return }
        
        // 优化：先获取ID（这个操作很快，因为有缓存）
        guard let dailyId = storageService.getDailyHexagramId() else { return }
        
        // 存储ID供后续使用
        self.dailyHexagramId = dailyId
        
        // 异步加载卦象数据，避免阻塞UI
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dailyHexagram = dataService.getHexagram(by: dailyId)
        }
    }
    
    /// 刷新每日一卦（用于测试或手动刷新）
    func refreshDailyHexagram() {
        loadDailyHexagram()
    }
}
