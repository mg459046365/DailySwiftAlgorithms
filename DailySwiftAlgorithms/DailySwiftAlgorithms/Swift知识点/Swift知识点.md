1. API&ABI

   1. API(Application Programming Interface)应用程序编程接口。

      源代码与库之间的接口

   2. ABI(Application Binary Interface)

      应用程序二进制接口。应用程序与操作系统之间的底层接口。

      涉及的内容有目标内容格式、数据类型的大小、布局、对齐、函数调用约定等。

2. 数据类型

   1. `Optional`可选是基于枚举enum实现的，本质上是enum。
   2. Bool、Int、Float、Double、Character、String、Array、Dictionary、Set是基于结构体Struct实现的，本质上都是结构体。
   3. Class类引用类型。函数和闭包都是引用类型。
   4. Tuples元组，复合类型。Void是空元组，定义：**`public typealias Void = ()`**

3. 函数重载

   函数名相同，参数不同(个数、类型、标签)。swift中，函数由函数名，参数个数，参数类型，标签类型，返回值功能决定

4. 内联函数&宏定义

   内联函数代码被插入到调用者代码处的函数，可以理解代码被拷贝到调用得地方。没有了函数调用的上下文切换，提高性能。宏定义仅仅是字符串的替换。宏定义由预处理器对宏进行替代，而内联函数则是通过编译器控制来实现。内联函数会检查参数类型和返回值类型，宏定义不检查函数参数和返回值

5. **MemoryLayout**

   可以使用MemoryLayout获取数据类型占用的内存大小

   MemoryLayout<Int>.size, 类型实际使用的大小

   MemoryLayout<Int>.stride, 类型分配的内存空间大小

   MemoryLayout<Int>.alignment，类型的内存对齐

   ```swift
   let age = 10
   MemoryLayout.size(ofValue: age)       //8
   MemoryLayout.stride(ofValue: age)     //8
   MemoryLayout.alignment(ofValue: age)  //8
   ```

6. Optional可选类型

   本质是枚举类型enum。some,none。

   1. 可选绑定，if let 

   2. 显式解绑，隐式解绑(强制解绑,叹号!)

   3. 多重可选项。打断点，控制台，输入fr v -R(或者frame variable -R)

      ```swift
      var num1: Int? = nil
      var num2: Int?? = 10
      var num3: Int?? = nil
      let a = (num2 ?? 1) ?? 2
      let b = (num3 ?? 1) ?? 3
      //a = 10，b = 1
      //fr v -R num1
      (Swift.Optional<Swift.Int>) num1 = none {
        some = {
          _value = 0
        }
      }
      //fr v -R num2
      (Swift.Optional<Swift.Optional<Swift.Int>>) num2 = some {
        some = some {
          some = {
            _value = 10
          }
        }
      }
      //fr v -R num3
      (Swift.Optional<Swift.Optional<Swift.Int>>) num3 = none {
        some = some {
          some = {
            _value = 0
          }
        }
      }
      ```

7. 字节对齐

   1. 各成员变量存放的起始地址相对于结构的起始地址的偏移量必须为该变量的类型所占用的字节数的倍数 

   2. 各成员变量在存放的时候根据在结构中出现的顺序依次申请空间 

   3. 同时按照上面的对齐方式调整位置 空缺的字节自动填充 同时为了确保结构的大小为结构的字节边界数(即该结构中占用最大的空间的类型的字节数)的倍数，所以在为最后一个成员变量申请空间后 还会根据需要自动填充空缺的字节

      

8. 结构体逐一构造器。

   如果没有定义任何自定义构造器，它们将自动获得一个逐一成员构造器。不像默认构造器，即使存储属性没有默认值，结构体也能获得逐一构造器。

   如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器。

   

9. 对象的堆空间申请流程

   ```swift
   Class._allocating_init()
   libswiftCore.dylib:swift_allocObject
   libswiftCore.dylib:swift_slowAlloc
   libsystem_malloc.dylib:malloc
   ```

   malloc函数分配的内存大小总是16的倍数

10. 方法不占用对象的内存。方法的本质就是函数。函数都放在代码段。

11. 闭包。

    闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为*包裹*常量和变量。 Swift 会为你管理在捕获过程中涉及到的所有内存操作。

    **全局和嵌套函数实际上也是特殊的闭包。**

    * 全局函数是一个有名字但不会捕获任何值得闭包
    * 嵌套函数是一个有名字并可以捕获其封闭函数域内值得闭包
    * 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值得匿名闭包

    为了优化，如果一个值不会被闭包改变，或者在闭包创建后不会改变，Swift 可能会改为捕获并保存一份对值的拷贝。

    Swift 也会负责被捕获变量的所有内存管理工作，包括释放不再需要的变量.函数和闭包都是引用类型

12. 自动闭包

    *自动闭包*是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。自动闭包让你能够延迟求值。

13. static let shared = Class()定义单例，之所以能够保证线程安全，是因为底层调用了swift_once，也就是调用了GCD中的dispatch_once.

    static修饰的指针指向的内存会不会释放，需要看他指向的内存在什么位置，static只是将这个指针全局化，而不是将指针指向的内存全局化，不过如果是单例，那么内容也是全局化的。

14. 对象的类型信息存储在内存中的全局区。

15. Swift中KVO，观察者与被观察者必须继承自NSObject类，且被观察的属性必须是添加@objc修饰符。KVO运用到了OC运行时，所以需要添加@objc暴露给OC.

16. infix 双目运算符自定义的关键字,详见工程中自定义运算符文件夹。

    ```swift
    infix operator **
    func **(x: Double, y: Double) -> Double {
       return pow(x, y)
    }
    ```


17. SEL/IMP/Method

    SEL: 定义**`typedef struct objc_selector *SEL`**,objc_selector其实就是字符串。

    selector方法选择器，表示方法名，或者方法的唯一标志符。

    IMP: 定义**`typedef id (*IMP)(id, SEL, ...)`**,方法的具体实现，method implementation,内存中，指针指向所在地址块的首地址，方法的具体地址。

    Method: 定义**`typedef struct objc_method *Method`**

    ```c
    struct objc_method {
        SEL method_name;
        char *method_types;
        IMP method_imp;
    }
    ```

    Method = SEL + IMP + 方法类型

18. 