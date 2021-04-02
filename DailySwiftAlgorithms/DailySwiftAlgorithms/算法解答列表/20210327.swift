//
//  20210327.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/28.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210327 {
//    给你一个 正 整数 num ，输出它的补数。补数是对该数的二进制表示取反。
//
//
//    示例 1：
//
//    输入：num = 5
//    输出：2
//    解释：5 的二进制表示为 101（没有前导零位），其补数为 010。所以你需要输出 2 。
//    示例 2：
//
//    输入：num = 1
//    输出：0
//    解释：1 的二进制表示为 1（没有前导零位），其补数为 0。所以你需要输出 0 。
//
//
//    提示：
//
//    给定的整数 num 保证在 32 位带符号整数的范围内。
//    num >= 1
//    你可以假定二进制数不包含前导零位。

    func findComplement(_ num: Int) -> Int {
        var res = 0
        var tmp = num
        var i = 0
        while tmp > 0 {
            if tmp % 2 == 0 {
                let v = NSDecimalNumber(decimal: pow(2, i))
                res += Int(truncating: v)
            }
            i += 1
            tmp = tmp / 2
        }
        return res
    }
}
