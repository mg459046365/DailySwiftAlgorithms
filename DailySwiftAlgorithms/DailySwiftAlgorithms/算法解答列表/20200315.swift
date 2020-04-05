//
//  20200315.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/15.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Solution_20200315 {
    // 题目： 求斐波那契数列的第n项。
    // 写一个函数，输入n，求斐波那契数列的第n项。斐波那契数列的定义如下：f(0) = 0, f(1) = 1, 当n大于1时，f(n) = f(n - 1) + f(n - 2)。
    // 时间复杂度O(n)
    static func fibonacci(_ n: Int) -> Int {
        if n < 2 { return n }
        var fnMinus1 = 1 //代表f(n-1)的值
        var fnMinus2 = 0 //代表f(n-2)的值
        var res = 0
        for _ in 2...n {
            res = fnMinus1 + fnMinus2
            fnMinus2 = fnMinus1
            fnMinus1 = res
        }
        return res
    }
}
