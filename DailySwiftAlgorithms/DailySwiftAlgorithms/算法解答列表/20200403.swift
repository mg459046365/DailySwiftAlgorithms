//
//  20200403.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/4.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200403 {
    // 题目： 给定一个排序链表，删除所有重复的元素，使得每个元素只出现一次。
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        if head == nil { return nil }
        if head?.next == nil { return nil }
        var cur = head
        while let next = cur?.next {
            if cur?.val == next.val {
                cur?.next = next.next
                next.next = nil
            } else {
                cur = next.next
            }
        }
        return head
    }
}
