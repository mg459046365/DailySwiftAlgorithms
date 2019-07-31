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
    
}
