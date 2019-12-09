//
//  Tree.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/11.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

class Tree {
    /// 值
    var value: Int
    /// 左子树
    var left: Tree?
    /// 右子树
    var right: Tree?

    var result = [Int]()
    var levelResult = [[Int]]()

    init(_ value: Int) {
        self.value = value
    }

    /// 计算最大深度，递归调用
    func maxDepth(root: Tree?) -> Int {
        guard let root = root else {
            return 0
        }
        return max(maxDepth(root: root.left), maxDepth(root: root.right)) + 1
    }

    /// 使用递归实现前序遍历
    func preOrderTraversalByRecursive(root: Tree?) -> [Int] {
        if let root = root {
            result.append(root.value)
            result = preOrderTraversalByRecursive(root: root.left)
            result = preOrderTraversalByRecursive(root: root.right)
        }

        return result
    }

    /// 使用栈实现前序遍历(栈用数组代替)
    func preOrderTraversalByStack(root: Tree?) -> [Int] {
        // 遍历结果
        var result = [Int]()
        // 缓存节点
        var stack = [Tree]()
        var node = root
        while !stack.isEmpty || node != nil {
            if node != nil {
                result.append(node!.value)
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast().right
            }
        }
        return result
    }

    /// 使用递归实现中序遍历
    func inOrderTraversalByRecursive(root: Tree?) -> [Int] {
        if let root = root {
            result = inOrderTraversalByRecursive(root: root.left)
            result.append(root.value)
            result = inOrderTraversalByRecursive(root: root.right)
        }
        return result
    }

    /// 使用栈实现中序遍历
    func inOrderTraversal(root: Tree?) -> [Int] {
        // 遍历结果
        var result = [Int]()
        var stack = [Tree]()
        var node = root
        while !stack.isEmpty || node != nil {
            if node != nil {
                stack.append(node!)
                node = node!.left
            } else {
                node = stack.removeLast()
                result.append(node!.value)
                node = node?.right
            }
        }
        return result
    }

    /// 使用递归实现后序遍历
    func followOrderTraversalByRecursive(root: Tree?) -> [Int] {
        if let root = root {
            result = followOrderTraversalByRecursive(root: root.left)
            result = followOrderTraversalByRecursive(root: root.right)
            result.append(root.value)
        }

        return result
    }

    /// 使用栈实现后序遍历(栈用数组代替)
    func followOrderTraversalByStack(root: Tree?) -> [Int] {
        // 遍历结果
        var result = [Int]()
        // 缓存节点
        var stack = [Tree]()
        var node = root
        var right: Tree?
        while !stack.isEmpty || node != nil {
            if node != nil {
                stack.append(node!)
                node = node?.left
            } else {
                node = stack.last
                if node!.right == nil || node!.right === right {
                    result.append(node!.value)
                    stack.removeLast()
                    right = node
                    node = nil
                } else {
                    node = node!.right
                }
            }
        }
        return result
    }

    /// 翻转二叉树，递归的方式
    func invertTree(_ root: Tree?) -> Tree? {
        if root == nil {
            return nil
        }
        let res = root
        (res!.left, res!.right) = (res!.right, res!.left)
        _ = invertTree(res!.left)
        _ = invertTree(res!.right)
        return res
    }

    /// 判断二叉树是否是二叉查找树(二叉排序树)
    /// 所有左子树节点都必须小于根节点，所有右子树节点必须大于根节点
    func isVaildBST(root: Tree?) -> Bool {
        return bstHelper(node: root, min: nil, max: nil)
    }

    /// 判断是否是二叉查找树
    func bstHelper(node: Tree?, min: Int?, max: Int?) -> Bool {
        guard let node = node else {
            return true
        }

        /// 所有右子树节点的值都必须大于根节点
        if let min = min, node.value <= min {
            return false
        }
        /// 所有左子树节点的值都必须小于根节点
        if let max = max, node.value >= max {
            return false
        }
        return bstHelper(node: node.left, min: min, max: node.value) && bstHelper(node: node.right, min: node.value, max: max)
    }

    /// 二叉树的层级遍历
    func levelOrder(_ root: Tree?) -> [[Int]] {
        help(root != nil ? [root!] : nil)
        return levelResult
    }

    func help(_ list: [Tree]?) {
        if list == nil || list!.isEmpty {
            return
        }
        var array = [Int]()
        var nextList = [Tree]()
        for node in list! {
            array.append(node.value)
            if node.left != nil {
                nextList.append(node.left!)
            }
            if node.right != nil {
                nextList.append(node.right!)
            }
        }
        if !array.isEmpty {
            levelResult.append(array)
        }
        help(nextList)
    }
}

/// 二叉查找树
class BinarySearchTree: Tree {
    /// 查找数据
    func find(_ val: Int) -> Tree? {
        var tree: Tree? = self
        while let tr = tree {
            if val == tr.value { return tr }
            if val < tr.value {
                tree = tr.left
            } else {
                tree = tr.right
            }
        }
        return nil
    }

    /// 插入数据
    func insert(_ val: Int) {
        var tree: Tree? = self
        while let tr = tree {
            if val > tr.value {
                guard let _ = tr.right else {
                    tr.right = Tree(val)
                    return
                }
                tree = tr.right
            } else {
                guard let _ = tr.left else {
                    tr.left = Tree(val)
                    return
                }
                tree = tr.left
            }
        }
    }

    /// 删除某个节点
    /// 第一种情况：如果要删除的节点没有子节点，直接将父节点中，指向要删除节点的指针置为nil
    /// 第二种情况：如果要删除的节点只有一个子节点，只需要更新父节点中，指向要删除节点的指针，将他指向要删除的节点的子节点
    /// 第三种情况： 如果要删除的节点有两个子节点，找个找个节点的右子树中的最小节点，把它替换到要删除的节点上，然后删除掉这个最小节点。
    func delete(val: Int) {
        var p: Tree? = self as Tree // 指向要删除的节点，初始化指向根节点
        var pp: Tree? // pp记录的是p的父节点
        while let tmp = p, tmp.value != val {
            pp = tmp
            if val > tmp.value {
                p = tmp.right
            } else {
                p = tmp.left
            }
        }
        if p == nil { return } // 没有找到
        // 要删除的节点有两个子节点
        if let _ = p?.left, let _ = p?.right {
            // 查找右子树中最小的节点
            var minP = p?.right
            var minPP = p // 表示minP的父节点
            while let _ = minP?.left {
                minPP = minP
                minP = minP?.left
            }
            p?.value = minP!.value // 将minP中的数据替换到P中
            p = minP // 删除minP
            pp = minPP
        }

        // 要删除的节点上是叶节点或者只有一个子节点
        var child: Tree?
        if let left = p?.left {
            child = left
        } else if let right = p?.right {
            child = right
        }
        if pp == nil {
            // 删除的是根节点
            value = val
            left = child?.left
            right = child?.right
        } else if pp?.left?.value == p?.value {
            // 删除的是左子节点
            pp?.left = child
        } else {
            // 删除的是右子节点
            pp?.right = child
        }
    }
}
