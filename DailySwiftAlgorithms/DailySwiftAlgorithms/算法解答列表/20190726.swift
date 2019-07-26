//
//  20190726.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/26.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Helper_20190726 {
    // MARK: - 给出一个整数，从该整数中去掉K个数字，要求剩下的数字形成的新整数尽可能小。应该如何选取北被去掉的整数？其中整数的长度大于或等于K，给出的整数的大小可以超过long类型的数字范围。

    /// 删除整数的K个整数，获得删除后的最小值。运用栈的特性实现。
    /// - Parameter number: 被处理的数字的字符串
    /// - Parameter count: 需要删除的数字的个数
    static func minIntValueWithRemoveDigits(number: String, removeCount count: Int) -> String {
        if number.isEmpty || count >= number.count {
            return "0"
        }
        // 辅助的栈
        var helperStack = [String]()
        var hasRemoveCount = 0
        var left = 0
        var i = 0
        
        while i < number.count {
            let val = String(number[number.index(number.startIndex, offsetBy: i)])
            
            //依次将栈中大于该数的数出栈，也就是要删除的数字。直到删除到指定的个数
            while !helperStack.isEmpty, Int(helperStack.last!)! > Int(val)!, hasRemoveCount != count {
                helperStack.removeLast()
                hasRemoveCount += 1
            }
            
            helperStack.append(val)
            if hasRemoveCount == count {
                left = i + 1
                break
            }
            i += 1
        }
        
        // 找到栈中第一个非0的数字构建新的字符串
        var start: Int?
        for i in 0 ..< helperStack.count {
            if Int(helperStack[i])! != 0 {
                start = i
                break
            }
        }
        var res = ""
        if start != nil {
            for i in start! ..< helperStack.count {
                res += helperStack[i]
            }
        }
        if left >= number.count { return res }
        let index = number.index(number.startIndex, offsetBy: left)
        res += String(number[index ..< number.endIndex])
        return res
    }
}
