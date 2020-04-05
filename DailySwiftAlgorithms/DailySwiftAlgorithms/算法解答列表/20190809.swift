//
//  20190809.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/8/9.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct Solution_20190809 {
    // MARK: - 在一个无序数组里有99个不重复的正整数，范围为1-100，唯独缺少1个1-100中的整数。如何找出这个缺失的整数。

    /// 创建一个Hash表，以1-100这个100个整数位key。然后遍历整个数组，每读到一个整数，就定位到Hash表中对应的key，然后删除该key。
    /// 最后剩下的key就是缺失的整数。
    /// 时间复杂度是O(1)，空间复杂度O(n)
    ///
    /// - Parameter list: 数组
    static func findMissNumber1(_ list: [Int]) -> Int {
        var hash = [Int: Int]()
        for i in 1 ... 100 {
            hash[i] = i
        }
        for i in list {
            hash[i] = nil
        }
        var num = 0
        for i in hash.values {
            num = i
            break
        }
        return num
    }

    /// 先把数组元素按照从小到大的顺序排序，然后遍历数组，如果相邻两个元素不连续，说明缺少的整数是这两个数中间的那个数
    /// 时间复杂度是(利用O(nlogn)的算法)O(nlogn)，空间复杂度O(1)
    ///
    /// - Parameter list: 数组
    static func findMissNumber2(_ list: [Int]) -> Int {
        let l = list.sorted()
        var num = 0
        for i in 1 ..< l.count {
            if list[i] - list[i - 1] != 1 {
                num = list[i] - 1
                break
            }
        }
        return num
    }

    /// 算出1-100所有数的和，然后依次减去数组中的数。最后的差值就是缺失的整数。
    /// 时间复杂度是O(n)，空间复杂度O(1)
    ///
    /// - Parameter list: 数组
    static func findMissNumber3(_ list: [Int]) -> Int {
        var num = 0
        for i in 0 ..< list.count {
            num += (i + 1)
            num -= list[i]
        }
        num += 100
        return num
    }
    
    
    //MARK: - 一个无序数组里有若干个正整数，范围是1-100，其中99个整数都出现了偶数次，只有一个整数出现了奇数次，如何找到这个出现奇数次的整数。
    
    ///求奇数次的整数
    ///
    /// 思路核心思想： 异或运算。相同位得0，不同位得1。
    /// 遍历整个数组，依次异或运算，由于异或运算在进行位运算时，相同为0，不同为1，因此所有出现偶数次的整数都会相互抵消变成0，只有唯一出现奇数次的整数
    /// 会被留下
    ///  时间复杂度为0(n)，空间复杂度为O(1)
    /// - Parameter list: 整数列表
    static func findOddTimeNumber(_ list: [Int]) -> Int {
        var num = list[0]
        for i in 1 ..< list.count {
            num = num ^ list[i]
        }
        return num
    }
    
    
    //MARK: - 假设一个无序数组里有若干个正整数，范围是1-100，其中有98个整数出现了偶数次，只有两个整数出现了奇数次，如何找到这2个出现奇数次的整数呢。
    
    /// 遍历整个数组，并依次做异或运算，进行异或运算的最终结果，便是两个出现奇数次的整数异或运算的结果A。
    /// A中至少有一个二进制位为1。从低位开始一次查看A的每一位，当遇到第一个为1的位(假设为位B)时，则说明这两个出现奇数次的数，在该位一个是1一个是0。
    /// 可以根据上述描述的情况，对该数组分成两组，一组中的数字位B都为1，另一组的整数的位B都是0
    /// 如此将两个奇数次的整数分别分配到了两个不同的数组中，然后两个数组的元素分别依次进行异或运算，分别求出数组中的奇数次整数。
    ///
    /// - Parameter list: 整数列表
    static func findOddTimeNumbers(_ list: [Int]) -> (Int, Int)? {
        
        var xorAll = list[0]
        for i in 1 ..< list.count {
            //对所有的数据进行异或
            xorAll = xorAll ^ list[i]
        }
        
        if xorAll == 0 {
            return nil
        }
        
        //通过移位运算确定位数值为1的数
        var sep = 1
        while xorAll & sep == 0 {
            sep = sep<<1
        }
        
        // 开始分组,进行异或运算
        // 创建一个tuple，第一个数表示该位置为0的数，第二个表示该位置为1的数
        var tup: (zero: Int, one: Int) = (0, 0)
        for num in list {
            if 0 == num&sep {
                tup.0 = tup.0^num
            }else{
                tup.1 = tup.1^num
            }
        }
        return tup
    }
    
    
    
    /// 测试方法
    static func test() {
        var list = [Int]()
        // 指定缺失的数为56
        let missNum = 56
        for i in 1 ... 100 {
            // 生成一个包含99个整数的数组，
            if i == missNum { continue }
            list.append(i)
        }

        let res1 = findMissNumber1(list)
        let res2 = findMissNumber2(list)
        let res3 = findMissNumber3(list)
        print("算法1得到的结果：\(res1)")
        print("算法2得到的结果：\(res2)")
        print("算法3得到的结果：\(res3)")
        
        
        list = [3, 1, 3, 2, 4, 1, 4]
        let res4 = findOddTimeNumber(list)
        print("出现奇数次的数为：\(res4)")
        list = [4, 1, 2, 2, 5, 1, 4, 3]
        let res5 = findOddTimeNumbers(list)
        if let tup = res5 {
            print("出现奇数次的数为：\(tup.0), \(tup.1)")
        }else{
            print("数据中不存在两个都是奇数次出现的整数")
        }
        
    }
}
