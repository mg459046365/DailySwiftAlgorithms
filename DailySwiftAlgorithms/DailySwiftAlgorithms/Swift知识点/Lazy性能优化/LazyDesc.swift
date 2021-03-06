//
//  LazyDesc.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/12.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class LazyDesc {
    // 如果一个lazyDesc的实例，在属性没有被初始化时就同时被多个线程访问，
    // 则无法保证该属性只被初始化一次，也就是说它是非线程安全的
    lazy var fileName: String = "data.text"

    static func test() {
        test1()
        test2()
    }

    static func test1() {
        let data = 1 ... 3
        let result = data.map { i -> Int in
            print("正在处理\(i)")
            return i * 2
        }
        print("准备访问结果")
        for i in result {
            print("遍历操作后的结果\(i)")
        }
        print("遍历完毕")
    }

    // 使用lazy优化
    // 对于那些不需要完全运行，可能提前退出的情况，使用 lazy 来进行性能优化效果会非常有效
    static func test2() {
        let data = 1 ... 3
        let result = data.lazy.map { i -> Int in
            print("lazy-正在处理\(i)")
            return i * 2
        }
        print("lazy-准备访问结果")
        for i in result {
            print("lazy-遍历操作后的结果\(i)")
        }
        print("lazy-遍历完毕")
    }

    // 自动闭包相关知识点，将某一个表达式封装成闭包，将返回该参数类型的闭包作为参数
    // 1. 自动闭包不支持有参数，必须是无参的
    // 2. 闭包会被延迟调用，只有在真正被调用时，才能执行。有利于非必须执行且运算开销较大的代码
    static func test3(closure: @autoclosure () -> Bool) -> Bool {
        return closure()
    }

    static func test4() {
        _ = test3(closure: 2 > 3)
    }
}
