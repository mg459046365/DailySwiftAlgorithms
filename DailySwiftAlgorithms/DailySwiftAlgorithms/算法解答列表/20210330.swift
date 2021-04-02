//
//  20210330.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/30.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation

class Solution_20210330 {
//    给定一个二进制数组， 计算其中最大连续 1 的个数。
//
//    示例：
//
//    输入：[1,1,0,1,1,1]
//    输出：3
//    解释：开头的两位和最后的三位都是连续 1 ，所以最大连续 1 的个数是 3.
//
//
//    提示：
//
//    输入的数组只包含 0 和 1 。
//    输入数组的长度是正整数，且不超过 10,000。

    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        var last = 0
        var cur = 0
        for i in nums {
            if i == 0 {
                last = max(cur, last)
                cur = 0
            } else {
                cur += 1
            }
        }
        return max(last, cur)
    }

//    作为一位web开发者， 懂得怎样去规划一个页面的尺寸是很重要的。 现给定一个具体的矩形页面面积，你的任务是设计一个长度为 L 和宽度为 W 且满足以下要求的矩形的页面。要求：
//
//    1. 你设计的矩形页面必须等于给定的目标面积。
//
//    2. 宽度 W 不应大于长度 L，换言之，要求 L >= W 。
//
//    3. 长度 L 和宽度 W 之间的差距应当尽可能小。
//    你需要按顺序输出你设计的页面的长度 L 和宽度 W。
//
//    示例：
//
//    输入: 4
//    输出: [2, 2]
//    解释: 目标面积是 4， 所有可能的构造方案有 [1,4], [2,2], [4,1]。
//    但是根据要求2，[1,4] 不符合要求; 根据要求3，[2,2] 比 [4,1] 更能符合要求. 所以输出长度 L 为 2， 宽度 W 为 2。
//    说明:
//
//    给定的面积不大于 10,000,000 且为正整数。
//    你设计的页面的长度和宽度必须都是正整数。
//    通过次数15,785提交次数29,247

    /// 本质上是求因数，注意循环的临界条件为 Math.sqrt(area)，因为采用从大到小遍历的方式，因此第一对的因数一定是距离最小的。
    func constructRectangle(_ area: Int) -> [Int] {
        let st = Int(sqrt(Double(area)))
        for i in (1 ... st).reversed() {
            guard area % i == 0 else { continue }
            let tmp = area / i
            if tmp >= i {
                return [tmp, i]
            }
        }
        return []
    }
}
