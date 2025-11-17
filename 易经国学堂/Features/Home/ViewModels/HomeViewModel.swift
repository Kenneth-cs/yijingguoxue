//
//  HomeViewModel.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var dailyHexagram: Hexagram?
    
    private var dataService: DataService?
    private var storageService: StorageService?
    
    func setup(dataService: DataService, storageService: StorageService) {
        self.dataService = dataService
        self.storageService = storageService
        loadDailyHexagram()
    }
    
    private func loadDailyHexagram() {
        guard let dataService = dataService, 
              let storageService = storageService else { return }
        
        // 获取今日卦象ID
        if let dailyId = storageService.getDailyHexagramId() {
            dailyHexagram = dataService.getHexagram(by: dailyId)
        }
    }
}

