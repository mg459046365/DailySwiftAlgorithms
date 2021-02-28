//
//  SwiftLoad.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/2/28.
//  Copyright © 2021 Beryter. All rights reserved.
//

// swift1.2开始：class继承NSObjec也无法使用load。但swift代码中initialze可以被重写，也可以用OC的category方式添加load/initialze方法
// swift4.2开始：swift代码class 的initialze也不能被重写了，但可以用OC的category方式添加load/initialze方法
// swift5开始：swift的class只能用OC代码的category添加initialze。

// 方案： 通过runtime遍历类类列表找到对应遵从协议的类，并调用

import Foundation
import UIKit

protocol SelfAware: AnyObject {
    static func awake()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyObject>.allocate(capacity: typeCount)
        let safeTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(safeTypes, Int32(typeCount))
        for i in 0 ..< typeCount {
            (types[i] as? SelfAware.Type)?.awake()
        }
        types.deinitialize(count: typeCount)
    }
}

extension UIApplication {
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()

    override open var next: UIResponder? {
        // UIApplication的下一个Responder是AppDelegate，因而下面这句代码会在 applicationDidFinishLaunching之前调用
        UIApplication.runOnce
        return super.next
    }
}
