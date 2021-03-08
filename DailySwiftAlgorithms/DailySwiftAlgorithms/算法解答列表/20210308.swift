//
//  20210308.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/8.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210308 {
//    给定一个无重复元素的有序整数数组 nums 。
//
//    返回 恰好覆盖数组中所有数字 的 最小有序 区间范围列表。也就是说，nums 的每个元素都恰好被某个区间范围所覆盖，并且不存在属于某个范围但不属于 nums 的数字 x 。
//
//    列表中的每个区间范围 [a,b] 应该按如下格式输出：
//
//    "a->b" ，如果 a != b
//    "a" ，如果 a == b
//
//
//    示例 1：
//
//    输入：nums = [0,1,2,4,5,7]
//    输出：["0->2","4->5","7"]
//    解释：区间范围是：
//    [0,2] --> "0->2"
//    [4,5] --> "4->5"
//    [7,7] --> "7"
//    示例 2：
//
//    输入：nums = [0,2,3,4,6,8,9]
//    输出：["0","2->4","6","8->9"]
//    解释：区间范围是：
//    [0,0] --> "0"
//    [2,4] --> "2->4"
//    [6,6] --> "6"
//    [8,9] --> "8->9"
//    示例 3：
//
//    输入：nums = []
//    输出：[]
//    示例 4：
//
//    输入：nums = [-1]
//    输出：["-1"]
//    示例 5：
//
//    输入：nums = [0]
//    输出：["0"]
//
//
//    提示：
//
//    0 <= nums.length <= 20
//    -231 <= nums[i] <= 231 - 1
//    nums 中的所有值都 互不相同
//    nums 按升序排列
//
//    来源：力扣（LeetCode）
//    链接：https://leetcode-cn.com/problems/summary-ranges
//    著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。

    class func summaryRanges(_ nums: [Int]) -> [String] {
        guard nums.count > 1 else {
            return nums.compactMap {
                return "\($0)"
            }
        }
        var list = [String]()
        var pre = nums[0]
        var start = nums[0]
        var idx = 1
        while idx < nums.count {
            let tmp = nums[idx]
            if nums[idx - 1] + 1 == tmp {
                pre = tmp
                if idx == nums.count - 1 {
                    if start == pre {
                        list.append("\(start)")
                    } else {
                        list.append("\(start)->\(pre)")
                    }
                }
                idx += 1
                continue
            }
            if start == pre {
                list.append("\(start)")
            } else {
                list.append("\(start)->\(pre)")
            }
            if idx == nums.count - 1 {
                list.append("\(tmp)")
                break
            }
            start = tmp
            pre = tmp
            idx += 1
        }
        return list
    }

    class func test() {
        let list = [0, 2, 3, 4, 6, 8, 9]
        let result = summaryRanges(list)
        print("输出计算结果\(result)")
    }
}
