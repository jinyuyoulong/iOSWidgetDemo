//
//  LingDongIsland_Weiget.swift
//  LingDongIsland-Weiget
//
//  Created by yjkj on 2023/12/14.
//

import WidgetKit
import SwiftUI

// Provider 负责为小组件提供数据
struct Provider: TimelineProvider {
    // 在首次显示小组件，没有数据时使用占位
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),time: .morning)
    }
    //  获取小组件的快照，例如在小组件库中预览时会调用
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), time: .morning)
        completion(entry)
    }
    /* 
     这个方法来获取当前时间和（可选）未来时间的时间线的小组件数据以更新小部件。
     也就是说你在这个方法中设置在什么时间显示什么内容。
    */
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        if context.isPreview {
            print("在预览中显示，需要及时返回 Entry")
        }
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        /*
         先拿到当前时间，判断是上午、下午还是晚上，如果是上午，则添加上午、下午、和晚上的时间条目。
         如果当前是下午，则添加下午和晚上的时间条目，如果是晚上，则只添加晚上的时间线条目。
         */
        let hour = Calendar.current.component(.minute, from: Date())
        print("当前秒 \(Date().description) \(hour)")
        switch hour {
        case 0 ..< 20:
            entries.append(SimpleEntry(date: Date(), time: .morning))
            entries.append(SimpleEntry(date: getDate(in: 20), time: .afternoon))
            entries.append(SimpleEntry(date: getDate(in: 40), time: .night))
        case 20 ..< 40:
            entries.append(SimpleEntry(date: Date(), time: .afternoon))
            entries.append(SimpleEntry(date: getDate(in: 40), time: .night))
        default:
            entries.append(SimpleEntry(date: Date(), time: .night))
        }
        /*
        三种刷新策略：

        atEnd：在时间线中的最后一个日期过后请求新时间线，默认情况下就是这个策略
        after(Date)：可以指定一个未来的日期时间，在这个时间之后重新请求新时间线
        never：永远不会向小组件请求新的时间线
         */
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    func getDate(in hour: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
//        components.hour = hour
        components.minute = hour
//        components.second = hour
        return calendar.date(from: components)!
    }
}
// SimpleEntry 小组件的数据模型
struct SimpleEntry: TimelineEntry {
    enum Time {
        case morning, afternoon, night
    }
    let date: Date
    // 表示上午 下午 晚上
    let time: Time
}
extension SimpleEntry.Time {
    var text: String {
        switch self {
        case .morning:
            return "上午"
        case .afternoon:
            return "下午"
        default:
            return "晚上"
        }
    }
    var icon: String {
        switch self {
        case .morning:
            return "sunrise"
        case .afternoon:
            return "sun.max.fill"
        case .night:
            return "sunset"
        }
    }
}
// EntryView 小组件的入口视图
struct LingDongIsland_WeigetEntryView : View {
    var entry: Provider.Entry
    // 环境变量获取当前的小组件类型
    @Environment(\.widgetFamily) var family: WidgetFamily
    var familyString: String {
        switch family {
        case .systemSmall:
            return "小组件"
        case .systemMedium:
            return "中等组件"
        case .systemLarge:
            return "大号组件"
        case .systemExtraLarge:
            return "超大号组件"
        case .accessoryCircular:
            return "圆形组件"
        case .accessoryRectangular:
            return "方形组件"
        case .accessoryInline:
            return "内联小组件"
        @unknown default:
            return "其他类型小组件"
        }
    }
    var body: some View {
        switch family {
        case .accessoryCircular:
            // 随便放一张图片
            Image(systemName: "brain.head.profile")
            
        case .accessoryInline:
            HStack {
                Image(systemName: "brain.head.profile")
                    .padding(.trailing, 5)
                Text("iOS 新知 锁屏小组件")
            }
            
        case .accessoryRectangular:
            VStack {
                Image(systemName: "brain.head.profile")
                    .padding(.bottom, 5)
                Text("iOS 新知")
                Text("锁屏小组件")
            }
        case .systemSmall:
            VStack(spacing: 10) {
                Image(systemName: entry.time.icon)
                    .imageScale(.large)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                HStack {
                    Text("现在是:")
                    Text(entry.time.text)
                }
                .font(.subheadline)
                Text("这是 \(familyString)")
            }
            // 点击事件和交互
            .widgetURL(URL(string: "iosnews://iosNews.com/p1=1&p2=2"))
        case .systemMedium:
            VStack(spacing: 10) {
                Image(systemName: entry.time.icon)
                    .imageScale(.large)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                HStack {
                    Text("现在是:")
                    Text(entry.time.text)
                }
                .font(.subheadline)
                Text("这是 \(familyString)")
                Link(destination: URL(string: "iosnews://iosNews.com/p1=1&p2=2")!) {
                    Text("点击跳转").foregroundColor(.blue)
                }
                .frame(width: 50, height: 50)
            }
            // 点击事件和交互
            .widgetURL(URL(string: "iosnews://iosNews.com/p1=1&p2=2"))
        default:
            VStack(spacing: 10) {
                Image(systemName: entry.time.icon)
                    .imageScale(.large)
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                HStack {
                    Text("现在是:")
                    Text(entry.time.text)
                }
                .font(.subheadline)
                Text("这是 \(familyString)")
                Link(destination: URL(string: "iosnews://iosNews.com/p1=1&p2=2")!) {
                    Text("点击跳转").foregroundColor(.blue)
                }
                .frame(width: 50, height: 50)
            }
            // 点击事件和交互
            .widgetURL(URL(string: "iosnews://iosNews.com/p1=1&p2=2"))
        }
       
    }
    
}
// Widget是小组件的配置部分
struct LingDongIsland_Weiget: Widget {
    let kind: String = "LingDongIsland_Weiget" // 唯一标识

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                LingDongIsland_WeigetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                InteractivityWidgetEntryView(enter: entry)
            } else {
                LingDongIsland_WeigetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("这是小组件的名称")
        .description("这是小组件的描述.")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge, .accessoryInline, .accessoryCircular, .accessoryRectangular])// 支持小、中、大尺寸
    }
}

struct InteractivityWidgetEntryView: View {
    var enter: Provider.Entry
    var body: some View {
        VStack {
            Text("结果:\(NumberManager.number)")
                .invalidatableContent()
            /*
             因为 AppIntent 执行结束后，会导致小组件重新加载时间线，这就会带来从操作到 UI 结果展示之间有一小段延迟，Apple 也提供了一个方式避免这种问题，可以使用 .invalidatableContent() 修饰符来修饰某个视图，这样在点击按钮之后到 UI 更新之前，更新内容都是无效的。
             */
            HStack {
                Button(intent: CalculateIntent(value: 10)) {
                    Text("加 10")
                }
                Button(intent: CalculateIntent(value: -10)) {
                    Text("减 10")
                }
            }
        }
    }
}

// 提供小组件在 Xcode 中的预览
#Preview(as: .systemSmall) {
    LingDongIsland_Weiget()
} timeline: {
    SimpleEntry(date: .now, time: .morning)
}
