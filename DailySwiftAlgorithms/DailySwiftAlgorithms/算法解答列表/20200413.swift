//
//  20200413.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/14.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200413 {
    // 题目：输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序的。注意，递增排序。
    // 思路：先比较两个链表假设为a和b的第一个节点，然后把最小的节点取出,假设a的首节点最小。
    // 然后a链表此时的首节点变为第二个节点，继续和链表b的首节点比较。取出最小的节点，
    // 并将前一次的节点的next指针指向该节点。依次递推，可以使用递归解决。
    // 注意点：在递归的过程中，注意其中的节点可能已经走到了最后一个节点，遍历完毕了。

    static func merge(_ node1: ListNode?, node2: ListNode?) -> ListNode? {
        guard let n1 = node1 else { return node2 }
        guard let n2 = node2 else { return node1 }
        var res: ListNode?
        if n1.val < n2.val {
            // 相当于取出小的节点
            res = n1
            res?.next = merge(n1.next, node2: n2) // 继续比较剩下的部分
        } else {
            res = n2
            res?.next = merge(n1, node2: n2.next)
        }
        return res
    }
}
