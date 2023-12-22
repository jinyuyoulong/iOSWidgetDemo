//
//  ViewController.swift
//  LingDongIsland
//
//  Created by yjkj on 2023/12/14.
//

import UIKit
import ActivityKit

@available(iOS 16.1, *)
class ViewController: UIViewController {
    var activity: Activity<LingDongIsland_WeigetAttributes>? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        createButton(title: "启动灵动岛", y: view.center.y - 100, selector: #selector(start))
        createButton(title: "更新灵动岛", y: view.center.y - 50, selector: #selector(update))
        createButton(title: "关闭灵动岛", y: view.center.y, selector: #selector(end))
    }
    
    private func createButton(title: String, y: CGFloat, selector: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.sizeToFit()
        view.addSubview(button)
        button.center.x = view.center.x
        button.frame.origin.y = y
        button.addTarget(self, action: selector, for: .touchUpInside)
    }
    @objc
    private func start() {
        // 创建灵动岛
        let attributes = LingDongIsland_WeigetAttributes(name: "hello")
        let state = LingDongIsland_WeigetAttributes.ContentState(emoji: "😄", title: "title")
        if #available(iOS 16.2, *) {
            let content = ActivityContent<LingDongIsland_WeigetAttributes.ContentState>(state: state, staleDate: nil)
            do {
                self.activity = try Activity<LingDongIsland_WeigetAttributes>.request(attributes: attributes, content: content)
            } catch let error {
                print("出错了：\(error.localizedDescription)")
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @objc
    private func update() {
        let state = LingDongIsland_WeigetAttributes.ContentState(emoji: "😭",title: "标题")
        
        Task {
            await activity?.update(using: state)
        }
    }
    
    @objc
    private func end() {
        Task {
            await activity?.end()
        }
    }

}

