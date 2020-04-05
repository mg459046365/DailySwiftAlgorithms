//
//  20190705.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/5.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Solution_20190705 {
    
    //MARK: - 有一个无序整型数组，如何求出该数组排序后的任意两个相邻元素的最大差值？要求时间和空间复杂度尽可能低。               例：2 6 3 4 5 10 9，排序后2 3 4 5 6 9 10，最大相邻差值为3（9 - 6 = 3）

    /**
     解法一：
     1. 利用计数排序的思想，先求出原数组中最大值max和最小值min的区间长度k(k = max - min + 1),以及偏移量d=min
     2. 创建一个长度为k的新数组Array
     3. 遍历原数组，每遍历一个元素，就把新数组Array对应小标的值+1
     4. 遍历新数组Array,统计出Array中最大连续出现0值的次数+1，即为相邻元素最大差值
     
     缺点： 如果数组只有三个元素，1，2，10000000，该方法会非常浪费空间
     
     */
    static func getMaxDvalue(_ list: [Int]) -> Int {
        guard list.count > 1 else { return 0 }
        if 2 == list.count {
            return list[1] - list[0]
        }
        var maxValue = list[0]
        var minValue = list[0]
        for item in list {
            maxValue = max(item, maxValue)
            minValue = min(item, minValue)
        }
        if maxValue == minValue {
            return 0
        }
        
        let k = maxValue - minValue + 1
        var array = Array(repeating: 0, count: k)
        for item in list {
            let index = item - minValue
            array[index] += 1
        }
        var curLeft = 0
        var curLength = 0
        
        var preLeft = 0
        var preLength = 0
        for i in 0 ..< array.count {
            
            if 0 == array[i] {
                if preLength > 0 {
                   preLength += 1
                }else{
                   preLeft = i
                   preLength += 1
                }
                continue
            }
            
            if preLength > 0 {
                curLeft = preLength > curLength ? preLeft : curLeft
                curLength = max(preLength, curLength)
                preLength = 0
            }
        }
        
        if 0 == curLeft, 0 == curLength {
            return 1
        }
        return curLength + 1
    }
    
    /**
     解法二： 是针对解法一的缺点的优化，利用桶排序的思想。
     1. 利用桶排序的思想，根据原数组的长度n，创建出n个桶，每一个桶代表一个区间范围。其中第一个桶从原数组的最小值min开始，区间跨度是(max - min)/(n-1)
     2. 遍历原数组，把原数组每一个元素插入到对应的桶中，记录每一个桶的最大和最小值
     3. 遍历所有的桶，统计出每一个桶的最大值，和这个桶右侧非空桶的最小值的差，数值最大的差即为原数组排序后的相邻最大差值
     
     */
    static func getMaxDvalue2(_ list: [Int]) -> Int {
        guard list.count > 1 else { return 0 }
        if 2 == list.count {
            return list[1] - list[0]
        }
        var maxValue = list[0]
        var minValue = list[0]
        for item in list {
            maxValue = max(item, maxValue)
            minValue = min(item, minValue)
        }
        let dif = maxValue - minValue
        if 0 == dif {
            return 0
        }
        
        //初始化桶
        let bucketNum = list.count
        var buckets = Array(repeating: Bucket(), count: bucketNum)
        //遍历原始数组，确定每个桶的最大最小值
        for item in list {
            //确定数组元素所归属的的桶下标
            let index = (item - minValue) * (bucketNum - 1)/(dif)
            if buckets[index].minVal == nil || buckets[index].minVal! > item {
                buckets[index].minVal = item
            }
            if buckets[index].maxVal == nil || buckets[index].maxVal! < item {
                buckets[index].maxVal = item
            }
        }
        
        //遍历桶，找到最大差值
        var leftMax = buckets[0].maxVal ?? 0
        var maxDistance = 0
        for bukect in buckets {
            guard let min = bukect.minVal else {
                continue
            }
            maxDistance = max(min - leftMax, maxDistance)
            leftMax = bukect.maxVal ?? 0
        }
        return maxDistance
    }
}

/// 桶
struct Bucket {
    var maxVal: Int?
    var minVal: Int?
}
