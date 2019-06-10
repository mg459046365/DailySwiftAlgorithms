//
//  Heap.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/6/10.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

class Heap {
    
    /// 创建堆
    class func buildHeap(_ list: inout [Int]) {
        for i in (0 ... (list.count - 2)/2).reversed() {
            downAdjust(&list, parentIndex: i, length: list.count)
        }
    }
    
    
    /// 上浮操作
    class func upAdjust(_ list: inout [Int]) {
        var childIndex = list.count - 1
        var parentIndex = (childIndex - 1)/2
        let temp = list[childIndex]
        while childIndex > 0, temp < list[parentIndex] {
            list[childIndex] = list[parentIndex]
            childIndex = parentIndex
            parentIndex = (parentIndex - 1)/2
        }
        list[childIndex] = temp
    }
    
    /// 下沉操作
    class func downAdjust(_ list: inout [Int], parentIndex: Int, length: Int) {
        let temp = list[parentIndex]
        var childIndex = 2*parentIndex + 1
        var parentIndex = parentIndex;
        while childIndex < length {
            if childIndex + 1 < length, list[childIndex + 1] < list[childIndex] {
                //如果有右孩子，且右孩子小于左孩子的值，则定位到右孩子
                childIndex += 1
            }
            if temp <= list[childIndex] {
                // 如果父节点小于任何一个孩子的值，则直接跳出
                break
            }
            list[parentIndex] = list[childIndex]
            parentIndex = childIndex
            childIndex = 2*parentIndex + 1
        }
        list[parentIndex] = temp
    }
    
}
