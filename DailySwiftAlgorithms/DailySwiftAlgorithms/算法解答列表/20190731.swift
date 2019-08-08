//
//  20190731.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/30.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Helper_20190731 {
    //MARK: - 给出两个很大的整数，要求实现程序求出两个整数之和。注意，两个整数的和有可能会超出整型的范围而溢出。
    
    
    /// 求两个很大的整数之和
    ///
    ///  讲两个整数分别按位放入数组中，然后按位相加，注意低位进位的处理
    /// - Parameter num1: 参与计算的整数
    /// - Parameter num2: 参与计算整数
    
    static func addBigNumber(_ num1: String, _ num2: String) -> String {
        let str1 = num1.count >= num2.count ? num1 : num2
        var str2 = num1.count < num2.count ? num1 : num2
        
        for _ in 0 ..< str1.count - str2.count {
            // 高位补0
            str2 = "0" + str2
        }
        
        let chars1 = str1.reversed()
        let chars2 = str2.reversed()
        var result = ""
        /// 进位
        var carryVal = 0
        for i in 0 ..< chars1.count {
            let index = chars1.index(chars1.startIndex, offsetBy: i)
            let val1 = Int(String(chars1[index]))!
            let val2 = Int(String(chars2[index]))!
            let res = val1 + val2 + carryVal
            result = "\(res >= 10 ? res - 10 : res)" + result
            carryVal = res >= 10 ? 1 : 0
        }
        if 1 == carryVal {
            result = "1" + result
        }
        return result
    }
    
    
    /// 求两个很大的整数之和，优化算法
    ///
    /// Int的类型的取值范围是 -2147483648 ~ 2147483647，最多可以由10位整数。为了防止溢出，
    /// 我们可以把最大的整数的每9位作为数组的一个元素，进行加法。然后将得到的元素进行拼接成字符串。
    /// 注意相加过程中的进位的处理。
    /// - Parameter num1: 数字1
    /// - Parameter num2: 数字2
    static func addBigNumberOptimize(_ num1: String, _ num2: String) -> String {
        var str1 = num1.count >= num2.count ? num1 : num2
        var str2 = num1.count < num2.count ? num1 : num2
        
        if str1.count < 10 {
            return "\(Int(str1)! + Int(str2)!)"
        }
        
        for _ in 0 ..< str1.count - str2.count {
            // 高位补0
            str2 = "0" + str2
        }
        
        let addZeroByNineCount = 9 - str1.count%9
        for _ in 0 ..< addZeroByNineCount {
            str1 = "0" + str1
            str2 = "0" + str2
        }
        var res = ""
        var carryVal = 0
        var i = str1.count
        var startIndex = str1.index(before: str1.endIndex)
        let max = 1000000000
        while i > 0 {
            let index = str1.index(startIndex, offsetBy: -min(8, i) )
            let str1 = String(str1[index ... startIndex])
            let str2 = String(str2[index ... startIndex])
            let val1 = Int(str1)!
            let val2 = Int(str2)!
            let addRes = val1 + val2 + carryVal
            if addRes >= max {
                res = "\(addRes - max)" + res
                carryVal = 1
            }else{
                res = "\(addRes)" + res
                carryVal = 0
            }
            i -= 9
            if i > 0 {
                startIndex = str1.index(before: index)
            }
        }
        if carryVal == 1 {
            res = "1" + res
        }
        return res
    }
    
    /// 测试方法
    static func test() {
        let num1 = "426709752318"
        let num2 = "95481253129"
        let res1 = Helper_20190731.addBigNumber(num1, num2)
        let res2 = Helper_20190731.addBigNumberOptimize(num1, num2)
        print("测试求值结果\(res1),\(res2)")
    }
    
}
