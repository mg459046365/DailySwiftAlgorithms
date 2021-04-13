//
//  20210412.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/4/12.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation

class Solution_20210412 {
    // 对于一个 正整数，如果它和除了它自身以外的所有 正因子 之和相等，我们称它为 「完美数」。

//    给定一个 整数 n， 如果是完美数，返回 true，否则返回 false
//
//
//
//    示例 1：
//
//    输入：28
//    输出：True
//    解释：28 = 1 + 2 + 4 + 7 + 14
//    1, 2, 4, 7, 和 14 是 28 的所有正因子。
//    示例 2：
//
//    输入：num = 6
//    输出：true
//    示例 3：
//
//    输入：num = 496
//    输出：true
//    示例 4：
//
//    输入：num = 8128
//    输出：true
//    示例 5：
//
//    输入：num = 2
//    输出：false

    func checkPerfectNumber(_ num: Int) -> Bool {
        if num < 2 { return false }
        var sum = 0
        var i = 1
        while i * i <= num {
            if num % i == 0 {
                sum += i
                if i * i != num {
                    sum += num / i
                }
            }
            i += 1
        }
        return sum - num == num
    }

//    给定一个单词，你需要判断单词的大写使用是否正确。
//
//    我们定义，在以下情况时，单词的大写用法是正确的：
//
//    全部字母都是大写，比如"USA"。
//    单词中所有字母都不是大写，比如"leetcode"。
//    如果单词不只含有一个字母，只有首字母大写， 比如 "Google"。
//    否则，我们定义这个单词没有正确使用大写字母。
//
//    示例 1:
//
//    输入: "USA"
//    输出: True
//    示例 2:
//
//    输入: "FlaG"
//    输出: False
//    注意: 输入是由大写和小写拉丁字母组成的非空单词。

    func detectCapitalUse(_ word: String) -> Bool {
        if word.count < 2 { return true }
        if word.uppercased() == word { return true } // 都是大写
        if word.lowercased() == word { return true } // 都是小写
        guard word.first!.isUppercase else { return false }
        var tmp = word
        tmp.removeFirst()
        return tmp.lowercased() == tmp
    }
}
