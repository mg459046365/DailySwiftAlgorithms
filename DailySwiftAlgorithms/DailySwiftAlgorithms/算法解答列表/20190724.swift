//
//  20190724.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/24.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Solution_20190724 {
    
    // MARK: - 给出一个正整数，找出这个正整数所有的数字全排列的下一个数。即在一个整数所包含数字的全部组合中，找到一个大于且仅大于原数的新整数。例如输入12345，则返回12354；输入12354，则返回12435。

    // 思路： 尽量保持高位不变，低位在最小的范围内变换顺序

    static func convertIntToList(_ number: Int) -> [Int] {
        let str = "\(number)"
        var list = [Int]()
        for ch in str {
            list.append(ch.wholeNumberValue ?? 0)
        }
        return list
    }

    static func findNearestNumber(_ number: Int) -> Int? {
        var list = convertIntToList(number)
        var pointIndex = 0
        // 从后向前查看逆序区域，找到逆序区域的前一位，也就是数字置换的边界。
        for i in (0 ..< list.count).reversed() {
            if list[i] > list[i - 1] {
                pointIndex = i
                break
            }
        }
        // 如果数字置换边界是0， 说明整个数已经是最大的数了，无法得到更大的数,返回nil
        if pointIndex == 0 {
            return nil
        }
        // 把逆序区域的前一位和逆序区域中大于它的所有的数字中的最小数字进行位置交换
        var neareatMaxIndex = 0
        for i in (pointIndex ..< list.count).reversed() {
            if list[pointIndex - 1] < list[i] {
                neareatMaxIndex = i
                break
            }
        }
        (list[pointIndex - 1], list[neareatMaxIndex]) = (list[neareatMaxIndex], list[pointIndex - 1])
        
        //把原来的逆序区域转为顺序
        var i = pointIndex
        var j = list.count - 1
        while i < j {
            (list[i], list[j]) = (list[j], list[i])
            i += 1
            j -= 1
        }
        var val = ""
        for va in list {
            val += "\(va)"
        }
        return Int(val)
    }

    /// 测试
    static func test() {
        let number = 12354
        let result = findNearestNumber(number)
        print((result != nil) ? "测试结果\(result!)" : "已经最大，无法得到更大的数")
    }
}
