//
//  20200405.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/5.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200405 {
    // 题目：请实现一个函数用来判断字符串是否表示数值（包括整数和小数和指数）。
    // 例如，字符串"+100"、"5e2"、"-123"、"3.1416"、"0123"及"-1E-16"都表示数值，但"12e"、"1a3.14"、"1.2.3"、"+-5"及"12e+5.4"都不是。
    // 忽略字符串首尾的空格。

    static func isNumber(_ str: String) -> Bool {
        // 过滤到首尾空格
        let tp = str.trimmingCharacters(in: .whitespaces)
        // 空字符串
        if tp.isEmpty { return false }
        // 只有一个字符
        if tp.count == 1 {
            let ch = tp.first!
            return (ch >= "0" && ch <= "9")
        }
        // 遍历整数部分
        var (match, res) = scanInt(tp)
        if res.isEmpty { return match } // 字符串匹配完毕
        // 匹配小数部分
        if res.first! == "." {
            res.removeFirst()
            if res.isEmpty { return match } // 字符串匹配完毕
            let tp = scanUnignedInt(res)
            res = tp.1
            // 小数可以没有整数部分,小数点前面没有数字
            // 小数点后面可以没有数字
            // 小数具有整数和小数部分
            match = tp.0 || match
        }
        if res.isEmpty { return match } // 字符串匹配完毕
        // 开始匹配指数部分
        if res.first! == "e" || res.first! == "E" {
            res.removeFirst()
            if res.isEmpty { return false } // e后面必须有数字
            let tp = scanInt(res)
            res = tp.1
            // e的前后字符都必须是数字
            match = match && tp.0
        }
        return match && res.isEmpty
    }

    /// 匹配数字部分
    static func scanUnignedInt(_ str: String) -> (Bool, String) {
        // 未匹配的字符串部分
        var tmp = str
        // 是否匹配到数字
        var match = false
        for i in 0 ..< str.count {
            let ch = str[str.index(str.startIndex, offsetBy: i)]
            if ch >= "0", ch <= "9" {
                // 说明字符是0-9之间的数字
                match = true
                if i == str.count - 1 {
                    // 说明是最后一个字符,所有的字符匹配完毕
                    tmp = ""
                    break
                }
                tmp = String(str[str.index(str.startIndex, offsetBy: i + 1) ..< str.endIndex])
            } else {
                // 说明不是数字
                tmp = String(str[str.index(str.startIndex, offsetBy: i) ..< str.endIndex])
                break
            }
        }

        return (match, tmp)
    }

    // 扫描整数
    static func scanInt(_ str: String) -> (Bool, String) {
        var tmp = str
        if str.hasPrefix("+") || str.hasPrefix("-") {
            // 字符串以，去掉符号号位
            tmp.removeFirst()
        }
        return scanUnignedInt(str)
    }
}
