//
//  MinStack.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/27.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
class MinStack {
    //定义栈的数据结构，请在该类型中实现一个能够得到栈的最小元素的 min 函数在该栈中，调用 min、push 及 pop 的时间复杂度都是 O(1)。
    var minValList = [Int]()
    var list = [Int]()
    func push(_ x: Int) {
        list.append(x)
        guard let last = minValList.last else {
            minValList.append(x)
            return
        }
        minValList.append(Swift.min(last, x))
    }

    func pop() {
        list.removeLast()
        minValList.removeLast()
    }

    func top() -> Int {
        list.last ?? -1
    }

    func min() -> Int {
        minValList.last ?? -1
    }
}
