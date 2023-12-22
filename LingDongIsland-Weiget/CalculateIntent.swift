//
//  CalculateIntent.swift
//  LingDongIsland-WeigetExtension
//
//  Created by yjkj on 2023/12/20.
//

import Foundation
import AppIntents

// 添加按钮 可交互 CalculateIntent 会用在我们可交互的按钮上
// Button 组件 和 Toggle 组件在 iOS 17 上新增了支持传入 AppIntent 协议的初始化方法
// 需要注意，可交互的组件仅支持 Button 和 Toggle 组件，其他控件都不起作用。
struct CalculateIntent: AppIntent {
    static var title: LocalizedStringResource = "Calculate Task"
    static var description: IntentDescription = IntentDescription(stringLiteral: "Calculate Number Task")
    @Parameter(title: "value")
    var value: Int
    init() {}
    init(value: Int) {
        self.value = value
    }
    // 点击按钮调用 perform 方法
    func perform() async throws -> some IntentResult {
        NumberManager.number += value
        return .result()
        //当我们执行完运算，return .result() 的时候，系统会自动调用刷新操作，此时会刷新小组件的时间线。
    }
}
// 全局属性 存储计算的结果
struct NumberManager {
    static var number = 0
}


