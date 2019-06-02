//
//  MegerSort.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/13.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
struct MegerSort {
    
    ///归并排序  O(nlogn)
    ///原理：（假设序列共有n个元素）：
    ///将序列每相邻两个数字进行归并操作（merge)，形成floor(n/2+n%2)个序列，排序后每个序列包含两个元素
    ///将上述序列再次归并，形成floor(n/4)个序列，每个序列包含四个元素
    ///重复步骤2，直到所有元素排序完毕
    
    ///第一步：申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
    ///第二步：设定两个指针，最初位置分别为两个已经排序序列的起始位置
    ///第三步：比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
    ///重复步骤3直到某一指针超出序列尾
    ///将另一序列剩下的所有元素直接复制到合并序列尾
    
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
        let middle = (high - low)/2 + low
        mergeSortHelp(&list, helpList: &helpList, low: low, high: middle)
        mergeSortHelp(&list, helpList: &helpList, low: middle+1, high: high)
        mergeArray(&list, helpList: &helpList, low: low, mid: middle, high: high)
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
            }else{
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
