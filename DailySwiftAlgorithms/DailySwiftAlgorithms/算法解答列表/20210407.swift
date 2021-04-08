//
//  20210407.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/4/7.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210407 {
//    给定一个有相同值的二叉搜索树（BST），找出 BST 中的所有众数（出现频率最高的元素）。
//
//    假定 BST 有如下定义：
//
//    结点左子树中所含结点的值小于等于当前结点的值
//    结点右子树中所含结点的值大于等于当前结点的值
//    左子树和右子树都是二叉搜索树
//    例如：
//    给定 BST [1,null,2,2],
//
//       1
//        \
//         2
//        /
//       2
//    返回[2].
//
//    提示：如果众数超过1个，不需考虑输出顺序
//
//    进阶：你可以不使用额外的空间吗？（假设由递归产生的隐式调用栈的开销不被计算在内）

    var result = [Int]()
    var curValue = 0
    var count = 0
    var maxCount = 0

    private func findMode(node: TreeNode?) -> [Int] {
        dfs(node: node)
        return result
    }

    private func dfs(node: TreeNode?) {
        guard let hd = node else { return }
        dfs(node: hd.left)
        update(hd.val)
        dfs(node: hd.right)
    }

    private func update(_ val: Int) {
        if val == curValue {
            count += 1
        } else {
            count = 1
            curValue = val
        }
        if count == maxCount {
            result.append(curValue)
        }
        if count > maxCount {
            maxCount = count
            result.removeAll()
            result.append(curValue)
        }
    }

//    给定一个整数，将其转化为7进制，并以字符串形式输出。
//
//    示例 1:
//
//    输入: 100
//    输出: "202"
//    示例 2:
//
//    输入: -7
//    输出: "-10"
//    注意: 输入范围是 [-1e7, 1e7] 。
    func convertToBase7(_ num: Int) -> String {
        if num == 0 { return "0" }
        var res = ""
        var tmp = abs(num)
        while tmp >= 7 {
            res = "\(tmp % 7)" + res
            tmp = tmp / 7
        }
        if tmp != 0 {
            res = "\(tmp)" + res
        }
        return (num > 0 ? "" : "-") + res
    }

//    给出 N 名运动员的成绩，找出他们的相对名次并授予前三名对应的奖牌。前三名运动员将会被分别授予 “金牌”，“银牌” 和“ 铜牌”（"Gold Medal", "Silver Medal", "Bronze Medal"）。
//
//    (注：分数越高的选手，排名越靠前。)
//
//    示例 1:
//
//    输入: [5, 4, 3, 2, 1]
//    输出: ["Gold Medal", "Silver Medal", "Bronze Medal", "4", "5"]
//    解释: 前三名运动员的成绩为前三高的，因此将会分别被授予 “金牌”，“银牌”和“铜牌” ("Gold Medal", "Silver Medal" and "Bronze Medal").
//    余下的两名运动员，我们只需要通过他们的成绩计算将其相对名次即可。
//    提示:
//
//    N 是一个正整数并且不会超过 10000。
//    所有运动员的成绩都不相同。

    static func findRelativeRanks(_ score: [Int]) -> [String] {
        if score.isEmpty { return [] }
        var tmp = score
        tmp = tmp.sorted(by: { $0 >= $1 })
        var res = [String]()
        for val in score {
            let idx = halfSearchIndex(list: tmp, val: val)
            if idx == 0 {
                res.append("Gold Medal")
            } else if idx == 1 {
                res.append("Silver Medal")
            } else if idx == 2 {
                res.append("Bronze Medal")
            } else {
                res.append("\(idx + 1)")
            }
        }
        return res
    }

    static func halfSearchIndex(list: [Int], val: Int) -> Int {
        guard !list.isEmpty else { return 0 }
        var left = 0
        var right = list.count - 1
        while left <= right {
            let mid = left + (right - left) / 2
            if list[mid] == val {
                return mid
            } else if list[mid] < val {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return 0
    }

    static func test() {
        let list = [10, 3, 8, 9, 4]
        let res = findRelativeRanks(list)
        print("打印结果\(res)")
    }
}
