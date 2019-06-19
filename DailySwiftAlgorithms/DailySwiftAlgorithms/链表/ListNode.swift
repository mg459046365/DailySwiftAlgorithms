//
//  List.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/20.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import Foundation

/// 链表
class ListNode {
    
    var val: Int
    var next: ListNode?

    init(_ val: Int) {
        self.val = val
        next = nil
    }

    /// 尾插法
    ///
    /// - Parameter val:
    /// - Returns:
    class func appendToTail(_ vals: [Int]) -> ListNode {
        var head: ListNode?
        var cur: ListNode?
        for value in vals {
            let node = ListNode(value)
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
    class func appendToHead(_ vals: [Int]) -> ListNode {
        var head: ListNode?
        var cur: ListNode?
        for value in vals {
            let node = ListNode(value)
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
    class func createList() -> ListNode {
        var head: ListNode?
        var cur: ListNode?
        for i in 1 ..< 11 {
            let node = ListNode(i)
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

    /// 创建链表
    class func createCycleList() -> ListNode {
        var head: ListNode?
        var cur: ListNode?
        for i in 1 ..< 7 {
            let node = ListNode(i)
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
        cur!.next = head
        return head!
    }

    /// 打印链表
    class func printList(_ head: ListNode) {
        var tmp: ListNode? = head
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
    func reverseList(_ head: ListNode) -> ListNode {
        var newHead: ListNode?
        var curHead: ListNode? = head
        while curHead != nil {
            let tmplist = curHead!.next
            curHead!.next = newHead
            newHead = curHead
            curHead = tmplist
        }
        return newHead!
    }

    /// 是否存在环形链表
    class func hasCycle(_ head: ListNode?) -> Bool {
        var slow: ListNode? = head
        var fast: ListNode? = head
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
    
    /// 判断链表中是否有环，并返回环的长度，如果没有环直接返回0即可
    class func cycleLength(_ head: ListNode?) -> Int {
        var slow: ListNode? = head
        var fast: ListNode? = head
        var hasCycle = false
        var length = 0
        while fast != nil && fast!.next != nil {
            slow = slow!.next
            fast = fast!.next!.next
            if hasCycle {
                length += 1
            }
            if slow === fast {
                if hasCycle {
                    return length;
                }
                hasCycle = true
            }
        }
        return 0
    }
    
    /// 求循环链表中的入环点
    func cycleStartNode(_ head: ListNode) -> ListNode {
        var slow: ListNode? = head
        var fast: ListNode? = head
        while fast != nil && fast!.next != nil {
            slow = slow!.next
            fast = fast!.next!.next
            if slow === fast {
                break;
            }
        }
        slow = head;
        while slow !== head {
            slow = slow!.next
            fast = fast?.next
        }
        return slow!
    }
    
    
    /// 给出一个链表和一个x值，要求将链表中所有小于x的值放到左边，所有大于或等于x的值放到右边，并且原链表的节点顺序不能变。
    ///
    /// - Parameters:
    ///   - head: 链表头
    ///   - x: 给定的x值
    /// - Returns: 新的链表
    func partition(_ head: ListNode?, _ x: Int) -> ListNode? {
        // 引入Dummy(虚拟)节点

        // 用于左边的排序
        let prevDummy = ListNode(0)
        var prev = prevDummy
        // 用于右边的排序
        let postDummy = ListNode(0)
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
    
    
//    将两个有序链表合并为一个新的有序链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。
//    输入：1->2->4, 1->3->4
//    输出：1->1->2->3->4->4
    
//    递归的套路：
//
//    找终止条件
//    想想应该返回什么值
//    本步应该做什么
    func mergerTwoList(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        //递归的终止条件：l1,l2其中一个走到头了或者两者同时走到头
        guard l1 != nil else {
            return l2
        }
        guard l2 != nil else {
            return l1
        }
        
//        //返回的应该是已经串好了的链表
//        //单步的操作是：将两个链表的较小者再串进去，并作为头节点返回给上一级
//        if l1.val <= l2.val {
//            l1.next = mergerTwoList(l1.next, l2)
//            return l1
//        }
//
//        l2.next = mergerTwoList(l2.next, l1)
//         return l2
        
        let res: ListNode = ListNode(0)
        var cur: ListNode? = res
        
        var list1: ListNode? = l1
        var list2: ListNode? = l2
        
        
        while list1 != nil, list1 != nil {
            if list1!.val <= list2!.val {
                cur!.next = list1
                cur = cur!.next
                list1 = list1!.next
            }else{
                cur!.next = list2
                cur = cur!.next
                list2 = list2!.next
            }
        }
        if list1 == nil {
            cur!.next = list2
        }else{
            cur?.next = list1
        }
        return res.next
       
    }
    
}
