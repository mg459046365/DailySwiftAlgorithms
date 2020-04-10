//
//  BlockTest.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/4/11.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

class BlockTest {
    var step = 100
    func testFunc() {
        print("1-step.address=\(UnsafeMutablePointer(&step))") // 1-step.address=0x000000011fd0ad90,属性step
        let incrementByOne = makeIncrementer(forIncrementer: 1)
        print("4-step.address=\(UnsafeMutablePointer(&step))") // 4-step.address=0x000000011fd0ad90，属性step
        _ = incrementByOne()
        _ = incrementByOne()
        _ = incrementByOne()
    }

    func makeIncrementer(forIncrementer amount: Int) -> () -> Int {
        var runningTotal = 0
        var margin = 100
        print("2-runningTotal.address=\(UnsafeMutablePointer(&runningTotal))") // 2-runningTotal.address=0x00000002819f68f0
        print("2-step.address=\(UnsafePointer(&step))") // 2-step.address=0x000000016fdd9a60, 属性step被拷贝了一份
        print("2-margin.address=\(UnsafePointer(&margin))") // 2-margin.address=0x00000002819f6910
        func incrementer() -> Int {
            runningTotal += amount + step + margin
            print("3-runningTotal.address=\(UnsafeMutablePointer(&runningTotal))") // 3-runningTotal.address=0x00000002819f68f0， 引用地址
            print("3-step.address=\(UnsafePointer(&step))") // 3-step.address=0x000000016fdd9a08， 属性step又被拷贝了一份
            print("3-margin.address=\(UnsafePointer(&margin))") // 3-margin.address=0x00000002819f6910，引用地址
            return runningTotal
        }
        return incrementer
    }
}
