//
//  20200404.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/4.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200404 {
    // 题目：给定一个排序链表，删除所有含有重复数字的节点，只保留原始链表中 没有重复出现 的数字

    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        if head?.next == nil { return head }
        var left: ListNode?
        var right: ListNode?
        var cur = head
        var curHead: ListNode?
        while let next = cur?.next {
            if cur?.val == next.val {
                // 重复数字
                right = next
                cur = next
            } else {
                // 当前节点的值与下一个节点的值不同
                if let _ = right {
                    // 有重复的节点(含right节点)
                    if left == nil {
                        // 说明从头结点到节点right(含该节点)的数值相等，需要删除
                        curHead = next
                    } else {
                        // 说明left后面的节点到right节点(含rihgt节点)的值相同，需要删除
                        left?.next = next
                    }
                    cur = next
                    right?.next = nil
                    right = nil
                } else {
                    // right节点没有值, 说明没有要删除的节点值
                    if curHead == nil {
                        curHead = cur
                    }
                    left = cur
                    cur = next
                }
            }
        }
        if right != nil {
            if left == nil { return nil }
            left?.next = right?.next
            right?.next = nil
        }
        return curHead
    }
}
