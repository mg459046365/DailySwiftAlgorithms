//
//  20200302.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/2.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Solution_20200302 {
    /*
     题目： 请实现一个函数，把字符串中的每一个空格替换成“%20”。例如，输入“We are happy.”, 则输出“We%20are%20happy”.
     */

    /*
     思路：首先遍历原字符串，求出字符串中空格的个数，并由此可以算出最终所要得到的字符串的长度，并可以根据这个长度定义一个该长度的字符串(或者说是字符数组)。从字符串的末尾开始复制和替换。首先准备两个指针：P1和P2。P1指向原字符串的末尾，而P2指向替换后的字符串的末尾。
        然后开始向前移动P1的的位置，如果P1指向的该字符不是空格的话，则将该字符复制到结果字符串P2的位置(或者替换P2位置的字符，字符数组)，同时P1和P2都向前移动一个位置。如果P1指向的字符是空格的话，则将P2的位置的内容替换为“0”，向前移动P2，
     并将P2位置的内容替换为“2”，继续向前移动P2，并将P2位置的内容替换为“%”。此时将P2的位置移动一个位置。然后继续移动P1。如此往复，直到P1移动到字符串第一个位置。
     此方法时间复杂度为O(1)
     */

    static func replaceWhiteSpace(_ str: String) -> String {
        if str.isEmpty { return str }
        var spaceCount = 0
        str.forEach {
            if $0 == " " { spaceCount += 1 }
        }
        if spaceCount == 0 { return str }

        var list = Array(repeating: Character("0"), count: str.count + spaceCount * 2)
        var index = str.endIndex
        var resIndex = list.count - 1
        for _ in 0 ..< str.count {
            index = str.index(index, offsetBy: -1)
            if str[index] == " " {
                list[resIndex] = "0"
                list[resIndex - 1] = "2"
                list[resIndex - 2] = "%"
                resIndex = resIndex - 3
            } else {
                list[resIndex] = str[index]
                resIndex -= 1
            }
        }
        return String(list)
    }

    static func useSystemFunc(_ str: String) -> String {
        return str.replacingOccurrences(of: " ", with: "%20")
    }

    static func test() {
        let str = "We are happy."
        let res = replaceWhiteSpace(str)
        print("输出结果\(res)")
        var list = [1, 2, 3, 0, 0, 0]
        merge(list: [2, 5, 6], ac: 3, toList: &list, bc: 3)
    }
    
    /*
     题目：有两个排序的数组A1和A2,内存在A1的末尾有足够多的空余空间容纳A2.请实现一个函数,把A2中的所有数字插入到A1中，并且所有的的数字都是有序的。
     */
    /*
     思路：从尾到头逆序比较A1和A2中的数字，并把较大的数字复制到A1中合适的位置。时间复杂度O(m+n),空间复杂度为O(1)
     */
    static func merge(list a: [Int], ac: Int, toList b: inout [Int], bc: Int) {
        guard !a.isEmpty, ac > 0 else { return }
        var pa = ac - 1
        var pb = bc - 1
        var trail = ac + bc - 1
        while pa >= 0 || pb >= 0 {
            if pa == -1 {
                b[trail] = b[pb]
                pb -= 1
            }else if pb == -1 {
                b[trail] = a[pa]
                pa -= 1
            }else if a[pa] >= b[pb] {
                b[trail] = a[pa]
                pa -= 1
            }else{
                b[trail] = b[pb]
                pb -= 1
            }
            trail -= 1
        }
        print("合并的结果是\(b)")
    }
}
