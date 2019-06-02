//
//  FibonacciSequence.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/13.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

/// 斐波那契数列问题
/// 指的是这样一个数列：1、1、2、3、5、8、13、21、34、……在数学上，斐波纳契数列以如下被以递推的方法定义：F(1)=1，F(2)=1, F(n)=F(n-1)+F(n-2)（n>=3，n∈N*）
struct FibonacciSequence {
    
    /// 求第100个数字是多少
    static func Fib(_ n: Int) -> Int {
        var (prev, curr) = (0, 1)
        for _ in 1 ..< n {
            (prev, curr) = (curr, prev+curr)
        }
        return curr
    }
    
    static func Fib1(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        if n == 1 || n == 2 {
            return 1
        }
        return Fib(n - 1) + Fib(n - 2)
    }
    
    
    static func Fib2(_ n: Int) -> Int {
       
        var array = Array(repeating: 0, count: n)
        return Fib2Help(n, list: &array)
    }
    
    static func Fib2Help(_ n: Int, list: inout [Int] ) -> Int {
        
        guard n > 0 else {
            return 0
        }
        if n == 1 || n == 2 {
            return 1
        }
        
        if list[n - 1] != 0 {
            return list[n - 1]
        }
        if list[n-1] != 0 {
            return list[n-1]
        }
        
        list[n-1] = Fib2Help(n-1, list: &list) + Fib2Help(n-2, list: &list)
        return list[n-1]
    }
    
    
}
