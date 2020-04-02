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
            //要删除的是第一个节点
            return hd.next
        }
        var tmp: ListNode? = hd
        while let next = tmp?.next {
            if next.val == val {
                //找到要删除的节点
                tmp?.next = next.next
                break
            }
            tmp = next
        }
        return hd
    }
}
