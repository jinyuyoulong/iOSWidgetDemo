//
//  LingDongIsland_WeigetLiveActivity.swift
//  LingDongIsland-Weiget
//
//  Created by yjkj on 2023/12/14.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LingDongIsland_WeigetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LingDongIsland_WeigetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji) \(context.state.title)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("左侧")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("右侧")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("底部 \(context.state.emoji) \(context.state.title)")
                    // more content
                }
            } compactLeading: {
                Text("左")
            } compactTrailing: {
                Text("右 \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LingDongIsland_WeigetAttributes {
    fileprivate static var preview: LingDongIsland_WeigetAttributes {
        LingDongIsland_WeigetAttributes(name: "World")
    }
}

extension LingDongIsland_WeigetAttributes.ContentState {
    fileprivate static var smiley: LingDongIsland_WeigetAttributes.ContentState {
        LingDongIsland_WeigetAttributes.ContentState(emoji: "😀", title: "title")
     }
     
     fileprivate static var starEyes: LingDongIsland_WeigetAttributes.ContentState {
         LingDongIsland_WeigetAttributes.ContentState(emoji: "🤩", title: "")
     }
}

#Preview("Notification", as: .content, using: LingDongIsland_WeigetAttributes.preview) {
   LingDongIsland_WeigetLiveActivity()
} contentStates: {
    LingDongIsland_WeigetAttributes.ContentState.smiley
    LingDongIsland_WeigetAttributes.ContentState.starEyes
}
