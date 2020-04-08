//
//  20200407.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/7.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class Solution_20200407 {
    // 题目：输入一个整数数组，实现一个函数来调整该数组中数字的顺序，使得所有奇数位于数组的前半部分，所有偶数位于数组的后半部分。
    // 思路：双指针法

    @discardableResult
    class func solutionFunc(_ nums: [Int]) -> [Int] {
        print("输入数组：\(nums)")
        guard !nums.isEmpty, nums.count > 1 else {
            print("输出数组：\(nums)")
            return nums
        }
        var left = 0
        var right = nums.count - 1
        var res = nums
        while left < right {
            if nums[left] % 2 != 0 {
                // 说明是奇数
                left += 1
                continue
            }
            if nums[right] % 2 == 0 {
                // 说明是偶数
                right -= 1
                continue
            }
            (res[left], res[right]) = (res[right], res[left])
            left += 1
            right -= 1
        }
        print("输出数组：\(res)")
        return res
    }

    class func test() {
        solutionFunc([])
        solutionFunc([1])
        solutionFunc([1, 2])
        solutionFunc([2, 1])
        solutionFunc([1, 2, 3, 4, 5])
    }

    @discardableResult
    class func solutionFuncExtension<T>(_ nums: [T], filter: (T) -> Bool) -> [T] {
        print("输入数据:\(nums)")
        guard !nums.isEmpty, nums.count > 2 else { return nums }
        var left = 0
        var right = nums.count - 1
        var res = nums
        while left < right {
            if filter(nums[left]) {
                left += 1
                continue
            }
            if !filter(nums[right]) {
                right -= 1
                continue
            }
            (res[left], res[right]) = (res[right], res[left])
            left += 1
            right -= 1
        }
        print("输出结果:\(res)")
        return res
    }

    class func testExtension() {
        // 测试能被三整除的在前面
        solutionFuncExtension([1, 2, 3, 4, 5, 6, 7]) {
            $0 % 3 == 0
        }
    }
}

class Solution_20200407_1 {
    // 题目：输入一个链表，输出该链表中倒数第k个节点。为了符合大多数人的习惯，本题从1开始计数，即链表的尾节点是倒数第1个节点。要求只能遍历一遍。
    // 例如，一个链表有6个节点，从头节点开始，它们的值依次是1、2、3、4、5、6。这个链表的倒数第3个节点是值为4的节点。

    // 思路：假设链表有n个节点，那么倒数第k个节点，也就是正数第n-k+1个节点。定义两个指针，他们均指向头结点。。
    // 遍历链表，将第一个指针，移动到节点k-1的位置(头结点为1)。然后此刻开始，每移动一次第一个指针，同时移动第二个指针。
    // 直到第一个指针走到链表的结尾。则此时，第二个指针指向的节点，即是我们要求得节点。
    // 第一个指针从k-1开始移动到尾结点，则一共移动了n-k+1次，这样的话第二个指针正好停在n-k+1节点的位置

    // 注意：空链表，索引小于0，以及索引大于链表长度的情况
    class func getKthPromEnd(_ head: ListNode?, _ k: Int) -> ListNode? {
        // 链表为空，k小于等于0的情况
        guard let hd = head, k > 0 else { return nil }
        var slow: ListNode? = hd
        var fast: ListNode? = hd
        for _ in 0 ..< k - 1 {
            fast = fast?.next
            if fast == nil {
                //k的值大于链表的长度
                return nil
            }
        }
        while fast?.next != nil {
            fast = fast?.next
            slow = slow?.next
        }
        return slow
    }
}
