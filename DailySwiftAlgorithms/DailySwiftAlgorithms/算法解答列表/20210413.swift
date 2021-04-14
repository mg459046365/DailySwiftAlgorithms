//
//  20210413.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/4/13.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210413 {
//    给你两个字符串，请你从这两个字符串中找出最长的特殊序列。
//
//    「最长特殊序列」定义如下：该序列为某字符串独有的最长子序列（即不能是其他字符串的子序列）。
//
//    子序列 可以通过删去字符串中的某些字符实现，但不能改变剩余字符的相对顺序。空序列为所有字符串的子序列，任何字符串为其自身的子序列。
//
//    输入为两个字符串，输出最长特殊序列的长度。如果不存在，则返回 -1。
//
//
//    示例 1：
//
//    输入: "aba", "cdc"
//    输出: 3
//    解释: 最长特殊序列可为 "aba" (或 "cdc")，两者均为自身的子序列且不是对方的子序列。
//    示例 2：
//
//    输入：a = "aaa", b = "bbb"
//    输出：3
//    示例 3：
//
//    输入：a = "aaa", b = "aaa"
//    输出：-1
//
//
//    提示：
//
//    两个字符串长度均处于区间 [1 - 100] 。
//    字符串中的字符仅含有 'a'~'z'。

    func findLUSlength(_ a: String, _ b: String) -> Int {
        if a == b { return -1 }
        return max(a.count, b.count)
    }

//    给定一个字符串 s 和一个整数 k，你需要对从字符串开头算起的每隔 2k 个字符的前 k 个字符进行反转。
//
//    如果剩余字符少于 k 个，则将剩余字符全部反转。
//    如果剩余字符小于 2k 但大于或等于 k 个，则反转前 k 个字符，其余字符保持原样。
//
//
//    示例:
//
//    输入: s = "abcdefg", k = 2
//    输出: "bacdfeg"
//
//
//    提示：
//
//    该字符串只包含小写英文字母。
//    给定字符串的长度和 k 在 [1, 10000] 范围内。

    func reverseStr(_ s: String, _ k: Int) -> String {
        if s.count <= k {
            return String(s.reversed())
        }
        var list: [Character] = s.compactMap { $0 }
        for i in stride(from: 0, to: list.count, by: 2 * k) {
            let ed = min(list.count, i + k)
            var tmp = list[i ..< ed]
            tmp.reverse()
            list[i ..< ed] = tmp
        }
        return String(list)
    }
}
