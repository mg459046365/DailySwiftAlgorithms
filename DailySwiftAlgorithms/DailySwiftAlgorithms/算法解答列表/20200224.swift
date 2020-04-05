//
//  20200224.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/2/24.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200224 {
    /*
     不修改数组找出重复的数字
     在一个长度为n+1的数组里的所有数字都在1~n的范围呢，所以数组中至少有一个数字是重复的。请找出数组中任意一个重复的数字，但不能修改输入的数组。
     例如，如果输入长度为8的数组[2, 3, 5, 4, 3, 2, 6, 7], 那么对应的输出是重复的数字2或者3。
     */

    /*
     思路：从1~n的数字从中间的数字m分为两个部分，前面一半为1~m,后面的一半为m+1~n。如果处于1~m之间的数字的数目超过m个，那么这一半的区间里一定
     包含重复的数字；否则，另一半m+1~n的区间里一定包含重复的数字。我们可以继续将包含重复数字的区间继续一分为二，直到找到一个重复的数字。
     */

    /*
     该算法不能保证找到所有的重复的数字。时间复杂度为0(nlogn),空间复杂度为O(1).
     */

    static func findRepeatedNum(list: [Int]) throws -> Int {
        // 先判断数组是否合法
        guard list.count > 1 else {
            throw CustomError.error(0, "数组不合法")
        }
        for i in list {
            if i < 1 || i > list.count - 1 {
                throw CustomError.error(0, "数组不合法")
            }
        }
        // 最小的数字可能为1，最大的数字可能为list.count - 1(描述中的n)
        var start = 1
        var end = list.count - 1
        while end >= start {
            // 求出中间的数字的值
            let mid = (end - start) / 2 + start
            // 求处于start~mid中间的数字的个数，包含start和mid
            let count = numCount(list: list, start: start, end: mid)
            if start == end {
                // 当数字start和end相等时
                if count > 1 {
                    // 如果该数字的个数大于1，说明该数字肯定是重复数字
                    return start
                } else {
                    // 否则，不是重复数字
                    break
                }
            }

            // 处于start~mid中间的数字的个数大于mid - start + 1，start和mid之间存在重复数字
            if count > mid - start + 1 {
                end = mid
            } else {
                // 否则，重复数字可能存在于mid+1和end之间
                start = mid + 1
            }
        }
        return -1
    }

    static func numCount(list: [Int], start: Int, end: Int) -> Int {
        guard !list.isEmpty else { return 0 }
        var count = 0
        for i in list {
            if i >= start, i <= end {
                // 在start和end之间的数字
                count += 1
            }
        }
        return count
    }

    static func test() {
        let list = [2, 3, 5, 4, 3, 2, 6, 7]
        let num = try? findRepeatedNum(list: list)
        guard let res = num else {
            print("数组不合法")
            return
        }
        if res > 0 {
            print("重复的数字=\(res)")
        } else {
            print("不存在重复的数字")
        }
    }
}
