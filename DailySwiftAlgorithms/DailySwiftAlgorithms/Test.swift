//
//  Test.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/6/2.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

func bubbleSort(_ list: inout [Int]) {
    guard list.count > 1 else {
        return
    }
    
    for i in 0 ..< list.count {
        for j in 0 ..< list.count - i - 1 {
            if list[j] > list[j+1] {
                (list[j], list[j+1]) = (list[j+1], list[j])
            }
        }
    }
}


func selectSort(_ list: inout [Int]) {
    guard list.count > 1 else {
        return
    }
    
    for i in 0 ..< list.count {
        var index = i
        for j in i+1 ..< list.count {
            if list[j] < list[index] {
                index = j
            }
        }
        if i != index {
            (list[i], list[index]) = (list[index], list[i])
        }
    }
}

func directInsertSort(_ list: inout [Int]) {
    
    guard list.count > 1 else {
        return
    }
    
    for i in 1 ..< list.count {
        for j in (0 ..< i - 1).reversed() {
            if list[j+1] < list[j] {
                (list[j+1], list[j]) = (list[j], list[j+1])
            }
        }
    }
}

func halfInserSort(_ list: inout [Int]) {
    
    guard list.count > 1 else {
        return
    }
    
    for i in 1 ..< list.count {
        var low = 0
        var hight = i-1
        while(low <= hight) {
            let mid = (hight - low)/2 + low
            if list[mid] > list[i] {
                hight = mid-1
            }else{
                low = mid+1
            }
        }
        
    }
    
    
    
}


