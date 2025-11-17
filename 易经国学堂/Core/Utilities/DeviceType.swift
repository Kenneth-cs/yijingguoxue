//
//  DeviceType.swift
//  易经国学堂
//
//  Created on 2025/11/17.
//

import SwiftUI

/// 设备类型辅助工具
struct DeviceType {
    /// 判断是否是iPad
    static var isPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    /// 判断是否是iPhone
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
    
    /// 获取当前屏幕宽度
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    /// 获取当前屏幕高度
    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
    
    /// 根据设备类型返回不同的值
    static func value<T>(iPad: T, iPhone: T) -> T {
        isPad ? iPad : iPhone
    }
    
    /// 获取适合当前设备的列数（用于网格布局）
    static var gridColumns: Int {
        isPad ? 3 : 2
    }
    
    /// 获取适合当前设备的内容宽度
    static var contentWidth: CGFloat {
        isPad ? min(screenWidth * 0.7, 800) : screenWidth
    }
}

/// SwiftUI环境值扩展
extension View {
    /// 为iPad和iPhone应用不同的padding
    func adaptivePadding(_ value: CGFloat? = nil) -> some View {
        let padding = value ?? DeviceType.value(iPad: 20, iPhone: 16)
        return self.padding(padding)
    }
    
    /// 为iPad和iPhone应用不同的字体大小
    func adaptiveFont(_ style: Font.TextStyle, iPad: Font.TextStyle? = nil) -> some View {
        if DeviceType.isPad {
            return self.font(.system(iPad ?? style))
        } else {
            return self.font(.system(style))
        }
    }
    
    /// 将内容居中（iPad上限制最大宽度）
    func centerContent() -> some View {
        if DeviceType.isPad {
            return AnyView(
                HStack {
                    Spacer()
                    self.frame(maxWidth: DeviceType.contentWidth)
                    Spacer()
                }
            )
        } else {
            return AnyView(self)
        }
    }
}

