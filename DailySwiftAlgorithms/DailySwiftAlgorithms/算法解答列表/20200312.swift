//
//  20200312.swif.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/12.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
struct Solution_20200312 {
    // 题目： 给定一颗二叉树和其中的一个节点，如何找出中序遍历序列的下一个节点？树中的节点除了有两个分别指向左右子节点的指针外，
    // 还有一个指向父节点的指针。如下二叉树，中序遍历顺序为 [4, 2, 8, 5, 9, 1, 6, 3, 7]
    // 学会画图，找规律
//                                           1
//                                2                       3
//                         4             5           6          7
//                                     8   9

    // 定义二叉树
    class TreeNode {
        var val: Int
        var parent: TreeNode?
        var left: TreeNode?
        var right: TreeNode?
        init(val: Int, left: TreeNode? = nil, right: TreeNode? = nil) {
            self.val = val
            self.left = left
            self.right = right
        }

        class func createSampleTreeHelper() -> TreeNode {
            let root = TreeNode(val: 1)
            let node2 = TreeNode(val: 2)
            let node3 = TreeNode(val: 3)
            let node4 = TreeNode(val: 4)
            let node5 = TreeNode(val: 5)
            let node6 = TreeNode(val: 6)
            let node7 = TreeNode(val: 7)
            let node8 = TreeNode(val: 8)
            let node9 = TreeNode(val: 9)

            root.left = node2
            root.right = node3
            node2.parent = root
            node3.parent = root

            node2.left = node4
            node2.right = node5
            node4.parent = node2
            node5.parent = node2

            node3.left = node6
            node3.right = node7
            node6.parent = node3
            node7.parent = node3

            node5.left = node8
            node5.right = node9
            node8.parent = node5
            node9.parent = node5
            return node6
        }
    }

    static func findNextNode(_ node: TreeNode?) -> TreeNode? {
        guard let nd = node else { return nil }
        if let right = nd.right {
            // 如果一个节点有右子树，那么他的下一个节点为它的右子树中的最左子节点.
            // 也就是说，从右子节点出发一直沿着指向做子节点的指针，就能找到它的下一个节点。
            var next = right
            while let pr = next.left {
                next = pr
            }
            return next
        }
        // 如果接地那没有右子树。如果节点是它父节点的左子节点，，那么它的下一个节点就是它的父节点。

        // 如果一个节点既没有右子树，并且它还是它父节点的右子节点。我们可以沿着指向父节点的指针一直向上遍历，直到找到一个是它
        // 父节点的左子节点的节点。如果这样的节点存在，那么这个节点的父节点就是我们要找的下一个节点
        if let parent = nd.parent {
            var cur: TreeNode? = nd
            var mpar: TreeNode? = parent
            while let tmpPar = mpar, cur === tmpPar.right {
                cur = mpar
                mpar = mpar?.parent
            }
            return mpar
        }
        return nil
    }

    static func test() {
        let root = TreeNode(val: 1)
        let node2 = TreeNode(val: 2)
        let node3 = TreeNode(val: 3)
        let node4 = TreeNode(val: 4)
        let node5 = TreeNode(val: 5)
        let node6 = TreeNode(val: 6)
        let node7 = TreeNode(val: 7)
        let node8 = TreeNode(val: 8)
        let node9 = TreeNode(val: 9)

        root.left = node2
        root.right = node3
        node2.parent = root
        node3.parent = root

        node2.left = node4
        node2.right = node5
        node4.parent = node2
        node5.parent = node2

        node3.left = node6
        node3.right = node7
        node6.parent = node3
        node7.parent = node3

        node5.left = node8
        node5.right = node9
        node8.parent = node5
        node9.parent = node5
        // 中序遍历结果
//        [4, 2, 8, 5, 9, 1, 6, 3, 7]

        // 0,代表为nil
        print("根节点1的下一个节点是\(findNextNode(root)?.val ?? 0)")
        print("节点2的下一个节点是\(findNextNode(node2)?.val ?? 0)")
        print("节点3的下一个节点是\(findNextNode(node3)?.val ?? 0)")
        print("节点4的下一个节点是\(findNextNode(node4)?.val ?? 0)")
        print("节点5的下一个节点是\(findNextNode(node5)?.val ?? 0)")
        print("节点6的下一个节点是\(findNextNode(node6)?.val ?? 0)")
        print("节点7的下一个节点是\(findNextNode(node7)?.val ?? 0)")
        print("节点8的下一个节点是\(findNextNode(node8)?.val ?? 0)")
        print("节点9的下一个节点是\(findNextNode(node9)?.val ?? 0)")
    }
}
