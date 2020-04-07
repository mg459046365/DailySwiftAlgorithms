//
//  20200407.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/7.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Soulution_20200407 {
    // 题目：输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。
    // 思路：双指针法

    @discardableResult
    class func solutionFunc(_ nums: [Int]) -> [Int] {
        print("输入数组：\(nums)")
        guard !nums.isEmpty, nums.count > 1 else {
            print("输出数组：\(nums)")
            return nums
        }
        var left = 0
        var right = nums.count - 1
        var res = nums
        while left < right {
            if nums[left] % 2 != 0 {
                // 说明是奇数
                left += 1
                continue
            }
            if nums[right] % 2 == 0 {
                // 说明是偶数
                right -= 1
                continue
            }
            (res[left], res[right]) = (res[right], res[left])
            left += 1
            right -= 1
        }
        print("输出数组：\(res)")
        return res
    }
    
    class func test() {
        solutionFunc([])
        solutionFunc([1])
        solutionFunc([1, 2])
        solutionFunc([2, 1])
        solutionFunc([1, 2, 3, 4, 5])
    }
}
