//
//  20191128.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/11/28.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
struct Helper_20191128 {
    /// 二分查找, 假设list是从小到大有序集合
    static func binarySearch(list: [Int], val: Int) -> Int {
        guard !list.isEmpty else { return -1 }

        var low = 0
        var hight = list.count - 1
        while low <= hight {
//            let mid = (low + hight)/2 //可能会溢出
//            let mid = low + (hight - low)/2
            let mid = low + ((hight - low) >> 1)
            if list[mid] == val {
                return mid
            } else if list[mid] < val {
                low = mid + 1
            } else {
                hight = mid - 1
            }
        }
        return -1
    }

    /// 使用递归实现二分查找
    static func binarySearchRecursion(list: [Int], low: Int, high: Int, val: Int) -> Int {
        guard high > low else { return -1 }
        let mid = low + ((high - low) >> 1)
        if list[mid] == val { return mid }
        if list[mid] < val { return binarySearchRecursion(list: list, low: mid + 1, high: high, val: val) }
        return binarySearchRecursion(list: list, low: low, high: mid - 1, val: val)
    }

    /// 查找第一个值等于给定值得元素， 假设list是从小到大有序集合
    static func binarySearchFirtIndex(list: [Int], equal val: Int) -> Int {
        guard !list.isEmpty else { return -1 }
        var low = 0
        var high = list.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if list[mid] < val {
                low = mid + 1
            } else if list[mid] > val {
                high = mid - 1
            } else {
                if mid == 0 || list[mid - 1] != val { return mid }
                high = mid - 1
            }
        }
        return -1
    }

    /// 查找最后一个值等于给定值得元素， 假设list是从小到大有序集合
    static func binarySearchLastIndex(list: [Int], equal val: Int) -> Int {
        guard !list.isEmpty else { return -1 }
        var low = 0
        var high = list.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if list[mid] < val {
                low = mid + 1
            } else if list[mid] > val {
                high = mid - 1
            } else {
                if mid == list.count - 1 || list[mid + 1] != val { return mid }
                low = mid + 1
            }
        }
        return -1
    }

    /// 查找第一个值大于等于给定值得元素， 假设list是从小到大有序集合
    static func binarySearchFistIndex(list: [Int], equalOrMax val: Int) -> Int {
        guard !list.isEmpty else { return -1 }
        var low = 0
        var high = list.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if list[mid] >= val {
                if mid == 0 || list[mid - 1] < val { return mid }
                high = mid - 1
            } else {
                low = mid + 1
            }
        }
        return -1
    }

    /// 查找最后一个小于等于给定值得元素， 假设list是从小到大有序集合
    static func binarySearchLastIndex(list: [Int], equalOrMin val: Int) -> Int {
        guard !list.isEmpty else { return -1 }
        var low = 0
        var high = list.count - 1
        while low <= high {
            let mid = low + ((high - low) >> 1)
            if list[mid] <= val {
                if mid == list.count - 1 || list[mid + 1] > val { return mid }
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return -1
    }
}
