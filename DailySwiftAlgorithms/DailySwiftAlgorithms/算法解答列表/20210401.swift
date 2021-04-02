//
//  20210401.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2021/4/1.
//  Copyright © 2021 Beryter. All rights reserved.
//

import Foundation
class Solution_20210401 {
//    给你一个字符串数组 words ，只返回可以使用在 美式键盘 同一行的字母打印出来的单词。键盘如下图所示。
//
//    美式键盘 中：
//
//    第一行由字符 "qwertyuiop" 组成。
//    第二行由字符 "asdfghjkl" 组成。
//    第三行由字符 "zxcvbnm" 组成。
//
//    示例 1：
//
//    输入：words = ["Hello","Alaska","Dad","Peace"]
//    输出：["Alaska","Dad"]
//    示例 2：
//
//    输入：words = ["omk"]
//    输出：[]
//    示例 3：
//
//    输入：words = ["adsdf","sfd"]
//    输出：["adsdf","sfd"]
//
//
//    提示：
//
//    1 <= words.length <= 20
//    1 <= words[i].length <= 100
//    words[i] 由英文字母（小写和大写字母）组成

    class func findWords(_ words: [String]) -> [String] {
        let firstline = "qwertyuiop"
        let secondline = "asdfghjkl"
        let threeline = "zxcvbnm"
        var res = [String]()
        for word in words {
            if word.isEmpty { continue }
            var tmp = ""
            if firstline.contains(word.first!.lowercased()) {
                tmp = firstline
            } else if secondline.contains(word.first!.lowercased()) {
                tmp = secondline
            } else if threeline.contains(word.first!.lowercased()) {
                tmp = threeline
            }
            var rm = false
            for char in word {
                if !tmp.contains(char.lowercased()) {
                    rm = true
                    break
                }
            }
            if !rm {
                res.append(word)
            }
        }
        return res
    }

    class func test() {
        let list = ["Hello", "Alaska", "Dad", "Peace"]
        let res = findWords(list)
        print("\(res)")
    }
}
