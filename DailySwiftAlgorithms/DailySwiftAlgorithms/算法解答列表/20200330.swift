//
//  20200330.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/31.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Helper_20200330 {
    // 题目：实现函数double Power(double base, int exponent)，求base的exponent次方。不得使用库函数，同时不需要考虑大数问题。
    // 注意：exponent为0的时候，为1的时候。base为0和1的时候

    // 数学知识：x的m次方，x的n次方，如果相乘则是x的m+n次方，如果相除则是x的m-n次方。x的0次方等于1。
    // x的负m幂次方，就相当于x的0次方除以x的abs(m)值，等于x的abs(m)次方分之一。abs取绝对值。

    // 思路： x的n次方，当n为偶数时，就等于x的n/2次方乘以x的n/2次方。
    // 当n为奇数时，就等于x的(n-1)/2次方乘以(n-1)/2次方再乘以x
    // 由此可以使用递归

    func myPow(x: Double, n: Int) -> Double {
        if n == 0 {
            // 任何数的0次方都等于1
            return 1
        }
        if n == 1 {
            // 任何数的1次方等于该数本身。区分n是正数还是负数
            return n > 0 ? x : 1 / x
        }
        var res = myPow(x: x, n: abs(n) >> 1)
        res *= res
        if n & 0x1 == 1 {
            // 判断n是奇数还是偶数
            res *= x
        }
        // 注意区分n是正数还是负数
        return n > 0 ? res : 1 / res
    }
}
