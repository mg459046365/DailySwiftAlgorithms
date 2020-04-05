//
//  20200331.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/1.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200331 {
    // 题目： 输入数字 n，按顺序打印出从 1 到最大的 n 位十进制数。比如输入 3，则打印出 1、2、3 一直到最大的 3 位数 999。
    // 注意： 考虑大数问题，溢出问题。使用字符串处理数据

    // 思路： 数字的每一位都有可能是0-9中的一个数。所以可以使用递归逐一设置每一位。

    static func printNumToMaxOfDigits(_ n: Int) {
        if n <= 0 { return }
        var array = Array(repeating: "0", count: n)
        for i in 0 ..< 10 {
            // 处理第一位数字
            array[0] = "\(i)"
            // 处理下一位数字
            recursivelyHelper(value: array, n: n, idx: 0)
        }
    }

    private static func printHelper(_ val: [String]) -> String {
        var tmp = val
        while tmp.first == "0" {
            tmp.removeFirst()
        }
        return tmp.reduce("") { $0 + $1 }
    }

    private static func recursivelyHelper(value: [String], n: Int, idx: Int) {
        if idx == n - 1 {
            // 说明是最后一位了
            print("\(printHelper(value))")
            return
        }
        var tmp = value
        for i in 0 ..< 10 {
            // idx的下一位0-9
            tmp[idx + 1] = "\(i)"
            // 处理下一位数字
            recursivelyHelper(value: tmp, n: n, idx: idx + 1)
        }
    }
}
