//
//  20200310.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/10.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Solution_20200310 {
    // 题目： 输入某二叉树的前序遍历和中序遍历的结果，请重建该二叉树。假设输入的前序遍历和中序遍历的结果中都不包含重复的数字。
    // 例如，输入的前序遍历序列[1, 2, 4, 7, 3, 5, 6, 8]和中序遍历序列[4, 7, 2, 1, 5, 3, 8, 6]则重建如下图的二叉树
//                                           1
//                                     2            3
//                                4             5          6
//                                    7                  8

    // 思路： 前序遍历，先遍历根节点，在遍历左子节点，最后遍历右子节点。
//           中序遍历，先遍历左子节点，在遍历根节点，最后遍历右子节点。
    // 前序遍历中，第一个数字总是树的根节点的值。
    // 在中序遍历中，左子树节点的值都位于根节点的值得左侧，右子树节点的值都位于根节点的值的右侧。
    // 前序遍历得到根节点，然后在对根节点左侧的左子树的节点重复上述操作。同理，右子树一样的重复操作。
    // 在不断的循环或者递归过程中，遍历所有的节点。直到左侧或右侧都不存在节点的值。
    static var list = [Int]()
    // 定义二叉树
    class TreeNode {
        var val: Int
        var left: TreeNode?
        var right: TreeNode?
        init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
            self.val = val
            self.left = left
            self.right = right
        }
    }

    // 层级遍历
    static func tierPrint(_ header: TreeNode?) -> [Int] {
        guard let tr = header else { return [] }
        var res = [Int]()
        var tmp = [tr]
        while !tmp.isEmpty {
            var list = [TreeNode]()
            for t in tmp {
                res.append(t.val)
                if let left = t.left {
                    list.append(left)
                }
                if let right = t.right {
                    list.append(right)
                }
            }
            tmp = list
        }
        return res
    }

    static func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.isEmpty || inorder.isEmpty { return nil }
        let root = TreeNode(val: preorder[0])
        if preorder.count == 1 {
            return root
        }
        // 根据中序遍历，分别找到左子树序列集和右子树序列集
        let index = inorder.firstIndex(of: preorder[0])!

        if index == 0 {
            // 只有右子树
            let inorderRight = Array(inorder[1...])
            let preorderRight = Array(preorder[1 ..< preorder.count])
            root.left = nil
            root.right = buildTree(preorderRight, inorderRight)
            return root
        }

        if index == inorder.count - 1 {
            // 只有左子树
            let inorderLeft = Array(inorder[0 ..< index])
            let preorderLeft = Array(preorder[1 ..< preorder.count])
            root.left = buildTree(preorderLeft, inorderLeft)
            root.right = nil
            return root
        }
        let inorderLeft = Array(inorder[0 ..< index])
        let inorderRight = Array(inorder[(index + 1)...])
        let preorderLeft = Array(preorder[1 ... inorderLeft.count])
        let preorderRight = Array(preorder[(inorderLeft.count + 1)...])
        root.left = buildTree(preorderLeft, inorderLeft)
        root.right = buildTree(preorderRight, inorderRight)
        return root
    }

    static func test() {
        let preorder = [1, 2, 4, 7, 3, 5, 6, 8]
        let inorder = [4, 7, 2, 1, 5, 3, 8, 6]
        let tree = buildTree(preorder, inorder)
        let tierList = tierPrint(tree)
        print("层级遍历构建后的二叉树的序列：\(tierList)")
    }
}
