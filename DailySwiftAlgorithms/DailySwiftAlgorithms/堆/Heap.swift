//
//  Heap.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/6/10.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
/// 堆是完全二叉树，用数组来存储完全二叉树是非常节省空间的。数组中下标为i的节点，左节点为2*i，右节点下标为2*i+1,父节点的下标为i/2
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
    
    
    /// “下沉”调整,构建大顶堆
    /// - Parameter list: 待调整的堆
    /// - Parameter parentIndex: 要“下沉”的父节点
    /// - Parameter length: 堆的有效大小
    class func downAdjust(_ list: inout [Int], parentIndex: Int, length: Int) {
        let temp = list[parentIndex]
        var childIndex = 2*parentIndex + 1
        var parentIndex = parentIndex;
        while childIndex < length {
            if childIndex + 1 < length, list[childIndex + 1] > list[childIndex] {
                //如果有右孩子，且右孩子大于左孩子的值，则定位到右孩子
                childIndex += 1
            }
            if temp >= list[childIndex] {
                // 如果父节点大于任何一个孩子的值，则直接跳出
                break
            }
            list[parentIndex] = list[childIndex]
            parentIndex = childIndex
            childIndex = 2*parentIndex + 1
        }
        list[parentIndex] = temp
    } 
    
    /// 堆排序,堆排序的关键点在于如何创建大顶堆，然后删除堆顶元素并再次将堆调整为大顶堆，再次删除堆顶元素，依次往复。
    class func heapSort(_ list: inout [Int]) {
        for i in (0...list.count/2).reversed() {
            //构建大顶堆
            downAdjust(&list, parentIndex: i, length: list.count - 1)
        }
        print("构建大顶堆\(list)")
        //循环删除堆顶元素，移到集合尾部，调整堆产生新的堆顶
        for i in (0 ..< list.count).reversed() {
            // 最后一个元素和第一个元素进行交换
            (list[i], list[0]) = (list[0], list[i])
            downAdjust(&list, parentIndex: 0, length: i)
        }
    }
    
    
}
