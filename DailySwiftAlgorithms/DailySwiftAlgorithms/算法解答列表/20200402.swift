//
//  20200402.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/3.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Helper_20200402 {
    // 题目： 给定单向链表的头指针和一个要删除的节点的值，定义一个函数删除该节点。返回删除后的链表的头节点。题目保证链表中节点的值互不相同
    // 思路： 遍历链表查找要删除的节点。注意，当前节点就是第一个节点的情况
    func deleteNode(_ head: ListNode?, _ val: Int) -> ListNode? {
        guard let hd = head else { return nil }
        if hd.val == val {
            // 要删除的是第一个节点
            return hd.next
        }
        var tmp: ListNode? = hd
        while let next = tmp?.next {
            if next.val == val {
                // 找到要删除的节点
                tmp?.next = next.next
                break
            }
            tmp = next
        }
        return hd
    }

    // 题目：给定单向链表的头指针和一个要删除的节点的指针，定义一个函数在O(1)时间内删除该节点。返回删除后的链表的头节点。
    // 题目保证该节点一定在链表中存在，且链表中每个节点的值互不相同。
    // 思路：将该节点的next节点的值，拷贝到该节点中，同时将该节点的next指针，指向他的next节点的next节点。
    // 注意：1.该节点是头结点 2.该节点是尾结点
    func deleteNodeOther(_ head: ListNode?, _ deleteNode: ListNode) -> ListNode? {
        guard let hd = head else { return nil }
        if hd.val == deleteNode.val {
            // 删除头结点
            let next = head?.next
            // 将头结点的next指针置位nil
            head?.next = nil
            return next
        }
        if deleteNode.next == nil {
            // 删除的是尾结点，需要遍历，找到该节点的前向节点
            var nd: ListNode? = hd
            while let next = nd?.next {
                if next.val == deleteNode.val {
                    // 找到该节点前向节点
                    break
                }
                nd = next
            }
            nd?.next = nil
            return hd
        }
        // 不是尾结点
        let next = deleteNode.next!
        deleteNode.val = next.val
        deleteNode.next = next.next
        next.next = nil
        return hd
    }
}
