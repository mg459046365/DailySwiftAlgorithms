//
//  20200225.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/2/25.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Helper_20200225 {
    /*
     题目： 在一个二维数组中，每一行都按照从左到右递增的顺序排序，每一列都按照从上到下递增的顺序排序。
     请完成一个函数，输入这样的一个二维数组和一个整数，判断数组中是否含有该整数。
     */
    /*
     思路：将二维数组画成矩形，首先选取数组中的右上角的数字。如果该数字等于要查找的数字，则查找结束；如果该数字大于要查找的数字，则剔除该数字所在的列表；
     如果该数字小于要查找的数，则剔除该数字所在的行。然后继续从剔除以后范围内的二维数组的右上角重复查找，直到找到要查找的数字或者查找范围为空。
     */

    /*
     1    2    8    9
     2    4    9    12
     4    7    10   13
     6    8    11   15
     */
    // [[1, 2, 8, 9], [2, 4, 9, 12], [4, 7, 10, 13], [6, 8, 11, 15]]
    static func numInList(list: [[Int]], num: Int) -> Bool {
        guard !list.isEmpty else { return false }
        let fl = list[0]
        guard !fl.isEmpty else { return false }
        let ll = list[list.count - 1]
        if num < fl[0] || num > ll[ll.count - 1] { return false }
        // 第几行
        var row = 0
        // 第几列
        var column = fl.count - 1
        // 从右上角开始查找
        while row < list.count, column >= 0 {
            if list[row][column] == num {
                return true
            } else if list[row][column] > num {
                column -= 1
            } else {
                row += 1
            }
        }
        return false
    }
}
