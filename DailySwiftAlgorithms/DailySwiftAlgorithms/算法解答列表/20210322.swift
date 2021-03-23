//
//  20210322.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/22.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
//
// 给定字符串 s 和 t ，判断 s 是否为 t 的子序列。
//
// 字符串的一个子序列是原始字符串删除一些（也可以不删除）字符而不改变剩余字符相对位置形成的新字符串。（例如，"ace"是"abcde"的一个子序列，而"aec"不是）。
// 进阶：
//
// 如果有大量输入的 S，称作 S1, S2, ... , Sk 其中 k >= 10亿，你需要依次检查它们是否为 T 的子序列。在这种情况下，你会怎样改变代码？
//
// 示例 1：
//
// 输入：s = "abc", t = "ahbgdc"
// 输出：true
//
// 示例 2：
//
// 输入：s = "axc", t = "ahbgdc"
// 输出：false
//
// 提示：
// 0 <= s.length <= 100
// 0 <= t.length <= 10^4
// 两个字符串都只由小写字符组成。

class Solution_20210322 {
    class func isSubsequence(_ s: String, _ t: String) -> Bool {
        if s.isEmpty, t.isEmpty { return true }
        if s.count > t.count { return false }
        var tmp = t
        for (idx, char) in s.enumerated() {
            guard let atIndex = tmp.firstIndex(of: char) else { return false }
            if atIndex == tmp.endIndex {
                if idx == s.count - 1 {
                    return true
                }
                return false
            }
            let tmpIdx = tmp.index(after: atIndex)
            tmp = String(tmp[tmpIdx...])
        }
        return true
    }

    // 给定一个范围在  1 ≤ a[i] ≤ n ( n = 数组大小 ) 的 整型数组，数组中的元素一些出现了两次，另一些只出现一次。
    //
    // 找到所有在 [1, n] 范围之间没有出现在数组中的数字。
    //
    // 您能在不使用额外空间且时间复杂度为O(n)的情况下完成这个任务吗? 你可以假定返回的数组不算在额外空间内。
    //
    // 示例:
    //
    // 输入:
    // [4,3,2,7,8,2,3,1]
    //
    // 输出:
    // [5,6]

    class func findDisappearedNumbers(_ nums: inout [Int]) -> [Int] {
        if nums.isEmpty { return [] }
        var res = [Int]()
        for i in 0 ..< nums.count {
            if nums[abs(nums[i]) - 1] > 0 {
                nums[abs(nums[i]) - 1] = -nums[abs(nums[i]) - 1]
            }
        }
        for i in 0 ..< nums.count {
            if nums[i] > 0 {
                res.append(i + 1)
            }
        }
        return res
    }
}
