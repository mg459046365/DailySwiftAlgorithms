//
//  20200323.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/24.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200323 {
    //题目： 地上有一个m行n列的方格，从坐标 [0,0] 到坐标 [m-1,n-1] 。一个机器人从坐标 [0, 0] 的格子开始移动，它每次可以向左、右、上、下移动一格（不能移动到方格外），也不能进入行坐标和列坐标的数位之和大于k的格子。例如，当k为18时，机器人能够进入方格 [35, 37] ，因为3+5+3+7=18。但它不能进入方格 [35, 38]，因为3+5+3+8=19。请问该机器人能够到达多少个格子？
    
    // 思路：回溯法。将矩阵看做二维数组。
    // 思路：https://leetcode-cn.com/problems/ji-qi-ren-de-yun-dong-fan-wei-lcof/solution/mian-shi-ti-13-ji-qi-ren-de-yun-dong-fan-wei-dfs-b/
    func movingCount(_ m: Int, _ n: Int, _ k: Int) -> Int {
        if k < 0 || m <= 0 || n <= 0 { return 0 }
        var vistors = [String: Int]()
        return movingCountCore(m, n, 0, 0, k, &vistors)
    }

    func movingCountCore(_ allRow: Int, _ allCol: Int, _ curRow: Int, _ curCol: Int, _ k: Int, _ vistors: inout [String: Int]) -> Int {
        let key = "\(curRow)-\(curCol)"
        if let _ = vistors[key] { return 0 } // 已经访问过
        guard curRow >= 0, curRow < allRow, curCol >= 0, curCol < allCol else { return 0 } // 越界
        guard numSum(curCol) + numSum(curRow) <= k else { return 0 } // 大于K，不满足条件
        vistors[key] = 0
        let count = 1
            + movingCountCore(allRow, allCol, curRow + 1, curCol, k, &vistors)
            + movingCountCore(allRow, allCol, curRow - 1, curCol, k, &vistors)
            + movingCountCore(allRow, allCol, curRow, curCol + 1, k, &vistors)
            + movingCountCore(allRow, allCol, curRow, curCol - 1, k, &vistors)
        return count
    }

    func numSum(_ num: Int) -> Int {
        var sum = 0
        var n = num
        while n > 0 {
            sum += n % 10
            n = n / 10
        }
        return sum
    }
}
