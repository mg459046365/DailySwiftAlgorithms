//
//  20210326.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/3/26.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210326 {
//    两个整数之间的汉明距离指的是这两个数字对应二进制位不同的位置的数目。
//
//    给出两个整数 x 和 y，计算它们之间的汉明距离。
//
//    注意：
//    0 ≤ x, y < 231.
//
//    示例:
//
//    输入: x = 1, y = 4
//
//    输出: 2
//
//    解释:
//    1   (0 0 0 1)
//    4   (0 1 0 0)
//           ↑   ↑
//    上面的箭头指出了对应二进制位不同的位置。
    class func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var tmpx = x
        var tmpy = y
        var count = 0
        while tmpx != 0 || tmpy != 0 {
            if tmpx % 2 != tmpy % 2 {
                count += 1
            }
            tmpx = tmpx / 2
            tmpy = tmpy / 2
        }
        return count
    }

    class func test() {
        _ = hammingDistance(1, 4)
    }

//    给定一个 row x col 的二维网格地图 grid ，其中：grid[i][j] = 1 表示陆地， grid[i][j] = 0 表示水域。
//
//    网格中的格子 水平和垂直 方向相连（对角线方向不相连）。整个网格被水完全包围，但其中恰好有一个岛屿（或者说，一个或多个表示陆地的格子相连组成的岛屿）。
//
//    岛屿中没有“湖”（“湖” 指水域在岛屿内部且不和岛屿周围的水相连）。格子是边长为 1 的正方形。网格为长方形，且宽度和高度均不超过 100 。计算这个岛屿的周长。
//
//

//    示例 1：
//
//
//
//    输入：grid = [[0,1,0,0],[1,1,1,0],[0,1,0,0],[1,1,0,0]]
//    输出：16
//    解释：它的周长是上面图片中的 16 个黄色的边
//    示例 2：
//
//    输入：grid = [[1]]
//    输出：4
//    示例 3：
//
//    输入：grid = [[1,0]]
//    输出：4
//
//
//    提示：
//
//    row == grid.length
//    col == grid[i].length
//    1 <= row, col <= 100
//    grid[i][j] 为 0 或 1
    func islandPerimeter(_ grid: [[Int]]) -> Int {
        if grid.isEmpty { return 0 }
        var res = 0
        for val in grid {
            res += val.reduce(0, { $0 + $1 })
        }
        res = 4 * res
        // 处理水平重复相加的边框
        for list in grid {
            for i in 0 ..< list.count {
                if i == 0 { continue }
                if list[i] == 1, list[i - 1] == 1 {
                    res -= 2
                }
            }
        }
        if grid.count == 1 { return res }
        for i in 0 ..< grid[0].count {
            // i代表列，j代表行
            for j in 0 ..< grid.count {
                if j == 0 { continue }
                if grid[j][i] == 1, grid[j - 1][i] == 1 {
                    res -= 2
                }
            }
        }
        return res
    }
}
