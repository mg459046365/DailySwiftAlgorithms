//
//  20200427.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/28.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200427 {
    // 题目：输入两个整数序列，第一个序列表示栈的压入顺序，请判断第二个序列是否为该栈的弹出顺序。假设压入栈的所有数字均不相等。例如，序列 {1,2,3,4,5} 是某栈的压栈序列，序列 {4,5,3,2,1} 是该压栈序列对应的一个弹出序列，但 {4,3,5,1,2} 就不可能是该压栈序列的弹出序列。
    //    示例 1：
    //    输入：pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
    //    输出：true
    //    解释：我们可以按以下顺序执行：
    //    push(1), push(2), push(3), push(4), pop() -> 4,
    //    push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
    //
    //    示例 2：
    //    输入：pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
    //    输出：false
    //    解释：1 不能在 2 之前弹出。

    // 思路：如果下一个弹出的数字刚好是栈顶数字，那么直接弹出；如果下一个弹出的数字不在栈顶，则把压栈序列中还没有入栈的数字压入栈，
    // 直到将要被压入栈的数字恰是下一个被弹出的数字为止，并标记该数字在压栈中的索引。然后重复操作，处理下一个将要被弹出的数字。
    // 如果所有的数字都被压入栈内，仍未找到将要被弹出的数字。那么该序列则不是压栈序列的弹出序列。
    class func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        if pushed.isEmpty, popped.isEmpty { return true }
        guard !pushed.isEmpty && !popped.isEmpty && pushed.count == popped.count else { return false }
        var stack = [Int]() // 代表栈
        var pushIndex = 0
        for val in popped {
            if stack.last == val {
                // 栈顶元素是要pop的元素
                stack.removeLast()
                continue
            }
            // 没有未入栈的元素
            if pushIndex >= pushed.count { return false }
            // 将未入栈的元素入栈，并找到需要pop的元素
            var exist = false
            while pushIndex < pushed.count {
                let pushVal = pushed[pushIndex] // 将要入栈的数字
                pushIndex += 1
                if pushVal == val {
                    // 将要入栈的元素与要pop的相等
                    exist = true
                    break
                }
                // 将要入栈的元素与要pop的不相等，继续寻找
                stack.append(pushVal)
            }
            if !exist { return false }
        }
        return true
    }

    class func test() {
        let push = [1, 2, 3, 4, 5]
        let pop = [4, 3, 5, 1, 2]
        let res = validateStackSequences(push, pop)
        print("打印结果=\(res)")
    }
}
