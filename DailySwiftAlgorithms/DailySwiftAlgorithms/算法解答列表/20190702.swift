//
//  20190702.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/2.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Solution_20190702 {
    
    //MARK: - 题目： 写一段代码，求出两个整数的最大公约数，要尽量优化算法的性。
    
    
    /// 采用辗转相除法，即欧几里得算法。两个正整数a和b(a>b)，他们的最大公约数等于a除以b的y余数c和b之间的最大公约数。
    /// 使用递归
    /// 当两个整数较大时，a%b取模运算的性能比较差
    /// - Parameter a: 参数
    /// - Parameter b: 参数
    static func getGreatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        let big = max(a, b)
        let small = min(a, b)
        if 0 == big % small {
            return small
        }
        return getGreatestCommonDivisor(small, big%small)
    }
    
    
    /// 更相减损法
    /// 原理：两个正整数a和b(a>b),他们的最大的公约数等于a-b的差值c,和较小数b的最大公约数
    /// 递归处理
    /// 当两个数相差悬殊时，递归运算次数比较多
    static func getGCD(_ a: Int, _ b: Int) -> Int {
        if a == b {
            return a
        }
        let big = max(a, b)
        let small = min(a, b)
        return getGCD(big - small, small)
    }
    
    /// 辗转相除法和更相减损法相结合，在更相减损法的基础上使用以为运算，实现最优方法.求最大公约数的方法暂时简称为gcd，方便表述。
    /// 当a和b均为偶数时，gcd(a,b) = 2*gcd(a/2, b/2) = 2*gcd(a>>1, b>>1)
    /// 当a为偶数，b为奇数时，gcd(a, b) = gcd(a/2, b) = gcd(a>>1, b)
    /// 当a为奇数，b为偶数时，gcd(a, b) = gcd(a, b/2) = gcd(a, b>>1)
    /// 当a和b都为奇数时，先利用更相减损法运算一次，gcd(a, b)= gcd(a-b, b), 此时a-b一定为偶数，然后再次利用移位运算
    static func bestGetGCD(_ a: Int, _ b: Int) -> Int {
        if a == b {
            return a
        }
        if a&1 == 0, b&1 == 0 {
            //a,b均为偶数
            return bestGetGCD(a>>1, b>>1)<<1
        }
        if a&1 == 0, b&1 != 0 {
            //a为偶数，b为奇数
            return bestGetGCD(a>>1, b)
        }
        if a&1 != 0, b&1 == 0 {
            //a为奇数，b为偶数
            return bestGetGCD(a, b>>1)
        }
        //a,b都为奇数
        return bestGetGCD(max(a, b) - min(a, b), min(a, b))
    }
    
}
