//
//  IslandControlPage.swift
//  LingDongIsland
//
//  Created by yjkj on 2023/12/18.
//

import Foundation
import ActivityKit

/*
 该文件需要引入两个 Target 中，主工程和子工程都使用
 */
struct LingDongIsland_WeigetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
        var title: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}
