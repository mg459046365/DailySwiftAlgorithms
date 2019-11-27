//
//  SortUtils.swift
//  DailySwiftAlgorithms
//  七种算法的实现
//  Created by Beryter on 2019/3/12.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct SortUtils {
    /// 冒泡排序  O(n^2)
    /// 原理：比较相邻的元素。如果第一个比第二个大，就交换他们。
    /// 对每一对相邻元素做同样的操作,从开始第一对到结尾的最后一对。在这一点，最后的元素该会是最大的。
    /// 针对所有的元素重复以上的步骤，除了最后一个。
    /// 持续每次对越来越少的的元素重复上面的步骤，直到没有任何一对数字需要比较
    /// 优化点：当某次冒泡没有数据操作时，说明已经完全有序，可以停止冒泡操作了
    static func bubbleSort(_ list: inout [Int]) {
        guard list.count > 1 else {
            return
        }
        for i in 0 ..< list.count {
            var flag = false
            for j in 0 ..< list.count - i - 1 {
                if list[j] > list[j + 1] {
                    (list[j], list[j + 1]) = (list[j + 1], list[j])
                    // 表示有数据交换
                    flag = true
                }
            }
            if !flag {
                // 没有数据交换，已经完全有序，跳出循环
                break
            }
        }
    }

    /// 直接插入排序 O(n^2)
    /// 原理：将一个记录插入到已排好序的有序表中，从而得到一个新的、记录数增1的有序表
    /// 可以将第一个元素当做有序子表，从第二个元素开始进行插入操作
    /// 前n个元素是已经排好的子序列，所以在插入第n+1个元素时，只需要跟前n个元素比较就OK,倒序遍历前N个过程中，如果比它大
    /// 就交换他们的位置就OK了
    static func directInsertSort(_ list: inout [Int]) {
        guard list.count > 1 else {
            return
        }
        for i in 1 ..< list.count {
            for j in (0 ..< i).reversed() {
                // 当前遍历到的数比目标数大，后移
                if list[j] > list[j + 1] {
                    (list[j + 1], list[j]) = (list[j], list[j + 1])
                }
            }
        }
    }

    /// 折半插入排序 O(n^2)
    /// 是对直接插入排序的优化，关键点是对已经排好序的子序列进行折半
    static func halfInsertSort(_ list: inout [Int]) {
        guard list.count > 1 else {
            return
        }

        for i in 1 ..< list.count {
            var low = 0
            var hight = i - 1
            while low <= hight {
                let mid = (hight - low) / 2 + low
                if list[i] > list[mid] {
                    low = mid + 1
                } else {
                    hight = mid - 1
                }
            }
            if i != low {
                for i in (low ..< i).reversed() {
                    (list[i], list[i + 1]) = (list[i + 1], list[i])
                }
            }
        }
    }

    /// 选择排序  O(n^2)
    /// 原理：每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，
    /// 然后再从剩余未排序元素中继续寻找最小（大）元素，然后放到已排序序列的末尾。以此类推，直到全部待排序的数据元素排完。
    static func selectionSort(_ list: inout [Int]) {
        guard list.count > 1 else {
            return
        }
        for i in 0 ..< list.count {
            var minIndex = i
            for j in (i + 1) ..< list.count {
                if list[j] < list[minIndex] {
                    minIndex = j
                }
            }
            if minIndex != i {
                (list[minIndex], list[i]) = (list[i], list[minIndex])
            }
        }
    }

    /// 快速排序  O(nlogn)
    /// 原理：通过一趟排序将要排序的数据分割成独立的两部分，其中一部分的所有数据都比另外一部分的所有数据都要小，
    /// 然后再按此方法对这两部分数据分别进行快速排序，整个排序过程可以递归进行，以此达到整个数据变成有序序列。对冒泡排序的改进。
//    static func quickSort(_ list: [Int]) -> [Int]{
//
//        guard list.count > 1 else {
//            return list
//        }
//
//        /// 取中间的数作为参照
//        let value = list[list.count/2]
//        let left = list.filter { $0 < value }
//        let right = list.filter { $0 > value }
//        let middle = list.filter{ $0 == value}
    ////        let tmp = list[list.count/2]
    ////        var left = [Int]()
    ////        var mid = [Int]()
    ////        var right = [Int]()
    ////
    ////        for i in 0 ..< list.count {
    ////            if list[i] < tmp {
    ////                left.append(list[i])
    ////            }else if list[i] > tmp {
    ////                right.append(list[i])
    ////            }else{
    ////                mid.append(list[i])
    ////            }
    ////        }
//        return quickSort(left) + middle + quickSort(right)
//    }
//
    static func quickSort(_ list: inout [Int], startIndex: Int, endIndex: Int) {
        if list.count < 2 {
            return
        }
        if startIndex >= endIndex {
            return
        }
        // 双边循环法
        let cursor = quickSortHelper(&list, startIndex: startIndex, endIndex: endIndex)
        // 单边循环法
//        let cursor = quickSortHelper1(&list, startIndex: startIndex, endIndex: endIndex)
        quickSort(&list, startIndex: startIndex, endIndex: cursor - 1)
        quickSort(&list, startIndex: cursor + 1, endIndex: endIndex)
    }

    /// 快速排序双边循环法
    static func quickSortHelper(_ list: inout [Int], startIndex: Int, endIndex: Int) -> Int {
        let startValue = list[startIndex]
        var left = startIndex
        var right = endIndex

        while left < right {
            while left < right, list[right] > startValue {
                right -= 1
            }
            while left < right, list[left] <= startValue {
                left += 1
            }
            if left < right {
                (list[left], list[right]) = (list[right], list[left])
            }
        }
        (list[startIndex], list[left]) = (list[left], list[startIndex])
        return left
    }

    /// 快速排序单边循环法
    static func quickSortHelper1(_ list: inout [Int], startIndex: Int, endIndex: Int) -> Int {
        let startValue = list[startIndex]
        var markIndex = startIndex
        for index in startIndex ... endIndex {
            if list[index] < startValue {
                markIndex += 1
                (list[index], list[markIndex]) = (list[markIndex], list[index])
            }
        }
        (list[startIndex], list[markIndex]) = (list[markIndex], list[startIndex])
        return markIndex
    }

    /// 希尔排序 O(n^（1.3—2))
    /// 希尔排序是把记录按下标的一定增量分组，对每组使用直接插入排序算法排序；随着增量逐渐减少，
    /// 每组包含的关键词越来越多，当增量减至1时，整个文件恰被分成一组，算法便终止
    /// 增量可以gap = n/2开始，n为元素的个数，每次gap = gap/2递减，直到gap = 1的时候，直接来一次插入排序。
    static func shellSort(_ list: inout [Int]) {
        if list.count < 2 {
            return
        }
        var gap = list.count / 2
        while gap > 0 {
            for i in gap ..< list.count {
                var j = i
                while j >= gap && j < list.count {
                    if list[j] > list[j - gap] {
                        break
                    }
                    (list[j], list[j - gap]) = (list[j - gap], list[j])
                    j -= gap
                }
            }
            gap /= 2
        }
    }

    /// 堆排序    O(nlogn)
    /// 堆是一个近似完全二叉树的结构，并同时满足堆积的性质：即子结点的键值或索引总是小于（或者大于）它的父节点。
    /// 在堆的数据结构中，堆中的最大值总是位于根节点（大根堆）（在优先队列中使用堆的话堆中的最小值位于根节点，也叫小根堆）。
    /// 堆中定义以下几种操作：
    /// 最大堆调整（Max Heapify）：将堆的末端子节点作调整，使得子节点永远小于父节点
    /// 创建最大堆（Build Max Heap）：将堆中的所有数据重新排序
    /// 堆排序（HeapSort）：移除位在第一个数据的根节点，并做最大堆调整的递归运算 [1]
    /// 数组表示堆，元素索引为i,其父节点为(i-1)/2, 左子节点为2i+1, 右子节点为2i+2
    static func heapSort(_ list: inout [Int]) {
        // 从最后一个父节点开始调整
        for i in (0 ... list.count / 2 - 1).reversed() {
            heapSortHelp(&list, start: i, end: list.count - 1)
        }

        // 先将第一个元素和已经排好的元素前一位做交换，再重新调整，直到排序完毕
        for j in (1 ... list.count - 1).reversed() {
            (list[0], list[j]) = (list[j], list[0])
            heapSortHelp(&list, start: 0, end: j - 1)
        }
    }

    /// 建立堆
    static func heapSortHelp(_ list: inout [Int], start: Int, end: Int) {
        // 父节点索引，从0开始
        var superIndex = start
        // 左二子节点索引
        var childIndex = superIndex * 2 + 1
        while childIndex <= end {
            // 子节点索引在范围内
            if childIndex + 1 <= end && list[childIndex] < list[childIndex + 1] {
                // 先比较左右两个子节点大小，选择最大的
                childIndex += 1
            }
            if list[superIndex] > list[childIndex] {
                // 如果父节点大于子节点代表调整完毕，直接跳出函数
                return
            }

            // 交换父子内容，继续子节点和孙节点比较
            (list[superIndex], list[childIndex]) = (list[childIndex], list[superIndex])
            superIndex = childIndex
            childIndex = superIndex * 2 + 1
        }
    }

    /// 二分查找，如果找到返回索引,前提数组是有序的
    static func halfSearch(_ list: [Int], target: Int) -> Int? {
        guard list.count > 1 else {
            return nil
        }
        var start = 0
        var end = list.count
        var mid = 0
        while start <= end {
            // mid = (start+end)/2 - 1,当数组特别长时，start+end有可能会溢出。
            mid = (end - start) / 2 + start
            if list[mid] == target {
                return mid
            }
            if list[mid] > target {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        if list[mid] == target {
            return mid
        }
        return nil
    }

    /// 桶排序    O(n)
    /// 原理: 将数组分到有限数量的桶子里。
    /// 每个桶子再个别排序（有可能再使用别的排序算法或是以递归方式继续使用桶排序进行排序）。
    /// 桶排序是鸽巢排序的一种归纳结果。当要被排序的数组内的数值是均匀分配的时候，桶排序使用线性时间（Θ（n））
    static func bucketSort(_ list: [Int]) -> [Int] {
        // 得到数组中最大值和最小值，并算出差值
        var maxValue = list[0]
        var minValue = list[0]
        for value in list {
            maxValue = max(maxValue, value)
            minValue = min(minValue, value)
        }
        // 算差值
        let difValue = maxValue - minValue

        // 初始化桶,桶的个数为元素的个数
        var buckets = Array(repeating: [Int](), count: list.count)
        // 遍历原始数组，将每个元素放入桶中
        for value in list {
            let num = (value - minValue) * (list.count - 1) / difValue
            buckets[num].append(value)
        }
        var result = [Int]()
        for i in 0 ..< buckets.count {
            var lt = buckets[i]
            lt.sort()
            buckets[i] = lt
            result.append(contentsOf: lt)
        }
        return result
    }

    /// 计数排序，假设数组中存储的都是非负数
    static func countingSort(_ list: inout [Int]) {
        guard list.count > 2 else { return }
        var maxVal = list[0]
        // 求最大值
        list.forEach {
            maxVal = max(maxVal, $0)
        }
        // 申请计数数组
        var countList = Array(repeating: 0, count: maxVal + 1)
        list.forEach {
            // 计算每个元素的个数，放入计数数组中
            countList[$0] += 1
        }
        for i in 1 ..< countList.count {
            countList[i] = countList[i - 1] + countList[i]
        }
        // 临时数组，存储排序后的结果
        var tmp = Array(repeating: 0, count: list.count)
        // 计算排序的关键步骤
        for i in (0 ..< list.count).reversed() {
            let idx = countList[list[i]] - 1
            tmp[idx] = list[i]
            countList[list[i]] -= 1
        }
        for i in 0 ..< list.count {
            list[i] = tmp[i]
        }
    }
}
