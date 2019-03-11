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
    var leftList: [Element]
    var rightList: [Element]
    
    /// 是否为空
    var isEmpty: Bool { return leftList.isEmpty && rightList.isEmpty  }
    /// 队列的大小
    var size: Int { return leftList.count + rightList.count }
    /// 队首元素
    var peek: Element? { return leftList.isEmpty ? rightList.first : leftList.last }
    
    init() {
        leftList = [Element]()
        rightList = [Element]()
    }
    
    /// 入队
    ///
    /// - Parameter element: 元素
    func inQueue(_ element: Element) {
        rightList.append(element)
    }
    
    /// 出队
    ///
    /// - Returns: 元素
    func outQueue() -> Element? {
        if leftList.isEmpty {
            leftList = rightList.reversed()
            rightList.removeAll()
        }
        return leftList.popLast()
    }
}
