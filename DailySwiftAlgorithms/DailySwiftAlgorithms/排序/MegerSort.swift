//
//  MegerSort.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/13.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
struct MegerSort {
    /// 归并排序  O(nlogn)
    /// 原理：（假设序列共有n个元素）：
    /// 将序列每相邻两个数字进行归并操作（merge)，形成floor(n/2+n%2)个序列，排序后每个序列包含两个元素
    /// 将上述序列再次归并，形成floor(n/4)个序列，每个序列包含四个元素
    /// 重复步骤2，直到所有元素排序完毕

    /// 第一步：申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
    /// 第二步：设定两个指针，最初位置分别为两个已经排序序列的起始位置
    /// 第三步：比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
    /// 重复步骤3直到某一指针超出序列尾
    /// 将另一序列剩下的所有元素直接复制到合并序列尾

    static func mergeSort(_ list: inout [Int]) -> [Int] {
        guard list.count > 1 else {
            return list
        }
        var helper = [Int](repeating: 0, count: list.count)
        var array = list
        mergeSortHelp(&array, helpList: &helper, low: 0, high: array.count - 1)
        return array
    }

    /// 归并排序分解合并序列
    ///
    /// - Parameters:
    ///   - list: 序列
    ///   - childArrayElementCount: 子序列中元素的个数
    static func mergeSortHelp(_ list: inout [Int], helpList: inout [Int], low: Int, high: Int) {
        guard low < high else {
            return
        }
        let middle = (high - low) / 2 + low
        mergeSortHelp(&list, helpList: &helpList, low: low, high: middle) // 分成两个部分
        mergeSortHelp(&list, helpList: &helpList, low: middle + 1, high: high) // 分成两个部分
        mergeArray(&list, helpList: &helpList, low: low, mid: middle, high: high) // 合并
    }

    /// 合并两个序列
    static func mergeArray(_ list: inout [Int], helpList: inout [Int], low: Int, mid: Int, high: Int) {
        for i in low ... high {
            helpList[i] = list[i]
        }

        var helpLeft = low
        var helpRight = mid + 1
        var current = low

        while helpLeft <= mid && helpRight <= high {
            if helpList[helpLeft] <= helpList[helpRight] {
                list[current] = helpList[helpLeft]
                helpLeft += 1
            } else {
                list[current] = helpList[helpRight]
                helpRight += 1
            }
            current += 1
        }

        guard (mid - helpLeft) >= 0 else {
            return
        }
        for i in 0 ... mid - helpLeft {
            list[current + i] = helpList[helpLeft + i]
        }
    }
}

// 归并排序
// 核心是将数组分割成两个子数组，让子数组有序，之后再合并两个有序的子数组到最终的结果数组中去。
// 可以采用二分的方式进行子数组的分割，递归进行，当子数组只剩下一个元素时，其本身就变成了一个有序数组
// 之后只需要根据递归的逻辑一层一层向上合并即可
func mergeSort1(_ list: inout [Int]) {
    if list.count <= 1 { return }
    let mid = list.count / 2
    var left = Array(list[..<mid])
    var right = Array(list[mid...])
    mergeSort1(&left)
    mergeSort1(&right)
    list = merge1(left: left, right: right)
}

// 从小到大排序
func merge1(left: [Int], right: [Int]) -> [Int] {
    var res = [Int]()
    var leftList = left
    var rightList = right
    while leftList.count > 0, rightList.count > 0 {
        if leftList[0] > rightList[0] {
            res.append(rightList[0])
            rightList.removeFirst()
        } else {
            res.append(leftList[0])
            leftList.removeFirst()
        }
    }
    if leftList.count > 0 {
        res.append(contentsOf: leftList)
    }
    if rightList.count > 0 {
        res.append(contentsOf: rightList)
    }
    return res
}
