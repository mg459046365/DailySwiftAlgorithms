//
//  Util.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/12.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import Foundation

struct Util {
    
    /// 交换两个同类型变量的值
    ///
    /// - Parameters:
    ///   - p: 变量
    ///   - q: 变量
    static func swap<T>(_ p: inout T, _ q: inout T) {
        (p, q) = (q, p)
    }
    
    /// 反转数组中的元素。
    /// 若是反转字符串，可以先反转字符数组，输出字符串。
    /// - Parameters:
    ///   - chars: 数组
    static func reverse<T>(_ chars: inout [T]) {
        if chars.isEmpty {
            return
        }
        if chars.count == 1 {
            return
        }
        var start = 0
        var end = chars.count - 1
        while start < end {
//            chars.swapAt(start, end)
            (chars[start], chars[end]) = (chars[end], chars[start])
            start += 1
            end -= 1
        }
    }
}
