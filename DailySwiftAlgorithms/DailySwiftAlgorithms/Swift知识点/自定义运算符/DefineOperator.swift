//
//  DefineOperator.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/18.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

infix operator **
func ** (x: Double, y: Double) -> Double {
    pow(x, y)
}
//Operator must be declared as 'prefix', 'postfix', or 'infix'
// 对于系统中没有的运算符，需要通过 operator 来定义操作符，prefix表示操作符应在参数的前面
// postfix表示操作符应在参数的后面
// 自定义一个中间运算符使用infix
