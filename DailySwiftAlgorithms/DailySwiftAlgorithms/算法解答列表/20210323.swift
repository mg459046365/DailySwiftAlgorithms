//
//  20210323.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/23.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210323 {
//    最小操作次数使数组元素相等。
//
//    给定一个长度为 n 的 非空 整数数组，每次操作将会使 n - 1 个元素增加 1。找出让数组所有元素相等的最小操作次数。
//    示例：
//
//    输入：
//    [1,2,3]
//    输出：
//    3
//    解释：
//    只需要3次操作（注意每次操作会增加两个元素的值）：
//    [1,2,3]  =>  [2,3,3]  =>  [3,4,3]  =>  [4,4,4]

    class func minMoves(_ nums: [Int]) -> Int {
        if nums.count <= 1 { return 0 }
        let min = nums.sorted().first!
        var count = 0
        for i in nums {
            count += i - min
        }
        return count
    }

    class func test() {
        let list = [1, 2, 3]
        let result = minMoves(list)
        print("输出计算结果\(result)")
    }
}
