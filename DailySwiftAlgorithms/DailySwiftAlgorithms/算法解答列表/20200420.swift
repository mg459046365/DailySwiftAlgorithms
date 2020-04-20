//
//  20200420.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/21.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200420 {
    // 题目：请完成一个函数，输入一个二叉树，该函数输出它的镜像。

    //    例如输入：
    //         4
    //       /   \
    //      2     7
    //     / \   / \
    //    1   3 6   9
    //
    //    镜像输出：
    //         4
    //       /   \
    //      7     2
    //     / \   / \
    //    9   6 3   1

    // 思路：先前序遍历这颗二叉树的每个节点，如果遍历到的节点有子节点，就交换它的两个子节点。
    // 当交换完所有非叶子节点的左右子节点后，就得到了树的镜像

    @discardableResult
    func mirrorTree(_ tree: TreeNode?) -> TreeNode? {
        guard let node = tree else { return nil }
        if node.left == nil, node.right == nil { return node }
        (node.left, node.right) = (node.right, node.left)
        if let left = node.left {
            mirrorTree(left)
        }
        if let right = node.right {
            mirrorTree(right)
        }
        return node
    }
}
