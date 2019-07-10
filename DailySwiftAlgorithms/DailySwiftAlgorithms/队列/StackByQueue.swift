//
//  StackByQueue.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/10/17.
//  Copyright © 2018 Beryter. All rights reserved.
//

import Foundation

/// 使用队列实现栈，队列先进先出，栈是先入后出
class StackByQueue<Element> {
    
    /**
     1.任何时候两个队列总有一个是空的
     2.添加元素总是向非空队列中添加
     3.取出元素的时候总是将元素除队尾最后一个元素外，导入另一个空队列中，然后最后一个元素出队
     */
    
    
    ///队列A，负责入栈
    var queueA: Queue<Element>
    ///队列B，负责出栈
    var queueB: Queue<Element>

    init() {
        queueA = Queue()
        queueB = Queue()
    }

    /// 栈是否为空
    var isEmpty: Bool {
        return queueA.isEmpty
    }

    /// 栈顶元素，A队列中的队尾元素即栈顶元素
    var peek: Element? {
        
        if queueA.isEmpty {
            return nil
        }
        
        if 1 == queueA.size {
            return queueA.peek
        }
        //将队列A中的元素出队并存入B队列，且队列A队尾元素不出队
        shift()
        //栈顶元素
        let peekObj = queueA.peek
        // 将队列A中的队尾元素存入B队列
        queueB.inQueue(queueA.outQueue()!)
        //交换队列A和B
        swap()
        return peekObj
    }

    /// 栈的大小
    var size: Int {
        return queueA.size
    }

    /// 入栈
    /// 直接在队列A中入队
    /// - Parameter element: 元素
    func push(_ element: Element) {
        queueA.inQueue(element)
    }

    /// 出栈
    /// A队列中的队尾元素即栈顶元素，需要将队列A中队尾元素出队
    /// - Returns: 元素
    func pop() -> Element? {
        
        if queueA.isEmpty {
            return nil
        }
        if queueA.size == 1 {
           return queueA.outQueue()
        }
        //将队列A中的元素出队并存入B队列，且队列A队尾元素不出队
        shift()
        let popObj = queueA.outQueue()
        //A与B队列交换
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
