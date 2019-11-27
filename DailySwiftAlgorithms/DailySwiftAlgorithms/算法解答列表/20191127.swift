//
//  20191127.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/11/27.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

/// 如何在 O(n) 的时间复杂度内查找一个无序数组中的第 K 大元素, 采用快排分区分治思想
struct Helper_20191127 {
    private static func topValue(inList list: inout [Int], top: Int) -> Int {
        if list.isEmpty { return -1 }
        if top >= list.count { return -1 }
        return helper(inList: &list, left: 0, right: list.count - 1, top: top)
    }

    private static func helper(inList list: inout [Int], left: Int, right: Int, top: Int) -> Int {
        let p = partition(inList: &list, left: left, right: right)
        if top == p + 1 {
            return list[p]
        }
        if top < p + 1 {
            // 说明在左侧区间
            return helper(inList: &list, left: left, right: p - 1, top: top)
        } else {
            // 说明在右侧区间
            return helper(inList: &list, left: p + 1, right: right, top: top)
        }
    }

    // 分区，左侧的都大于pivot，右侧的都小于pivot,返回游标
    private static func partition(inList list: inout [Int], left: Int, right: Int) -> Int {
        let pivot = list[left]
        var cursor = left
        for i in left + 1 ... right {
            if list[i] > pivot {
                cursor += 1
                (list[cursor], list[i]) = (list[i], list[cursor])
            }
        }
        (list[left], list[cursor]) = (list[cursor], list[left])
        print("当前基值=\(pivot), 分区后的结果=\(list)")
        return cursor
    }

    static func test() {
        var list = [5, 4, 1, 2, 7, 0, 9, 3, 6]
        let val = topValue(inList: &list, top: 3)
        print("计算结果=\(val)，正确结果=6")
    }
}
