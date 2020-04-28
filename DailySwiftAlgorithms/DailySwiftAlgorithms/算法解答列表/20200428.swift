//
//  20200428.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/29.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200428 {
    // 题目：从上到下打印出二叉树的每个节点，同一层的节点按照从左到右的顺序打印。
    //    例如:
    //    给定二叉树: [3,9,20,null,null,15,7],
    //
    //        3
    //       / \
    //      9  20
    //        /  \
    //       15   7
    //
    //    返回：
    //    [3,9,20,15,7]

    // 层级遍历
    static func levelOrder(_ root: TreeNode?) -> [Int] {
        guard let rt = root else { return [] }
        var list = [rt]
        var res = [Int]()
        while !list.isEmpty {
            var tmp = [TreeNode]()
            for node in list {
                res.append(node.val)
                if let left = node.left {
                    tmp.append(left)
                }
                if let right = node.right {
                    tmp.append(right)
                }
            }
            list = tmp
        }
        return res
    }
}
