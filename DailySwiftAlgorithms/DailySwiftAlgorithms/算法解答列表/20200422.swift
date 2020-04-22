//
//  20200422.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/23.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200422 {
    // 题目：请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的。

//    例如，二叉树 [1,2,2,3,4,4,3] 是对称的。
//
//        1
//       / \
//      2   2
//     / \ / \
//    3  4 4  3
//    但是下面这个 [1,2,2,null,3,null,3] 则不是镜像对称的:
//        1
//       / \
//      2   2
//       \   \
//       3    3
    func isSymmetric(_ root: TreeNode?) -> Bool {
        isSymmetricHelper(root?.left, root?.right)
    }

    func isSymmetricHelper(_ left: TreeNode?, _ right: TreeNode?) -> Bool {
        if left == nil, right == nil { return true }
        if left == nil || right == nil { return false }
        if left?.val != right?.val { return false }
        return isSymmetricHelper(left?.left, right?.right) && isSymmetricHelper(left?.right, right?.left)
    }
}
