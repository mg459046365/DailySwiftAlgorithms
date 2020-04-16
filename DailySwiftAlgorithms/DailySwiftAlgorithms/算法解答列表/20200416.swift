//
//  20200416.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/17.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        left = nil
        right = nil
    }
}

class Solution_20200416 {
    /* 题目：输入两棵二叉树A和B，判断B是不是A的子结构。(约定空树不是任意一个树的子结构)
     B是A的子结构， 即A中有出现和B相同的结构和节点值。
     例如:
     给定的树 A:
          3
         / \
        4   5
       / \
      1   2

     给定的树 B：
        4
       /
      1

     返回 true，因为 B 与 A 的一个子树拥有相同的结构和节点值。
     */

    // 思路：第一步，在树A中找到和树B的根节点值一样的节点R
    // 第二步，树A中以R节点为根节点的子树是不是包含树B
    // 用到递归
    // 注意：节点A和B在查找的过程中，节点为空的情况

    static func hasSubtree(_ A: TreeNode?, subTree sub: TreeNode?) -> Bool {
        guard let a = A, let b = sub else { return false }
        var res = false
        if a.val == b.val {
            // 根节点相当，接续比较左右子节点
            res = helperHas(a, subTree: b)
        }
        if !res {
            // 根节出发未找到子树，比较A树左子树与B
            res = helperHas(a.left, subTree: b)
        }
        if !res {
            // 左子树中不包含子树B，比较A树右子树与B
            res = helperHas(a.right, subTree: b)
        }
        return res
    }

    static func helperHas(_ A: TreeNode?, subTree sub: TreeNode?) -> Bool {
        guard let b = sub else { return true }
        guard let a = A else { return false }
        if a.val != b.val { return false }
        return helperHas(a.left, subTree: b.left) && helperHas(a.right, subTree: b.right)
    }
}
