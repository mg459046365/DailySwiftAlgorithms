//
//  20190809.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/8/9.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Helper_20190809 {
    // MARK: - 在一个无序数组里有99个不重复的正整数，范围为1-100，唯独缺少1个1-100中的整数。如何找出这个缺失的整数。

    /// 创建一个Hash表，以1-100这个100个整数位key。然后遍历整个数组，每读到一个整数，就定位到Hash表中对应的key，然后删除该key。
    /// 最后剩下的key就是缺失的整数。
    /// 时间复杂度是O(1)，空间复杂度O(n)
    ///
    /// - Parameter list: 数组
    static func findMissNumber1(_ list: [Int]) -> Int {
        var hash = [Int: Int]()
        for i in 1 ... 100 {
            hash[i] = i
        }
        for i in list {
            hash[i] = nil
        }
        var num = 0
        for i in hash.values {
            num = i
            break
        }
        return num
    }

    /// 先把数组元素按照从小到大的顺序排序，然后遍历数组，如果相邻两个元素不连续，说明缺少的整数是这两个数中间的那个数
    /// 时间复杂度是(利用O(nlogn)的算法)O(nlogn)，空间复杂度O(1)
    ///
    /// - Parameter list: 数组
    static func findMissNumber2(_ list: [Int]) -> Int {
        let l = list.sorted()
        var num = 0
        for i in 1 ..< l.count {
            if list[i] - list[i - 1] != 1 {
                num = list[i] - 1
                break
            }
        }
        return num
    }

    /// 算出1-100所有数的和，然后依次减去数组中的数。最后的差值就是缺失的整数。
    /// 时间复杂度是O(n)，空间复杂度O(1)
    ///
    /// - Parameter list: 数组
    static func findMissNumber3(_ list: [Int]) -> Int {
        var num = 0
        for i in 0 ..< list.count {
            num += (i + 1)
            num -= list[i]
        }
        num += 100
        return num
    }
    
    /// 测试方法
    static func test() {
        var list = [Int]()
        // 指定缺失的数为56
        let missNum = 56
        for i in 1 ... 100 {
            // 生成一个包含99个整数的数组，
            if i == missNum { continue }
            list.append(i)
        }

        let res1 = findMissNumber1(list)
        let res2 = findMissNumber2(list)
        let res3 = findMissNumber3(list)
        print("算法1得到的结果=\(res1)")
        print("算法2得到的结果=\(res2)")
        print("算法3得到的结果=\(res3)")
    }
}
