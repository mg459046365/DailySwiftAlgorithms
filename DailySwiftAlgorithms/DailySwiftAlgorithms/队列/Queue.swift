//
//  Queue.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/20.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import Foundation

/// 用数组实现队列
class Queue<Element> {
    
    /// 数组
    var queue: [Element]
    /// 是否为空
    var isEmpty: Bool { return queue.isEmpty }
    /// 队列的大小
    var size: Int { return queue.count }
    /// 队首元素
    var peek: Element? { return queue.first }
    
    init() {
        queue = [Element]()
    }
    
    /// 入队
    ///
    /// - Parameter element: 元素
    func inQueue(_ element: Element) {
        
    }
    
    /// 出队
    ///
    /// - Returns: 元素
    func outQueue() -> Element? {
        return nil
    }
}
