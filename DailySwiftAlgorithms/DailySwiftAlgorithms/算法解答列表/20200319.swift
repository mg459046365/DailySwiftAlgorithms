//
//  20200319.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/19.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200319 {
    // 题目： 把一个数组最开始的若干个元素搬到数组的末尾，我们称之为数组的旋转。
    // 输入一个递增排序数组的一个旋转，输出旋转数组的最小的元素。
    // 例如，数组[3, 4, 5, 1, 2]为数组[1, 2, 3, 4, 5]的一个旋转，该数组的最小值为1。

    // 思路： 二分查找法。定义两个指针，分别指向第一个元素和最后一个元素, 然后比较第一个和最后一个元素。然后分别与中间元素对比。
    // 边界值：第一个元素和最后一个元素和中间元素都相等。

    func minValueInArray(list: [Int]) -> Int {
        if list.isEmpty { return 0 }
        if list.count == 1 { return list[0] }

        var left = 0
        var right = list.count - 1
        var midIndex = 0

        //如果list[left] 大于list[right]，说明数组本身有序，第一个元素就是最小的直接输出第一个元素即可
        while list[left] >= list[right] {
            if right - left == 1 {
                midIndex = right
                break
            }
            midIndex = (left + right) / 2
            if list[left] == list[right], list[left] == list[midIndex] {
                //当左中右三个元素都相等时，无法做出最小数字在哪一段，直接遍历输出最小数字
                var minval = list.first!
                list.forEach {
                    minval = min($0, minval)
                }
                return minval
            }

            if list[left] <= list[midIndex] {
                // 说明最小的数字在mid的右边
                left = midIndex
            } else if list[midIndex] <= list[right] {
                // 说明最小的数字在mid的左边
                right = midIndex
            }
        }
        return list[midIndex]
    }
}
