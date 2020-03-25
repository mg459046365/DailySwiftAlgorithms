//
//  20200324.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/25.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Helper_20200324 {
    // 题目： 给你一根长度为 n 的绳子，请把绳子剪成整数长度的 m 段（m、n都是整数，n>1并且m>1），
    // 每段绳子的长度记为 k[0],k[1]...k[m] 。请问 k[0]*k[1]*...*k[m] 可能的最大乘积是多少？例如，当绳子的长度是8时，我们把它剪成长度分别为2、3、3的三段，此时得到的最大乘积是18。

    //    输入: 2
    //    输出: 1
    //    解释: 2 = 1 + 1, 1 × 1 = 1
    //
    //    输入: 10
    //    输出: 36
    //    解释: 10 = 3 + 3 + 4, 3 × 3 × 4 = 36

    // 使用动态规划
    func cuttingRope(_ n: Int) -> Int {
        // 必须裁剪，且每段必须大于1
        if n < 2 { return 0 }
        if n == 2 { return 1 }
        if n == 3 { return 2 }
        // 子问题的最优解放到数组里，数组中i个元素表示把长度为i的绳子剪成若干段之后各段长度乘积的最大值，即f(i)
        var res = Array(repeating: 0, count: n + 1)
        // 当n=4的时候(1, 1, 1, 1),(1, 3), (2, 2), (1, 1, 2)
        res[0] = 0
        res[1] = 1
        res[2] = 2
        res[3] = 3
        for i in 4 ... n {
            var maxVal = 0
            for j in 1 ... i / 2 {
                let val = res[j] * res[i - j]
                maxVal = max(val, maxVal)
            }
            res[i] = maxVal
        }
        return res[n]
    }
    
    // 使用贪心算法
    func cuttingRope2(_ n: Int) -> Int {
        // 必须裁剪，且每段必须大于1
        if n < 2 { return 0 }
        if n == 2 { return 1 }
        if n == 3 { return 2 }
        var count = n
        var res = 1
        if count > 4 {
            res = res * 3
            count -= 3
        }
        return res * count
    }
    
    
}
