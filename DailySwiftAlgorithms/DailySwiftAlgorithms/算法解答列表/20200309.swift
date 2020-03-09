//
//  20200309.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/9.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Helper_20200309 {
    // 题目： 输入一个链表的头结点，从尾到头反过来打印出每个节点的值。
    // 思路： 表头的数字，要放到结尾，满足栈的特性，后进先出。能用栈解决的大部分问题，都能运用递归解决。
    // 递归： 关键点 1. 推导公式 2.终止条件
    class ListNode {
        var val: Int
        var next: ListNode?
        init(val: Int, next: ListNode? = nil) {
            self.val = val
            self.next = next
        }
    }

    static func reversePrint(_ head: ListNode?) -> [Int] {
        guard let next = head?.next else {
            return []
        }
        var list = reversePrint(next)
        list.append(next.val)
        return list
    }
}
