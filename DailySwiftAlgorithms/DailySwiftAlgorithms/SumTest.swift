//
//  SumTest.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/3/28.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation
class NumArray {
    let nums: [Int]
    
    init(_ nums: [Int]) {
        self.nums = nums
    }
    
    func sumRange(_ i: Int, _ j: Int) -> Int {
        if i == j {
            return self.nums[i]
        }
//        var sums = [Int]()
        
        var l = i
        var r = j
        var sum = 0
        while l < r {
            sum += self.nums[l] + self.nums[j]
            l += 1
            r -= 1
        }
        sum += self.nums[l]
        return sum
//
//        for k in 0 ... j {
//            if k == 0 {
//                sums.append(self.nums[k])
//            }else{
//                sums.append(sums.last! + self.nums[k])
//            }
//        }
//        if i == 0 {
//            return sums.last!
//        }
//        return sums.last! - sums[i - 1]
    }
}

