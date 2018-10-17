//
//  QueueByStack.swift
//  DailySwiftAlgorithms
//  使用栈实现队列
//  Created by Beryter on 2018/10/17.
//  Copyright © 2018 Beryter. All rights reserved.
//

import Foundation

/// 使用栈实现队列
class QueueByStack<Element> {
    var stackA: Stack<Element>
    var stackB: Stack<Element>
    
    init() {
        stackA = Stack()
        stackB = Stack()
    }
    
    /// 是否为空
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    /// 队首元素
    var peek: Element? {
        get {
            shift()
            return stackB.peek
        }
    }
    
    /// 队列大小
    var size: Int {
        get {
            return stackA.size + stackB.size
        }
    }
    
    /// 入队
    ///
    /// - Parameter element: 元素
    func inQueue(_ element: Element) {
        stackA.push(object: element)
    }
    
    /// 出队
    ///
    /// - Returns: 元素
    func outQueue() -> Element? {
        shift()
        return stackB.pop()
    }
    
    /// 将栈A中的元素压入栈B中
    fileprivate func shift() {
        guard stackB.isEmpty else {
            return
        }
        while !stackA.isEmpty {
            stackB.push(object: stackA.pop()!)
        }
    }
    
}
