//
//  20200408.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/9.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation
class Solution_20200408 {
    // 题目： 如果一个链表中包含环，如何找出环的入口节点？
    // 例如： 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> (指向前面的3)。环的入口节点是3
    // 思路： 1、通过快慢指针判断链表中是否有环。慢指针一次走一步，快指针一次走两步
    //       2、求出环的长度(节点的个数)。如果有环，快慢指针相遇的节点，肯定在环内。标记该节点，然后开始移动慢指针，并计数，
    //          当该指针再次回到该节点时，就可以得到环中节点的个数了。假设为n。
    //       3、根据第2不求得的环中节点的个数n，将快指针移动到节点头部，然后移动两个指针，直到相遇，
    //          相遇的该节点即是入口节点

    @discardableResult
    static func entryNode(_ head: ListNode?) -> ListNode? {
        var slow: ListNode? = isCircleNode(head)
        if slow == nil { return nil }
        // 有环，且slow为相遇的节点
        // 计算环中的节点数目
        var count = 1
        let val = slow!.val
        while let nextVal = slow?.next?.val, nextVal != val {
            count += 1
            slow = slow?.next
        }
        // 移动指针slow,count步
        slow = head
        for _ in 0 ..< count {
            slow = slow?.next
        }
        var other = head
        while other?.val != slow?.val {
            other = other?.next
            slow = slow?.next
        }
        print("输出入口节点的值: \(other?.val)")
        return other
    }

    static func isCircleNode(_ head: ListNode?) -> ListNode? {
        guard let hd = head else { return nil }
        var slow: ListNode? = hd.next
        if slow == nil { return nil }
        var fast: ListNode? = slow?.next
        while fast != nil, slow != nil {
            if fast!.val == slow!.val { return fast }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return nil
    }
    
    static func test() {
        let node1 = ListNode(1)
        let node2 = ListNode(2)
        let node3 = ListNode(3)
        let node4 = ListNode(4)
        let node5 = ListNode(5)
        let node6 = ListNode(6)
        node1.next = node2
        node2.next = node3
        node3.next = node4
        node4.next = node5
        node5.next = node6
        node6.next = node3
        entryNode(node1)
    }
    
    
}
