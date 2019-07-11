//
//  QueueByStack.swift
//  DailySwiftAlgorithms
//  使用栈实现队列
//  Created by Beryter on 2018/10/17.
//  Copyright © 2018 Beryter. All rights reserved.
//

import Foundation

/// 使用栈实现队列, 栈先入后出，队列先入先出
class QueueByStack<Element> {
    
    /// 负责入队
    var stackA: Stack<Element>
    /// 辅助出队
    var stackB: Stack<Element>
    
    init() {
        stackA = Stack()
        stackB = Stack()
    }
    
    /// 是否为空
    var isEmpty: Bool {
        return stackA.isEmpty && stackB.isEmpty
    }
    
    /// 队首元素，即栈A的栈底元素。
    /// 栈A的栈底元素相当于队首元素，需要将栈A中栈底元素出栈。可以将栈A中的元素出栈，并入栈到栈B中，则栈B中的栈顶元素即为队首元素。
    var peek: Element? {
        get {
            //栈A中的元素压入栈B，B的栈顶元素即队列的队首元素
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
    ///  栈A入栈
    /// - Parameter element: 元素
    func inQueue(_ element: Element) {
        stackA.push(object: element)
    }
    
    /// 出队
    /// 栈A的栈底元素相当于队首元素，需要将栈A中栈底元素出栈。可以将栈A中的元素出栈，并入栈到栈B中，则栈B中的栈顶元素即为队首元素。
    /// 将栈B中的栈顶元素出站即可。
    /// - Returns: 元素
    func outQueue() -> Element? {
        shift()
        return stackB.pop()
    }
    
    /// 将栈A中的元素压入栈B中
    private func shift() {
        guard stackB.isEmpty else {
            return
        }
        while !stackA.isEmpty {
            stackB.push(object: stackA.pop()!)
        }
    }
    
}
