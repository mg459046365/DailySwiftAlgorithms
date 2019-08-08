//
//  20190807.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/8/7.
//  Copyright © 2019 Beryter. All rights reserved.
//

import Foundation

struct GoldMine {
    let gold: Int
    let worker: Int
}

struct Helper_20190807 {
    //MARK: - 很久很久以前，有一位国王拥有5座金矿，每座金矿的黄金储量不同，需要参与挖掘的工人人数不同。例如有的金矿储量是500kg黄金，需要有5工人来挖掘；有的金矿储量是200kg黄金，需要3工人来挖掘... 如果参与挖矿的工人总数是10。每座金矿要么全挖，要么不挖，不能派出一半人挖取一半的金矿。要求用程序求出，要想到的尽可能多的黄金，应该选择挖取哪几座金矿？                                                                                                          总共10人。金矿如下： 200kg(需3人)，300kg(需4人)，350kg(需3人)，400kg(需5人)，500kg(需5人)
    
    
    /// 开采金矿的最优收益
    ///
    /// 动态规划的问题，开采与不开采
    /// - Parameter worker: 可用工人数量
    /// - Parameter goldMines: 可选待开采的金矿集合
    static func getBestGold1(worker: Int, goldMines: [GoldMine]) -> Int {
        guard worker > 0 else { return 0 }
        guard !goldMines.isEmpty else { return 0 }
        
        var gms = goldMines
        let last = gms.last!
        let _ = gms.removeLast()
        if worker < last.worker {
            // 最后一座金矿开采所需工人大于可选工人数量
            return getBestGold1(worker: worker, goldMines: gms)
        }
        // 开采最后一座金矿的收益
        let selectLast = getBestGold1(worker: worker - last.worker, goldMines: gms) + last.gold
        // 不开采最后金矿的收益
        let unselectLast = getBestGold1(worker: worker, goldMines: gms)
        // 求出最佳的收益
        return max(selectLast, unselectLast)
    }
    
    
    /// 开采金矿的最优收益
    ///
    /// 动态规划，选择开采与不开采的
    /// 第一种方案采用了递归，时间复杂度O(n2)，且计算过程中会有重复计算。进一步优化
    /// - Parameter worker: 可用工人数量
    /// - Parameter goldMines: 可选待开采的金矿集合
    static func getBestGold2(worker: Int, goldMines: [GoldMine]) -> Int {
        //创建当前结果
        var result = Array(repeating: 0, count: worker+1)
        for i in 0 ..< goldMines.count {
            for j in stride(from: worker, through: 1, by: -1) {
                //当前金矿
                let gm = goldMines[i]
                if j >= gm.worker {
                    //可选人数大于当前金矿所需人数
                    //选择开采当前金矿与不开当前金矿的最优收益
                    result[j] = max(result[j], result[j - gm.worker] + gm.gold)
                }
            }
        }
        //返回最优收益
        return result.last!
    }
    
    
    
    
    /// 测试方法
    static func test() {
        let goldMines = [
            GoldMine(gold: 400, worker: 5),
            GoldMine(gold: 500, worker: 5),
            GoldMine(gold: 200, worker: 3),
            GoldMine(gold: 300, worker: 4),
            GoldMine(gold: 350, worker: 3)
        ]
        let worker = 10
        let gold = getBestGold1(worker: worker, goldMines: goldMines)
        let gold2 = getBestGold2(worker: worker, goldMines: goldMines)
        print("最优的收益为\(gold), 优化后方案\(gold2)")
    }
    
}
