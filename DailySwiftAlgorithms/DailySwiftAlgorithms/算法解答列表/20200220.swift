//
//  20200220.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/2/20.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200220 {
    /*
     题目：找出数组中重复的数字。
     在一个长度为n的数组里的所有数字都在0~n-1的范围呢。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。
     请找出任意一个重复的数字。
     */

    /* 思路：
     从头扫描这个数组中的每个数字。当扫描到下标为i的数字时，首先比较这个数字（用m表示）是不是等于i。如果是，则接着扫描下一个数字；
     如果不是，则拿m和第m个数字进行比较。如果m和第m个数字相等，则找到了一个重复的数字；如果不相等，则把m和第m个数字交换位置。
     接下来在重复这个比较、交换位置的过程，知道我们发现一个重复的数字。
     */

    /// 找出重复的数字，以及重复的次数。时间复杂度为O(n)，空间复杂度为O(1)
    /// - Parameter nums: 数组
    /// - Returns: 重复数字的信息，key重复的数字，value为重复的次数
    private static func findRepeatedNum(nums: inout [Int]) throws -> [Int: Int] {
        guard nums.count > 1 else { return [:] }
        var repeatInfo = [Int: Int]()
        for i in nums {
            if nums[i] < 0 || nums[i] > nums.count - 1 {
                throw CustomError.error(20, "数组不合法")
            }
        }
        for i in 0 ..< nums.count {
            while nums[i] != i {
                if nums[i] == nums[nums[i]] {
                    // num和第num个数字相等
                    // retturn num,返回重复的数字
                    let repeatCount = repeatInfo[nums[i]] ?? 1
                    repeatInfo[nums[i]] = repeatCount
                    break
                }
                (nums[i], nums[nums[i]]) = (nums[nums[i]], nums[i])
            }
        }
        return repeatInfo
    }

    /// 测试方法
    static func test() {
        var list = [2, 3, 1, 0, 2, 5, 3]
        do {
            let info = try findRepeatedNum(nums: &list)
            if info.isEmpty {
                print("没有重复数字")
                return
            }
            for (key, val) in info {
                print("数字\(key)重复\(val)次")
            }
        } catch let CustomError.error(_, msg) {
            print("msg:\(msg)")
        } catch {
            print("未知错误")
        }
    }
}
