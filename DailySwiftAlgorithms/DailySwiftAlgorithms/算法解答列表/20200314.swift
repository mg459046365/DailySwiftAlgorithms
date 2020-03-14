//
//  20200314.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/14.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Helper_20200314 {
    // 题目： 用两个栈实现一个队列。队列的声明如下，请实现一它的两个函数appendTail和deleteHead,
    // 分别完成在队列尾部插入节点和在队列头部删除节点的功能。

    class Queue {
        private var pushList = [Int]()
        private var popList = [Int]()

        init() {}

        func appendTail(_ value: Int) {
            pushList.append(value)
        }

        func deleteHead() -> Int {
            if !popList.isEmpty {
                return popList.popLast()!
            }
            if pushList.isEmpty {
                return -1
            }
            popList = pushList.reversed()
            pushList.removeAll()
            return popList.popLast()!
        }
    }
}
