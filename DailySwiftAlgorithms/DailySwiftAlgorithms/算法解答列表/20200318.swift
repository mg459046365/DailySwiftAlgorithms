//
//  20200318.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/18.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Helper_20200318 {
    // 题目： 一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个n级台阶总共有多少种跳法。
    // 思路：如果只有一级台阶，显然只有一种跳法。如果有两级台阶，那么有两种跳法。
    // 当台阶上大于2时，第一次跳的时候有两种选择，一是一次只跳1级，此时跳法数目就等于剩下后面的n-1级台阶的跳法数目
    // 二是一次跳2级，此时跳法数目就等于后面的n-2级台阶的跳法数目。
    // 如果将跳法看成n的函数f(n)，那么当n>2时，f(n) = f(n-1) + f(n-2)
    func numWays(_ n: Int) -> Int {
        if n == 0 { return 0 }
        if n == 1 { return 1 }
        if n == 2 { return 2 }
        var minus2 = 1
        var minus1 = 2
        var res = 0
        for _ in 3 ... n {
            res = minus1 + minus2
            minus2 = minus1
            minus1 = res
        }
        return res
    }
}
