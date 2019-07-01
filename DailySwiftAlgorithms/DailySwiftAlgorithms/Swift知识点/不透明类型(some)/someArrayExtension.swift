//
//  someArrayExtension.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/1.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
import UIKit

protocol Container {
    associatedtype Item
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
}

extension Array: Container {}

struct TestArray {
    
    /**
     在 Swift 5.0 之前我们如果想返回抽象类型一般使用 Generic Type 或者 Protocol, 使用泛型会显示的暴露一些信息给 API 使用者，不是完整的类型抽象。 但是使用 Protocol 也有几个限制: 泛型返回值在运行时都是一个容器，效率较差，返回值不能调用自身类型的方法，协议不允许拥有关联类型，由于编译时丢失了类型信息，编译器无法推断类型，导致无法使用 == 运算符。
     在 Swift 5.1 中新增了 opaque result type，这个特性使用 some 修饰协议返回值，具有以下特性：
     
     1.所有的条件分支只能返回一个特定类型，不同则会编译报错
     
     2.方法使用者依旧无法知道类型，（使用方不透明）
     
     3.编译器知情具体类型，因此可以使用类型推断
     */
    
    /**
    /// 虽然数组实现了协议，该方法编译报错，
    func makeProtocolContainer<T>(item: T) -> Container {
        return [item]
    }
    /// 虽然数组实现了协议，该方法编译报错，
    func makeProtocolContainer<T, C: Container>(item: T) -> C {
        return [item]
    }
    */
    
    /// 使用不透明类型，不会报错
    @available(iOS 13.0.0, *)
    func makeOpaqueContainer<T>(item: T) -> some Container {
        return [item]
    }
}

/// 另一种例子
public protocol SomeResultProtocol where Self: UIView {
    associatedtype Body: UIView
    var body: Self.Body { get }
}

extension UILabel: SomeResultProtocol {
    public typealias Body = UILabel
    public var body: UILabel {
        return UILabel()
    }
    
    
}
extension UIButton: SomeResultProtocol {
    public typealias Body = UIButton
    public var body: UIButton {
        return UIButton(type: .custom)
    }
}

// after switft 5.1 ✅
@available(iOS 13.0.0, *)
class ContentView:UIView, SomeResultProtocol {
    
    var body: some SomeResultProtocol {
        UILabel()
    }
}
