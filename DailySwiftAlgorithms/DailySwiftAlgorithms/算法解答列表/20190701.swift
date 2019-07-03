//
//  Stack_2019.7.1.swift
//  DailySwiftAlgorithms
//  实现一个栈，该栈带有出栈（pop）、入栈(push)、取最小元素（getMin）3个方法。保证这三个方法的时间复杂度都是O(1)
//  Created by Beryter on 2019/7/1.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

class FastGetMinStack {
    
    
    //MARK: - 题目：实现一个栈，该栈带有出栈（pop）、入栈(push)、取最小元素（getMin）3个方法。保证这三个方法的时间复杂度都是O(1)
    
    /**
     思路：创建两个数组，一个数组为作为主栈，一个数组用来辅助暂且叫做辅栈，辅栈主要用来存放当前最小元素。每当主栈push时，都会与当前辅栈栈顶最小的元素进行比较，如果该元素小于等于辅栈栈顶元素时，辅栈同样将该元素入栈。pop出站时，将出栈元素与辅栈中栈顶的元素比较，如果相等的话，则辅栈也做pop操作。
     */
    
    
    /// 数据，实现栈
    var stack = [Int]()
    /// 辅助队列，存放最小数值,得到一个排序后的数组
    var helperStack = [Int]()
    
    /// 入栈
    /// - Parameter element: 入栈元素
    func push(_ element: Int) {
        self.stack.append(element)
        if self.helperStack.isEmpty || self.helperStack.last! >= element {
            //注意临界值，栈中存在值相同的数据时
            self.helperStack.append(element)
        }
    }
    
    
    /// 出栈
    func pop() throws -> Int {
        guard self.stack.count > 0 else {
            throw CustomError.stackIsEmpty
        }
        let val = self.stack.removeLast()
        if self.helperStack.last! == val {
            self.helperStack.removeLast()
        }
        return val
    }
    
    /// 获取栈中最小值
    func getMin() throws -> Int {
        guard self.stack.count > 0 else {
            throw CustomError.stackIsEmpty
        }
        return self.helperStack.last!
    }
    
}
