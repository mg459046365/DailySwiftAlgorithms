//
//  20200411.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/12.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200411 {
    // 题目：定义一个函数，输入一个链表的头节点，反转该链表并输出反转后链表的头节点。
    // 思路：定义三个指针，分别指向当前的节点，它的前置节点，它的后置节点
    // 注意：空链表，只有一个节点

    // 迭代的方式
    static func reverseListNode(_ head: ListNode?) -> ListNode? {
        guard let _ = head?.next else { return head }
        var pre: ListNode?
        var cur = head
        var next: ListNode?
        while cur != nil {
            next = cur?.next
            cur?.next = pre
            pre = cur
            cur = next
        }
        return pre
    }
    //递归的方式
    static func reverseListNodeByRecursion(_ head: ListNode?) -> ListNode? {
        guard let _ = head?.next else { return head }
        let newHead = reverseListNode(head?.next)
        head?.next?.next = head
        head?.next = nil
        return newHead
    }
}
