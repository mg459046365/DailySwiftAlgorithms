//
//  20200326.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/27.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200326 {
    
    // 题目：请实现一个函数，输入一个整数，输出该数二进制表示中 1 的个数。例如，把 9 表示成二进制是 1001，有 2 位是 1。因此，如果输入 9，则该函数输出 2。

    // 思路1： 一个整数与1做与运算，如果结果是1，则说明该整数的最后一位是1，否则最后一位是0。
    // 基于思路1，可以与1做与运算。然后判断最后一位是否是1。然后将该数右移一位。继续重复操作。直到该数等于0。
    // 由于负数，右移会在最左边补齐符号位1，所以会陷入死循环。该方法不可行。
    // 换种思路，我们可以把1不断的左移一位，而原数字不变。然后判断最后一位，倒数第二位，倒数第三位...是否是1.
    func hammingWeight(_ n: Int) -> Int {
        var count = 0
        var moveCount = 0
        var res = 1
        while res > 0 {
            let tmp = (res & n) >> moveCount
            if tmp == 1 {
                count += 1
            }
            moveCount += 1
            res <<= 1
        }
        return count
    }

    // 思路2： 把一个整数减去1，再和原整数做与运算，会把该整数最右边的1变成0.
    // 基于该思路，然后该整数中有多少个1，我们就可以如此执行多少遍。
    func hammingWeightBetter(_ n: Int) -> Int {
        var count = 0
        var res = n
        while res > 0 {
            count += 1
            res = (res - 1) & res
        }
        return count
    }
}
