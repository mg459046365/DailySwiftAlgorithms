//
//  20200321.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2020/3/21.
//  Copyright © 2020 Beryter. All rights reserved.
//

import Foundation

struct Helper_20200321 {
    // 题目： 请设计一个函数，用来判断在一个矩阵中是否存在一条包含某字符串所有字符的路径。
    // 路径可以从矩阵中的任意一格开始，每一步可以在矩阵中向左、右、上、下移动一格。
    // 如果一条路径经过了矩阵的某一格，那么该路径不能再次进入该格子。
    // 例如，在下面的3×4的矩阵中包含一条字符串“bfce”的路径（路径中的字母用加粗标出）。
    // [["a","b","c","e"],
    // ["s","f","c","s"],
    // ["a","d","e","e"]]
    // 但矩阵中不包含字符串“abfb”的路径，因为字符串的第一个字符b占据了矩阵中的第一行第二个格子之后，路径不能再次进入这个格子。

    // 思路：https://leetcode-cn.com/problems/ju-zhen-zhong-de-lu-jing-lcof/solution/mian-shi-ti-12-ju-zhen-zhong-de-lu-jing-shen-du-yo/
    static func exist(_ board: [[Character]], _ word: String) -> Bool {
        if board.isEmpty { return false }
        // 从矩阵左上角第一个字符开始查找
        for i in 0 ..< board.count {
            for j in 0 ..< board[0].count {
                let res = dfs(board, word: word, row: i, column: j, idx: 0)
                if res {
                    return true
                }
            }
        }
        return false
    }

    /// 查找指定位置字符
    /// - Parameters:
    ///   - board: 矩阵
    ///   - word: 字符串
    ///   - row: 行
    ///   - column: 列
    ///   - idx: 当前索要找的字符在字符串中的位置
    ///   - hasLook: 矩阵中已经处理过的位置的集合("row-column")
    /// - Returns: true查找到，false没有查找到
    static func dfs(_ board: [[Character]], word: String, row: Int, column: Int, idx: Int) -> Bool {
        if row < 0 || row >= board.count || column < 0 || column >= board[0].count {
            // 行或者列越界
            return false
        }
        let index = word.index(word.startIndex, offsetBy: idx)
        if board[row][column] != Character(extendedGraphemeClusterLiteral: word[index]) {
            // 当前位置字符与索要寻找的字符不符
            return false
        }
        // 当前字符即要找的字符
        if idx == word.count - 1 {
            // 如果当前字符为字符串的最后一个字符则直接返回true
            return true
        }
        // 当前字符不是最后一个字符，需要继续寻找下一个字符
        var tmp = board
        // 该位置已经访问过不允许第二次访问。所以用字符“/”换掉矩阵中的该字符，下次访问该位置就会因为字符不相符而返回false
        tmp[row][column] = "/"
        // 分别访问矩阵中位于该字符下、上、右、左，去查找字符串中的下一个(idx+1)字符，找到一个符合的即可
        let res = dfs(tmp, word: word, row: row + 1, column: column, idx: idx + 1) // 查找矩阵中位于该字符下方的字符
            || dfs(tmp, word: word, row: row - 1, column: column, idx: idx + 1) // 查找矩阵中位于该字符上方的字符
            || dfs(tmp, word: word, row: row, column: column + 1, idx: idx + 1) // 查找矩阵中位于该字符右方的字符
            || dfs(tmp, word: word, row: row, column: column - 1, idx: idx + 1) // 查找矩阵中位于该字符左方的字符
        return res
    }
}
