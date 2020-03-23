//
//  Associatedtype.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/23.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

// associatedtype的作用简单来说就是protocol使用的泛型
protocol MyProtocol {
    associatedtype Element
    func push(_ e: Element)
    func pop() -> Element?
}

// 扩展协议，添加where限定语句
extension MyProtocol where Element == Int {
    func isInt() -> Bool {
        return true
    }
}

class IntList: MyProtocol {
    // 指定Element类型
    typealias Element = Int
    var list = [Element]()
    func push(_ e: Int) {
        list.append(e)
    }

    func pop() -> Int? {
        list.popLast()
    }
}

// 自动推断
class DoubleList: MyProtocol {
    var list = [Double]()
    func push(_ e: Double) {
        list.append(e)
    }

    func pop() -> Double? {
        list.popLast()
    }
}

// 使用泛型
class List<T>: MyProtocol {
    var list = [T]()
    func push(_ e: T) {
        list.append(e)
    }

    func pop() -> T? {
        list.popLast()
    }
}
