//
//  StackByQueue.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/10/17.
//  Copyright © 2018 Beryter. All rights reserved.
//

import Foundation

/// 使用队列实现栈
class StackByQueue<Element> {
    var queueA: Queue<Element>
    var queueB: Queue<Element>

    init() {
        queueA = Queue()
        queueB = Queue()
    }

    /// 队列是否为空
    var isEmpty: Bool {
        return queueA.isEmpty && queueB.isEmpty
    }

    /// 队首元素
    var peek: Element? {
        shift()
        let peekObj = queueA.peek
        queueB.inQueue(queueA.outQueue()!)
        swap()
        return peekObj
    }

    /// 栈的大小
    var size: Int {
        return queueA.size
    }

    /// 入栈
    ///
    /// - Parameter element: 元素
    func push(_ element: Element) {
        queueA.inQueue(element)
    }

    /// 出栈
    ///
    /// - Returns: 元素
    func pop() -> Element? {
        shift()
        let popObj = queueA.outQueue()
        swap()
        return popObj
    }

    private func shift() {
        while queueA.size != 1 {
            queueB.inQueue(queueA.outQueue()!)
        }
    }

    private func swap() {
        (queueA, queueB) = (queueB, queueA)
    }
    
}
