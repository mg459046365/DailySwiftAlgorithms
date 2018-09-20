//
//  Stack.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/20.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import Foundation
/// 用数组实现栈
class Stack<Element> {
    
    /// 数组
    var stack: [Element]
    /// 是否为空
    var isEmpty: Bool { return stack.isEmpty }
    /// 栈的大小
    var size: Int { return stack.count }
    /// 栈顶元素
    var peek: Element? { return stack.last }
    
    init() {
        stack = [Element]()
    }

    
    /// 进栈
    ///
    /// - Parameter object: 元素
    func push(object: Element) {
        stack.append(object)
    }
    
    
    /// 出栈
    ///
    /// - Returns: 元素
    func pop() -> Element? {
        return stack.popLast()
    }
}
