//
//  20210325.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/25.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation

class Solution_20210325 {
//    给定一个非空的字符串，判断它是否可以由它的一个子串重复多次构成。给定的字符串只含有小写英文字母，并且长度不超过10000。
//
//    示例 1:
//
//    输入: "abab"
//
//    输出: True
//
//    解释: 可由子字符串 "ab" 重复两次构成。
//    示例 2:
//
//    输入: "aba"
//
//    输出: False
//    示例 3:
//
//    输入: "abcabcabcabc"
//
//    输出: True
//
//    解释: 可由子字符串 "abc" 重复四次构成。 (或者子字符串 "abcabc" 重复两次构成。)

//    解题思路
//    两个s拼接, 去掉首尾, 如果截取后的字符串还是含s, 则说明s是个重复字符串
//    当然 如果s的长度小于1, 直接false
//
//    为什么呢? s如果是重复字符串, 则一定有一个子串, 在s中循环出现, 至少2次(1次的话必不是重复字符串)
//    那么我们将两个s拼接, 则子串至少出现4次, 例如: s = abab 拼接完 abababab
//    删除首尾, 则对应删除2个子串, 剩下字符串至少包含2个子串并且相邻, 即s, 那么我们判断截取后的字符串是不是包含s即可
//    例如: 上面 abababab 去首尾 bababa 包含s, 则s是重复字符串
//    例如: s abc 拼接完 abcabc 去首尾 bcab 不包含s, 则s不是重复字符串

//    如不是循环，那么一定找不到，其逆否命题是如果找得到，一定是循环。
//    如是循环，那么一定找得到，其逆否命题是如果找不到，一定不是循环。
//    所以找到与否可以判定是否是循环。
    class func repeatedSubstringPattern(_ s: String) -> Bool {
        if s.count < 2 { return false }
        let res = (s + s).dropFirst().dropLast().contains(s)
        return res
    }

    class func test() {
        let str = "abab"
        _ = repeatedSubstringPattern(str)
    }
}
