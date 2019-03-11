//
//  List.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/20.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import Foundation

/// 链表
class List {
    var val: Int
    var next: List?

    init(_ val: Int) {
        self.val = val
        next = nil
    }

    /// 尾插法
    ///
    /// - Parameter val:
    /// - Returns:
    class func appendToTail(_ vals: [Int]) -> List {
        var head: List?
        var cur: List?
        for value in vals {
            let node = List(value)
            if cur == nil {
                cur = node
            } else {
                cur!.next = node
                cur = node
            }
            if head == nil {
                head = cur
            }
        }
        return head!
    }

    /// 头插法
    ///
    /// - Parameter vals:
    /// - Returns:
    class func appendToHead(_ vals: [Int]) -> List {
        var head: List?
        var cur: List?
        for value in vals {
            let node = List(value)
            if cur == nil {
                cur = node
            } else {
                node.next = cur
                cur = node
            }
            head = node
        }
        return head!
    }

    /// 创建链表，尾插法
    class func createList() -> List {
        var head: List?
        var cur: List?
        for i in 1 ..< 11 {
            let list = List(i)
            if cur == nil {
                cur = list
            } else {
                cur!.next = list
                cur = list
            }
            if head == nil {
                head = cur
            }
        }
        return head!
    }

    /// 创建链表
    class func createCycleList() -> List {
        var head: List?
        var cur: List?
        for i in 1 ..< 7 {
            let list = List(i)
            if cur == nil {
                cur = list
            } else {
                cur!.next = list
                cur = list
            }
            if head == nil {
                head = cur
            }
        }
        cur!.next = head
        return head!
    }

    /// 打印链表
    class func printList(_ list: List) {
        var tmp: List? = list
        print("打印链表")
        var index = 0
        while tmp != nil {
            print(tmp!.val)
            tmp = tmp!.next
            index += 1
            if index > 30 {
                break
            }
        }
    }

    /// 反转链表
    func reverseList() -> List {
        var newHead: List?
        var curHead: List? = self
        while curHead != nil {
            let list = curHead!.next
            curHead!.next = newHead
            newHead = curHead
            curHead = list
        }
        return newHead!
    }

    // 是否存在环形链表
    class func hasCycle(_ head: List?) -> Bool {
        var slow: List? = head
        var fast: List? = head
        while fast != nil && fast!.next != nil {
            slow = slow!.next
            fast = fast!.next!.next
            print("慢行指针\(slow!.val)")
            print("快行指针\(fast!.val)")
            if slow === fast {
                return true
            }
        }
        return false
    }

    /// 给出一个链表和一个x值，要求将链表中所有小于x的值放到左边，所有大于或等于x的值放到右边，并且原链表的节点顺序不能变。
    ///
    /// - Parameters:
    ///   - head: 链表头
    ///   - x: 给定的x值
    /// - Returns: 新的链表
    func partition(_ head: List?, _ x: Int) -> List? {
        // 引入Dummy(虚拟)节点

        // 用于左边的排序
        let prevDummy = List(0)
        var prev = prevDummy
        // 用于右边的排序
        let postDummy = List(0)
        var post = postDummy

        var node = head

        // 用尾插法处理左边和右边
        while node != nil {
            if node!.val < x {
                prev.next = node
                prev = node!
            } else {
                post.next = node
                post = node!
            }
            node = node!.next
        }

        // 防止构成环
        post.next = nil
        // 左右拼接
        prev.next = postDummy.next
        return prevDummy.next
    }
}
