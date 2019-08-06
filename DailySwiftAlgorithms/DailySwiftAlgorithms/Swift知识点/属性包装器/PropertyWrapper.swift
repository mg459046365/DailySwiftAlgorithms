//
//  PropertyWrapper.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/7/1.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation


/**
 当我们在一个类型中声明计算属性时，大部分属性的访问和获取都是有相同的用处，这些代码是可抽取的，如我们标记一些用户偏好设置，在计算属性的设置和获取中直接代理到 UserDefault的实现中，我们可以通过声明 @propertyWarpper 来修饰，可以减少大量重复代码。 在 SwiftUI中， @State @EnviromemntObject @bindingObject @Binding 都是通过属性包装器代理到 SwiftUI 框架中使其自动响应业务状态的变化。
 
 使用属性包装器的好处除了可以减少重复代码，Swift Runtime 还保证了以下几点：
 1.对于实例的属性包装器是即时加载的
 2.对于类属性的属性保证器是懒加载的
 3.属性包装器是线程安全的
 4.通过 $ 运算符可以获取到原始的属性包装器实例，这大量使用在 SwiftUI 的数据依赖中
 */
// before swift 5.0 ❎
struct User {
    static var usesTouchID: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "USES_TOUCH_ID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "USES_TOUCH_ID")
        }
    }
    static var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "LOGGED_IN")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "LOGGED_IN")
        }
    }
}
// after switft 5.1 ✅
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    //属性包装器支持自定义构造器
    init(_ key: String, defaultValue: T) {
        print("UserDefault init")
        self.key = key
        self.defaultValue = defaultValue
        UserDefaults.standard.register(defaults: [key: defaultValue])
    }
    var wrappedValue: T {
        get {
            print("getter")
            return UserDefaults.standard.object(forKey: key) as? T ??  defaultValue
        }
        set {
            print("setter")
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct User2 {
    @UserDefault("USES_TOUCH_ID", defaultValue: false)
    static var usesTouchID: Bool
    @UserDefault("LOGGED_IN", defaultValue: false)
    var isLoggedIn: Bool
    
}

class TestPropertyWrapper {
    func testFunc() {
        print("hello world")
        var user = User2()
        User2.usesTouchID = true
        user.isLoggedIn = true
    }
}
/**
///实际上属性包装器是在编译时期翻译为以下的代码, 并且编译器禁止使用 $ 开头的标识符。
struct User2 {
    static var $usesTouchID = UserDefault<Bool>("USES_TOUCH_ID", defaultValue: false)
    static var usesTouchID: Bool {
        set {
            $usesTouchID.value = newValue
        }
        get {
            $usesTouchID.value
        }
    }
    @UserDefault("LOGGED_IN", defaultValue: false)
    var isLoggedIn: Bool
}
*/


@propertyWrapper
struct LateInitialized<Value> {
    private var storage: Value?
    var wrappedValue: Value {
        get {
            guard let value = storage else { fatalError("value has not yet been set!") }
            return value
        }
        set {
            storage = newValue
        }
   }
}

//MARK: - struct中嵌套Class的拷贝问题（直接在struct中定义class类型的变量，struct拷贝时该class类型的变量是指针拷贝, 也就是浅复制）

protocol Copyable: AnyObject {
    func copy() -> Copyable
}

@propertyWrapper
struct CopyOnWrite<Value: Copyable> {
    private var store: Value
    
    init(wrappedValue: Value) {
        store = wrappedValue
    }
    
    var wrappedValue: Value {
        mutating get {
            if !isKnownUniquelyReferenced(&store) {
                store = store.copy() as! Value
            }
            return store
        }
        set {
            store = newValue
        }
    }
}

class CopyOnWriteTestModel: Copyable {
    var val: String = ""
    func copy() -> Copyable {
        let mode = CopyOnWriteTestModel()
        mode.val = val
        return mode
    }
}

struct PropertyWrapperTest {
    @LateInitialized var text: String
    /** 编译器会把属性代码展开，生成如下代码
     var $text: LateInitialized<String> = LateInitialized<String>()
     public var text: String {
     get { $text.value }
     set { $text.value = newValue }
     }
     */
    let pps = ["a", "b", "c"]
    var color: String
    @CopyOnWrite var model: CopyOnWriteTestModel
    
    func test() {
        let model = CopyOnWriteTestModel()
        model.val = "测试"
        let _ = PropertyWrapperTest(color: "sss", model: model)
    }
}



