//
//  ViewController.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2018/9/12.
//  Copyright © 2018年 Beryter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dic: [Int: Int] = [1: 1, 2: 2]
    var list = [String]()
    var sDic = [Character: Int]()
    var tDic = [Character: Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testHelper()
    }
    
    
    func testHelper() {
//        Helper_20190724.test()
//        Helper_20190726.test()
//        Helper_20190731.test()
        Helper_20190807.test()
    }
    
    
    
    
    /// 求最大公约数
    func maxCommonDivisor(_ a: Int, _ b: Int) -> Int {
        var max = 0
        var i = a
        var j = b
        while i % j > 0 {
            max = i % j
            i = j
            j = max
        }
        return j
    }
    
    func compress(_ chars: inout [Character]) -> Int {
        if chars.count <= 1 {
            return chars.count
        }
        var nextIndex = 1
        var count = 1
        var curChar = chars[0]
        var i = 1
        var l = chars.count
        while i < l {
            let tmpChar = chars[i]
            if curChar == tmpChar {
                count += 1
                if i != chars.count - 1 {
                    i += 1
                    continue
                }
            } else {
                if i == chars.count - 1 {
                    break
                }
            }
            if count > 1 {
                let str = "\(count)"
                var tmplist = [Character]()
                for char in str {
                    //                    chars[nextIndex] = char
                    //                    nextIndex += 1
                    tmplist.append(char)
                }
                if i == l - 1 {
                    chars[nextIndex ... i] = tmplist[0 ... tmplist.count - 1]
                } else {
                    chars[nextIndex ... i - 1] = tmplist[0 ... tmplist.count - 1]
                }
                
                i = nextIndex + tmplist.count + 1
                l = chars.count
                nextIndex = i
            } else {
                i += 1
            }
            nextIndex = i
            curChar = tmpChar
            count = 1
        }
        return chars.count
    }
    
    func arrangeCoins(_ n: Int) -> Int {
        if n <= 1 {
            return n
        }
        var l = 0
        var tmp = n
        while tmp >= l {
            tmp -= l
            l += 1
        }
        return l - 1
    }
    
    func findAnagrams(_ s: String, _ p: String) -> [Int] {
        if s.isEmpty || p.isEmpty {
            return [Int]()
        }
        if p.count > s.count {
            return [Int]()
        }
        var dic = [Character: Int]()
        for char in p {
            if let count = dic[char] {
                dic[char] = count + 1
            } else {
                dic[char] = 1
            }
        }
        var list = [Int]()
        var i = 0
        var tmp = dic
        var curStart = 0
        while i < s.count {
            //            "abacbabc"
            //            "abc"
            let char = Character(String(s[s.index(s.startIndex, offsetBy: i)]))
            if let count = tmp[char] {
                if count == 0 {
                    if i == curStart + p.count - 1 {
                        curStart += 1
                    }
                } else {
                    tmp[char] = count - 1
                    if i == curStart + p.count - 1 {
                        list.append(curStart)
                        let char = Character(String(s[s.index(s.startIndex, offsetBy: curStart)]))
                        tmp = [char: 1]
                        curStart += 1
                    }
                }
                
                i += 1
            } else {
                tmp = dic
                i += 1
                curStart = i
            }
        }
        return list
    }
    
    func countSegments(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        let array = s.components(separatedBy: " ").filter {
            $0 != ""
        }
        return array.count
    }
    
    func addStrings(_ num1: String, _ num2: String) -> String {
        var a = num1
        var b = num2
        
        
        
        if a.count < b.count {
            a = String(repeating: "0", count: b.count - a.count) + a
        }
        
        
        
        
        if a.count > b.count {
            b = String(repeating: "0", count: a.count - b.count) + b
        }
        
        
        
        var res = ""
        var i = a.count - 1
        var addOne = 0
        
        
        while i >= 0 {
            let achar = Int(String(a[a.index(a.startIndex, offsetBy: i)]))!
            let bchar = Int(String(b[b.index(b.startIndex, offsetBy: i)]))!
            var sum = achar + bchar + addOne
            if sum > 9 {
                addOne = 1
                sum -= 10
            }
            res = "\(sum)" + res
            i -= 1
        }
        if addOne == 1 {
            res = "1" + res
        }
        return res
    }
    
    func thirdMax(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        if nums.count == 2 {
            return max(nums[0], nums[1])
        }
        
        var f = max(nums[2], max(nums[1], nums[0]))
        var t = min(nums[2], min(nums[1], nums[0]))
        var s = nums[0] + nums[1] + nums[2] - f - t
        
        if f == s {
            s = t
        }
        if nums.count == 3 {
            if s == t {
                return f
            }
            if s == f {
                return f
            }
            return min(nums[2], min(nums[1], nums[0]))
        }
        //        [1,2,2,5,3,5]
        for i in 3 ..< nums.count {
            let v = nums[i]
            if v >= f {
                if v == f {
                    continue
                }
                t = s
                s = f
                f = v
            } else if v >= s {
                if v == s {
                    continue
                }
                t = s
                s = v
            } else if v >= t {
                t = v
            } else {
                if s == t {
                    if t == v {
                        s = v
                        t = v
                    } else {
                        t = v
                    }
                }
            }
        }
        if s == t {
            return f
        }
        if s == f {
            return f
        }
        return t
    }
    
    func fizzBuzz(_ n: Int) -> [String] {
        var list = [String]()
        for i in 1 ..< n + 1 {
            let a = i % 3
            let b = i % 5
            if a == 0, b == 0 {
                list.append("FizzBuzz")
            } else if a == 0 {
                list.append("Fizz")
            } else if b == 0 {
                list.append("Buzz")
            }
        }
        return list
    }
    
    func longestPalindrome(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        var dic = [Character: Int]()
        var max = 0
        for char in s {
            if let count = dic[char] {
                dic[char] = count + 1
            } else {
                dic[char] = 1
            }
        }
        var hasSingle = false
        for (_, value) in dic {
            let c = value / 2
            if c > 0 {
                max += 2 * c
            }
            if !hasSingle, value % 2 != 0 {
                hasSingle = true
            }
        }
        max = hasSingle ? max + 1 : max
        
        return max
    }
    
    func toHex(_ num: Int) -> String {
        // 核心思想，使用位运算，每4位，对应1位16进制数字。
        // 使用0xf(00...01111b)获取num的低4位。
        // >>算数位移，其中正数右移左边补0，负数右移左边补1。
        // 位移运算并不能保证num==0，需要使用32位int保证（对应16进制小于等于8位）。
        if num == 0 {
            return "0"
        }
        let ss = "0123456789abcdef"
        var str = ""
        var val = num
        while val != 0, str.count < 8 {
            let index = val & 0xF
            str = String(ss[ss.index(ss.startIndex, offsetBy: index)]) + str
            val >>= 4
        }
        
        return str
    }
    
    // [1,9]共9个数字，组成的字符串长度为9*1长度= 9
    // [10, 99]共90个数字，组成的字符串为90*2长度=180
    // [100, 999]共900个数字，组成的字符串为900*3长度=2700
    // 依次类推，长度为len的数字，[pow(10, len - 1), pow(10, len)-1],一共9*pow(10, len-1)个数，
    // 组成字符串的长度为9*pow(10, len-1)*len
    func findNthDigit(_ n: Int) -> Int {
        if n < 10 {
            return n
        }
        var tmp = n - 9
        // 单个数字的长度
        var len: Int = 1
        // 长度为len+1的数字所构成的字符串的长度
        var nextSize = 9 * Int(pow(Double(10), Double(len))) * (len + 1)
        // 确定n所处的数字的位数
        while tmp > nextSize {
            tmp -= nextSize
            len += 1
            nextSize = 9 * Int(pow(Double(10), Double(len))) * (len + 1)
        }
        
        len += 1
        // 确定是当前数是什么
        let index = Int(pow(Double(10), Double(len - 1))) + Int(ceil((Double(tmp) - Double(len)) / Double(len)))
        let str = "\(index)"
        // 确定是当前数的第几个数字
        let charIndex = (tmp % len == 0 ? len : tmp % len) - 1
        let charStr = String(str[str.index(str.startIndex, offsetBy: charIndex)])
        return Int(charStr)!
    }
    
    func findTheDifference(_ s: String, _ t: String) -> Character {
        var dic = [Character: Int]()
        for i in 0 ..< s.count {
            let char = s[s.index(s.startIndex, offsetBy: i)]
            if let count = dic[char] {
                dic[char] = count + 1
            } else {
                dic[char] = 1
            }
        }
        
        var res: Character?
        for char in t {
            if let tmp = dic[char] {
                if tmp == 0 {
                    res = char
                    break
                }
                dic[char] = tmp - 1
            } else {
                res = char
                break
            }
        }
        return res!
    }
    
    /// 给定一个字符串，找到它的第一个不重复的字符，并返回它的索引。如果不存在，则返回 -1。
    func firstUniqChar(_ s: String) -> Int {
        if s.isEmpty {
            return -1
        }
        //        var dic = [Character: (Int, Int)]()
        
        var cDic = [Character: Int]()
        var cDicIndex = [Character: Int]()
        
        for i in 0 ..< s.count {
            let char = s[s.index(s.startIndex, offsetBy: i)]
            if let tmp = cDic[char] {
                cDic[char] = tmp + 1
                cDicIndex.removeValue(forKey: char)
            } else {
                cDic[char] = 1
                cDicIndex[char] = i
            }
        }
        if cDicIndex.values.count == 0 {
            return -1
        }
        var list = Array(cDicIndex.values)
        list = list.sorted(by: <)
        return list[0]
        //
        //
        //        for i in 0 ..< s.count {
        //            let char = s[s.index(s.startIndex, offsetBy: i)]
        //            if let tmp = dic[char] {
        //                dic[char] = (tmp.0 + 1, tmp.1)
        //            }else{
        //                dic[char] = (1, i)
        //            }
        //        }
        //        var res = -1
        //        for tuple in dic.values {
        //            if tuple.0 != 1 {
        //                continue
        //            }
        //            if res == -1 {
        //                res = tuple.1
        //            }else{
        //                res = min(tuple.1, res)
        //            }
        //        }
        //        return res
    }
    
    /// 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
    func maxSubArray(_ nums: [Int]) -> Int {
        // 连续
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return nums[0]
        }
        // res代表已经遍历过的连续子数组中最大的和
        var res = nums[0]
        var sum = 0
        //        [-2,1,-3,4,-1,2,1,-5,4]
        for val in nums {
            if sum > 0 {
                sum += val
            } else {
                sum = val
            }
            res = max(sum, res)
        }
        return res
        //        if nums.count == 0 {
        //            return 0
        //        }
        //        return maxSubArrayHelper(nums: nums, index: nums.count - 1)
    }
    
    func maxSubArrayHelper(nums: [Int], index: Int) -> Int {
        if index == 0 {
            return nums[0]
        }
        if index == 1 {
            return max(nums[1], nums[0])
        }
        let tmp = maxSubArrayHelper(nums: nums, index: index - 1)
        let tmp2 = maxSubArrayHelper(nums: nums, index: index - 1) + nums[index]
        return max(tmp, tmp2)
    }
    
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.isEmpty, magazine.isEmpty {
            return true
        }
        if magazine.isEmpty || ransomNote.isEmpty {
            return false
        }
        
        var dic = [Character: Int]()
        for char in magazine {
            if let count = dic[char] {
                dic[char] = count + 1
            } else {
                dic[char] = 1
            }
        }
        
        for char in ransomNote {
            guard let count = dic[char], count != 0 else {
                return false
            }
            dic[char] = count - 1
        }
        return true
    }
    
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        if nums1.isEmpty, nums2.isEmpty {
            return [Int]()
        }
        
        if nums1.isEmpty || nums2.isEmpty {
            return [Int]()
        }
        
        var dic = [Int: Int]()
        
        for i in 0 ..< nums1.count {
            let num1 = nums1[i]
            if dic[num1] != nil {
                continue
            }
            for j in 0 ..< nums2.count {
                if num1 == nums2[j] {
                    dic[num1] = num1
                    break
                }
            }
        }
        return Array(dic.keys)
    }
    
    func wordPattern(_ pattern: String, _ str: String) -> Bool {
        var dic = [Character: String]()
        var scharDic = [String: Character]()
        let array = str.components(separatedBy: " ")
        
        if pattern.count != array.count {
            return false
        }
        
        for i in 0 ..< array.count {
            let char = pattern[pattern.index(pattern.startIndex, offsetBy: i)]
            
            if let s = dic[char] {
                if s != array[i] {
                    return false
                }
            } else {
                dic[char] = array[i]
            }
            
            if let cha = scharDic[array[i]] {
                if char != cha {
                    return false
                }
            } else {
                scharDic[array[i]] = char
            }
        }
        return true
    }
    
    func moveZeroes(_ nums: inout [Int]) {
        if nums.count < 2 {
            return
        }
        var notZeroIndex = 0
        for i in (0 ..< nums.count).reversed() {
            if nums[i] != 0 {
                if notZeroIndex == 0 {
                    notZeroIndex = i
                }
                continue
            }
            // 为0的时候
            if i == nums.count - 1 {
                // 最后一个数为0不做处理
                continue
            }
            if nums[i] == nums[i + 1] {
                // 该元素后面的元素为0不做处理
                continue
            }
            var s = i
            while s < notZeroIndex {
                (nums[s], nums[s + 1]) = (nums[s + 1], nums[s])
                s += 1
            }
            notZeroIndex -= 1
        }
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        if nums.count == 1 {
            return 0
        }
        
        var dic = [Int: Int]()
        for i in nums {
            dic[i] = i
        }
        
        for i in 0 ..< nums.count + 1 {
            if dic[i] == nil {
                return i
            }
        }
        
        var n = nums.count
        if !nums.contains(n) {
            return n
        }
        while n >= 0 {
            n -= 1
            if !nums.contains(n) {
                return n
            }
        }
        return 0
    }
    
    func isUgly(_ num: Int) -> Bool {
        if 0 == num {
            return false
        }
        
        if num == 1 {
            return true
        }
        var n = num
        while n % 5 == 0 {
            n /= 5
        }
        
        while n % 3 == 0 {
            n /= 3
        }
        while n % 2 == 0 {
            n /= 2
        }
        return n == 1
    }
    
    func isAnagramHelper(_ s: String, _ t: String) {
        if s.isEmpty || s.count == 1 {
            return
        }
        let mid = s.index(s.startIndex, offsetBy: s.count / 2)
        
        let sleft = String(s[s.startIndex ..< mid])
        let sright = String(s[mid ..< s.endIndex])
        if sleft.count == 1 {
            sDic[sleft.first!] = (sDic[sleft.first!] ?? 0) + 1
        }
        if sright.count == 1 {
            sDic[sright.first!] = (sDic[sright.first!] ?? 0) + 1
        }
        
        let tleft = String(t[t.startIndex ..< mid])
        let tright = String(t[mid ..< t.endIndex])
        if tleft.count == 1 {
            tDic[tleft.first!] = (tDic[tleft.first!] ?? 0) + 1
        }
        if tright.count == 1 {
            tDic[tright.first!] = (tDic[tright.first!] ?? 0) + 1
        }
        isAnagramHelper(sleft, tleft)
        isAnagramHelper(sright, tright)
    }
    
    func isAnagram(_ s: String, _ t: String) -> Bool {
        /**
         * 什么是异位词
         *     两个单词如果包含相同的字母，次序不同，则称为字母易位词(anagram)
         * 异位词特点
         *     字符数相同/顺序不同/出现字符相同
         * 思路
         *     既然是找寻字符串的不同，那我们可以直接建立对应的哈希表，来对两个 hash 表 进行操作
         *     在比对的时候可以达到O(1)的复杂度
         */
        
        if s.isEmpty && t.isEmpty {
            return true
        }
        if s.isEmpty || t.isEmpty {
            return false
        }
        if s.count != t.count {
            return false
        }
        
        //        var dics = [Character: Int]()
        //        var dict = [Character: Int]()
        
        //        var left = 0
        //        var right = s.count - 1
        //        while left <= right {
        //            var schar = s[s.index(s.startIndex, offsetBy: left)]
        //            var tchar = t[t.index(t.startIndex, offsetBy: left)]
        //            dics[schar] = (dics[schar] ?? 0) + 1
        //            dict[tchar] = (dict[tchar] ?? 0) + 1
        //
        //            if left == right {
        //                break
        //            }
        //            schar = s[s.index(s.startIndex, offsetBy: right)]
        //            tchar = t[t.index(t.startIndex, offsetBy: right)]
        //            dics[schar] = (dics[schar] ?? 0) + 1
        //            dict[tchar] = (dict[tchar] ?? 0) + 1
        //            left += 1
        //            right -= 1
        //        }
        
        isAnagramHelper(s, t)
        for (key, value) in sDic {
            guard let val = tDic[key], val == value else {
                return false
            }
        }
        return true
    }
    
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n == 0 {
            return false
        }
        var val = n
        var i = 15
        
        if val % Int(pow(Double(2), Double(15))) == 0 {
            val = val / Int(pow(Double(2), Double(15)))
        }
        while i > 0 {
            if val % Int(pow(Double(2), Double(i - 1))) == 0 {
                val = val / Int(pow(Double(2), Double(i - 1)))
            }
            i -= 1
        }
        return (val == 1)
    }
    
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        var dic = [Character: Character]()
        
        var left = 0
        var right = s.count - 1
        
        while left < right {
            let lchars = s[s.index(s.startIndex, offsetBy: left)]
            let lchart = t[t.index(t.startIndex, offsetBy: left)]
            let rchars = s[s.index(s.startIndex, offsetBy: right)]
            let rchart = t[t.index(t.startIndex, offsetBy: right)]
            
            if let val = dic[lchars] {
                if val != lchart {
                    return false
                }
            } else {
                if dic.values.contains(lchart) {
                    return false
                }
                dic.updateValue(lchart, forKey: lchars)
            }
            
            if let val = dic[rchars] {
                if val != rchart {
                    return false
                }
            } else {
                if dic.values.contains(rchart) {
                    return false
                }
                dic.updateValue(rchart, forKey: rchars)
            }
            left += 1
            right -= 1
        }
        let lchars = s[s.index(s.startIndex, offsetBy: left)]
        let lchart = t[t.index(t.startIndex, offsetBy: left)]
        if let val = dic[lchars] {
            if val != lchart {
                return false
            }
        } else {
            if dic.values.contains(lchart) {
                return false
            }
            dic.updateValue(lchart, forKey: lchars)
        }
        
        //        for i in 0 ..< s.count {
        //            let chars = s[s.index(s.startIndex, offsetBy: i)]
        //            let chart = t[t.index(t.startIndex, offsetBy: i)]
        //
        //            if let val = dic[chars] {
        //                if val != chart {
        //                    return false
        //                }
        //            }else{
        //                if dic.values.contains(chart) {
        //                    return false
        //                }
        //                dic.updateValue(chart, forKey: chars)
        //            }
        //        }
        return true
    }
    
    //
    //    func dateStr(closure: () -> String) -> String{
    //        return closure()
    //    }
    
    func commonChars(_ A: [String]) -> [String] {
        if A.isEmpty {
            return [String]()
        }
        var list = [String]()
        var minLenghtStr: String?
        for str in A {
            let s = String(str.sorted(by: <))
            if let tmp = minLenghtStr {
                if s.count < tmp.count {
                    minLenghtStr = s
                }
            } else {
                minLenghtStr = s
            }
            list.append(s)
        }
        commonCharsHelp(&list, minLenghtStr!)
        return self.list
    }
    
    func commonCharsHelp(_ list: inout [String], _ minStr: String) {
        let minStrFirstChar = minStr.first!
        let minStrLastChar = minStr.last!
        var tmpStr = minStr
        var firstCharSame = true
        for i in 0 ..< list.count {
            var str = list[i]
            if str == minStr {
                let left = str.index(str.startIndex, offsetBy: 1)
                str = String(str[left ..< str.endIndex])
                if str.count < tmpStr.count {
                    tmpStr = str
                }
                list[i] = str
                continue
            }
            str = str.filter { $0 >= minStrFirstChar && $0 <= minStrLastChar }
            if str.isEmpty {
                return
            }
            if str.first! != minStrFirstChar {
                firstCharSame = false
            } else {
                let left = str.index(str.startIndex, offsetBy: 1)
                str = String(str[left ..< str.endIndex])
                if str.count < tmpStr.count {
                    tmpStr = str
                }
            }
            list[i] = str
        }
        if firstCharSame {
            self.list.append(String(minStrFirstChar))
        }
        if tmpStr.isEmpty {
            return
        }
        commonCharsHelp(&list, tmpStr)
    }
    
    func largestSumAfterKNegations(_ A: [Int], _ K: Int) -> Int {
        if A.isEmpty {
            return 0
        }
        // 先用快排，进行排序
        var list = quickSort(A)
        if list.count == 1 {
            if K % 2 != 0 {
                list[0] = -list[0]
            }
            return list.first!
        }
        
        if list.first! >= 0 {
            if K % 2 != 0 {
                list[0] = -list[0]
            }
            var sum = 0
            for val in list {
                sum += val
            }
            return sum
        }
        
        var count = K
        var minIndex = 0
        var sum = 0
        for i in 0 ..< list.count {
            if count <= 0 {
                sum += list[i]
                continue
            }
            if list[i] < 0 {
                list[i] = -list[i]
                minIndex = i
                count -= 1
                if i == list.count - 1 {
                    if count % 2 != 0 {
                        list[i] = -list[i]
                    }
                    count = 0
                }
            } else if list[i] == 0 {
                count = 0
            } else if list[i] > 0 {
                if list[minIndex] <= list[i] {
                    if count % 2 != 0 {
                        sum -= list[minIndex]
                        list[minIndex] = -list[minIndex]
                        sum += list[minIndex]
                    }
                } else {
                    if count % 2 != 0 {
                        list[i] = -list[i]
                    }
                }
                count = 0
            }
            sum += list[i]
        }
        return sum
    }
    
    func quickSort(_ list: [Int]) -> [Int] {
        if list.count <= 1 {
            return list
        }
        
        let midVal = list[list.count / 2]
        var left = [Int]()
        var mid = [Int]()
        var right = [Int]()
        
        for i in 0 ..< list.count {
            if list[i] < midVal {
                left.append(list[i])
            } else if list[i] > midVal {
                right.append(list[i])
            } else {
                mid.append(list[i])
            }
        }
        return quickSort(left) + mid + quickSort(right)
    }
    
    func bitwiseComplement(_ N: Int) -> Int {
        if N == 0 {
            return 0
        }
        var val = N
        var index = 0
        var res = 0
        while val != 0 {
            let n = (val % 2) == 1 ? 0 : 1
            res = res + n * Int(pow(Double(2), Double(index)))
            val = val / 2
            index += 1
        }
        return res
    }
    
    func numPairsDivisibleBy60(_ time: [Int]) -> Int {
        if time.count < 2 {
            return 0
        }
        var dic = [Int: Int]()
        var count = 0
        
        for i in 0 ..< time.count {
            let val = time[i] % 60
            var cn = 0
            if val == 0 {
                cn = dic[0] ?? 0
            } else {
                cn = dic[60 - val] ?? 0
            }
            count += cn
            dic[val] = (dic[val] ?? 0) + 1
        }
        
        return count
    }
    
    func handler(_ A: inout [Int]) -> Int {
        if A.count == 0 {
            return 0
        }
        var maxVal = 0
        for i in 0 ..< A.count {
            for j in i ..< A.count {
                let val = A[i] + A[j] + j - i
                if i == 0, j == 0 {
                    maxVal = val
                } else {
                    maxVal = max(val, maxVal)
                }
            }
        }
        return maxVal
    }
    
    func countPrimes(_ n: Int) -> Int {
        if n < 3 {
            return 0
        }
        // 首先生成了一个全部为1的列表
        var list = Array(repeating: 1, count: n)
        // 因为0和1都不是质数，所以列表的前两个位置赋值为0
        list[0] = 0
        list[1] = 0
        // 此时从index=2开始，[2] = 1即表明第一个质数为2，然后将2的倍数对应的
        // 索引全部赋值为0.此时list[3]=1即表明下一个质数为3，同样划去3的倍数。以此类推
        _ = Int(sqrt(Double(n))) + 1
        for i in 2 ..< n {
            if list[i] != 1 {
                continue
            }
            for j in i + 1 ..< list.count {
                if j % i == 0 {
                    list[j] = 0
                }
            }
        }
        
        var count = 0
        for i in 0 ..< list.count {
            count += list[i]
        }
        return count
    }
    
    func rotate(_ nums: inout [Int], _ k: Int) {
        if nums.count == 0 {
            return
        }
        if nums.count == 1 {
            return
        }
        var i = k
        while i > 0 {
            let tmp = nums.last!
            for j in (1 ..< nums.count).reversed() {
                nums[j] = nums[j - 1]
            }
            nums[0] = tmp
            i -= 1
        }
    }
    
    func trailingZeroes(_ n: Int) -> Int {
        if n == 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        var res = 1
        var count = 0
        for i in 1 ..< n + 1 {
            res = res * i
            if res % 10 == 0 {
                res = 1
                count += 1
            }
        }
        return count
    }
    
    func titleToNumber(_ s: String) -> Int {
        if s.isEmpty {
            return 0
        }
        var res = 0
        let AVal = Int("A".unicodeScalars.first!.value)
        
        var rate = 1
        for char in s.reversed() {
            res += (Int(char.unicodeScalars.first!.value) - AVal + 1) * rate
            rate *= 26
        }
        
        //        for char in s  {
        //            res = res*26 + Int(char.unicodeScalars.first!.value) - AVal + 1
        //            print("aaa=\(res)")
        //        }
        return res
    }
    
    func singleNumber(_ nums: [Int]) -> Int {
        var a = 0
        for num in nums {
            a = a ^ num
        }
        return a
    }
    
    func isPalindrome(_ s: String) -> Bool {
        if s.isEmpty {
            return true
        }
        let str = s.filter {
            let val = (($0 >= "0") && ($0 <= "9")) || ($0 >= Character("a") && $0 <= Character("z")) || ($0 >= Character("A") && $0 <= Character("Z"))
            return val
        }.uppercased()
        let des = String(str.reversed())
        for i in 0 ..< des.count {
            let a = String(str[str.index(str.startIndex, offsetBy: i)])
            let b = String(des[des.index(des.startIndex, offsetBy: i)])
            if a != b {
                return false
            }
        }
        return true
    }
    
    func generate(_ numRows: Int) -> [[Int]] {
        var array = [[Int]]()
        for i in 0 ..< numRows {
            if i == 0 {
                array.append([1])
                continue
            }
            if i == 1 {
                array.append([1, 1])
                continue
            }
            array.append(helper(array[i - 1]))
        }
        return array
    }
    
    func helper(_ nums: [Int]) -> [Int] {
        if nums.count == 1 {
            return [1, 1]
        }
        var array = [1]
        for i in 1 ..< nums.count {
            array.append(nums[i] + nums[i - 1])
        }
        array.append(1)
        return array
    }
    
    func majorityElement(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        
        if nums.count == 1 {
            return nums.first!
        }
        
        var curValue = 0
        var count = 0
        for i in 0 ..< nums.count {
            if count == 0 {
                curValue = nums[i]
            }
            if nums[i] == curValue {
                count += 1
            } else {
                count -= 1
            }
            if count > nums.count / 2 {
                break
            }
        }
        return curValue
    }
    
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        var left = 0
        var right = numbers.count - 1
        while left < right {
            if numbers[left] + numbers[right] == target {
                break
            } else if numbers[left] + numbers[right] > target {
                right -= 1
            } else {
                left += 1
            }
        }
        return [left, right]
    }
    
    func convertToTitle(_ n: Int) -> String {
        if n <= 0 {
            return ""
        }
        var str = ""
        var i = n
        let a = Int("A".unicodeScalars.first!.value)
        while i > 0 {
            i -= 1
            let char = UnicodeScalar(a + i % 26)!
            str = String(char) + str
            i = i / 26
        }
        return str
    }
    
    func maxValHelper(_ list: [Int]) -> Int {
        if list.count == 0 {
            return 0
        }
        if list.count == 1 {
            return list.first ?? 0
        }
        var maxVal = 0
        for i in 0 ..< list.count {
            for j in (0 ..< list.count).reversed() {
                if list[j] > list[i], j > i {
                    maxVal = max(maxVal, list[j] - list[i])
                }
            }
        }
        return maxVal
    }
    
    func sort(_ nums: [Int]) -> [Int] {
        if nums.count <= 1 {
            return nums
        }
        let result = nums.sorted(by: <)
        var i = 0
        var array1 = [Int]()
        var array2 = [Int]()
        
        var add = false
        for j in 1 ..< result.count {
            if result[j] == result[i] {
                array2.append(result[j])
                add = true
            } else {
                if add {
                    array2.append(result[i])
                } else {
                    array1.append(result[i])
                }
                add = false
            }
            i += 1
        }
        return array1 + array2
    }
    
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        if nums.count == 0 || k == 0 {
            return false
        }
        var set = Set<Int>()
        // 哈希+滑动窗口
        for i in 0 ..< nums.count {
            if set.contains(nums[i]) {
                return true
            }
            set.insert(nums[i])
            if set.count == k + 1 {
                set.remove(at: set.startIndex)
            }
        }
        return false
    }
    
    func getMin(_ list: [Int]) -> Int {
        if list.count == 0 {
            return 0
        }
        let res = list.sorted(by: <)
        return res.first!
    }
    
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        if m == 0 {
            nums1 = nums2
            return
        }
        
        if nums2.count == 0 {
            return
        }
        
        var i = m - 1
        var j = 0
        var isInset = false
        while j < n {
            if nums2[j] < nums1[i] {
                nums1[i + 1] = nums1[i]
                nums1[i] = nums2[j]
                isInset = true
                i -= 1
                if i < 0 {
                    i = m + j
                    j += 1
                    isInset = false
                }
            } else {
                if isInset {
                    isInset = false
                    continue
                } else {
                    nums1[i + 1] = nums2[j]
                }
                i = m + j
                j += 1
            }
        }
    }
    
    func climbStairs(_ n: Int) -> Int {
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        if dic[n - 1] == nil {
            dic[n - 1] = climbStairs(n - 2) + climbStairs(n - 3)
        }
        dic[n] = dic[n - 1]! + dic[n - 2]!
        return dic[n]!
    }
    
    func mySqrt(_ x: Int) -> Int {
        if x <= 1 {
            return x
        }
        let m: Double = Double(x)
        var k: Double = 1
        while abs(k - m / k) > 0.000001 {
            k = (k + m / k) / 2
        }
        return Int(k)
    }
    
    func addBinary(_ a: String, _ b: String) -> String {
        var res = ""
        var j = 0
        
        // 方法1
        var ta = a
        var tb = b
        
        if ta.count < tb.count {
            for _ in 0 ..< abs(ta.count - tb.count) {
                ta = "0" + ta
            }
        } else if tb.count < ta.count {
            for _ in 0 ..< abs(ta.count - tb.count) {
                tb = "0" + tb
            }
        }
        
        for i in 0 ..< ta.count {
            let achar = ta[ta.index(ta.startIndex, offsetBy: ta.count - 1 - i)]
            let bchar = tb[tb.index(tb.startIndex, offsetBy: tb.count - 1 - i)]
            if achar == bchar {
                if j == 1 {
                    res = "1" + res
                } else {
                    res = "0" + res
                }
                j = achar == "1" ? 1 : 0
            } else {
                res = ((j == 1) ? "0" : "1") + res
            }
        }
        
        if j == 1 {
            res = "1" + res
        }
        return res
        
        //
        //
        //
        //
        //        for i in 0 ..< min(a.count, b.count) {
        //            let achar = a[a.index(a.startIndex, offsetBy: a.count - 1 - i)]
        //            let bchar = b[b.index(b.startIndex, offsetBy: b.count - 1 - i)]
        //            if achar == bchar {
        //                if j == 1 {
        //                    res = "1" + res
        //                }else{
        //                    res = "0" + res
        //                }
        //                j = achar == "1" ? 1 : 0
        //            }else{
        //                res = ((j == 1) ? "0" : "1") + res
        //            }
        //        }
        //
        //        if a.count == b.count && j == 1 {
        //            res = "1" + res
        //            return res
        //        }
        //
        //
        //        let tmp = a.count > b.count ? a : b
        //        let count = abs(a.count - b.count)
        //        for i in 0 ..< abs(a.count - b.count) {
        //            let achar = tmp[tmp.index(tmp.startIndex, offsetBy: count - 1 - i)]
        //            if String(achar) == "1" {
        //                if j == 1 {
        //                    res = "0" + res
        //                }else{
        //                    res = "1" + res
        //                }
        //            }else{
        //                if j == 1 {
        //                    res = "1" + res
        //                }else{
        //                    res = "0" + res
        //                }
        //                j = 0
        //            }
        //        }
        //        if j == 1 {
        //            res = "1" + res
        //        }
        //
        //        return res
    }
    
    func plusOne(_ digits: [Int]) -> [Int] {
        if digits.count == 0 {
            return [Int]()
        }
        var i = 1
        var res: [Int] = [Int]()
        
        for j in (0 ..< digits.count).reversed() {
            var tmp = digits[j] + i
            
            if tmp == 10 {
                i = 1
                tmp = 0
                res.insert(tmp, at: 0)
                if j == 0 {
                    res.insert(1, at: 0)
                }
            } else {
                i = 0
                res.insert(tmp, at: 0)
            }
        }
        return res
    }
    
    func countAndSay(_ n: Int) -> String {
        var res = "1"
        if n == 1 {
            return res
        }
        for _ in 2 ... n {
            var curRes = ""
            var count = 0
            var curChar = res[res.index(res.startIndex, offsetBy: 0)]
            for j in 0 ..< res.count {
                let char = res[res.index(res.startIndex, offsetBy: j)]
                if curChar == char {
                    count += 1
                } else {
                    curRes += "\(count)\(curChar)"
                    curChar = char
                    count = 1
                }
                if j == res.count - 1 {
                    curRes += "\(count)\(curChar)"
                    break
                }
            }
            res = curRes
        }
        return res
    }
    
    //
    //    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
    //
    //        var low = 0
    //        var hight = nums.count
    //        var mid = 0
    //        if target <= nums[0] {
    //            return 0
    //        }
    //        while low < hight {
    //            mid = (hight - low)/2 + low
    //            if nums[mid] == target {
    //                return mid
    //            }
    //            if nums[mid] > target {
    //                hight = mid - 1
    //            }else{
    //                low = mid + 1
    //            }
    //        }
    //        return low+1
    //    }
    
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.count == 0 {
            return 0
        }
        let _: String = ""
        
        //        var res = [0,1,2,2,3,0,4,2]
        var i = 0
        
        for j in 0 ..< nums.count {
            if nums[j] != val {
                nums[i] = nums[j]
                i += 1
            }
        }
        
        return i
    }
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count == 0 {
            return 0
        }
        var i = 0
        for j in 1 ..< nums.count {
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i + 1
    }
    
    func isValid(_ s: String) -> Bool {
        if s == "" {
            return true
        }
        
        var array = [String]()
        for i in 0 ..< s.count {
            let ch = String(s[s.index(s.startIndex, offsetBy: i)])
            if ch == "(" || ch == "[" || ch == "{" {
                array.append(ch)
                continue
            }
            
            if ch == array.last {
                array.removeLast()
            } else {
                return false
            }
        }
        return true
    }
    
    func longestCommonPrefix(_ strs: [String]) -> String {
        if strs.count == 0 {
            return ""
        }
        
        if strs.count == 1 {
            return strs[0]
        }
        var tmp: String = strs[0]
        for i in 1 ..< strs.count {
            var res = ""
            for j in 0 ..< min(strs[i].count, tmp.count) {
                let a = strs[i][strs[i].index(strs[i].startIndex, offsetBy: j)]
                let b = tmp[tmp.index(tmp.startIndex, offsetBy: j)]
                if a == b {
                    res += String(a)
                } else {
                    if res == "" {
                        return ""
                    }
                    break
                }
            }
            tmp = res
        }
        return tmp
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        if x < 0 {
            return false
        }
        
        if x > 0, x < 10 {
            return true
        }
        
        let str = "\(x)"
        var i = 0
        var j = str.count - 1
        
        while i < j {
            let start = str[str.index(str.startIndex, offsetBy: i)]
            let end = str[str.index(str.startIndex, offsetBy: j)]
            
            if start != end {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
    
    func reverse(_ x: Int) -> Int {
        let str = String("\(abs(x))".reversed())
        if x >= 0 {
            return Int(Int32(str) ?? 0)
        }
        return Int(Int32(-(Int32(str) ?? 0)))
    }
    
    func romanToInt(_ s: String) -> Int {
        let dic: [String: Int] = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000]
        var res: Int = 0
        var i = 0
        var nextVal: Int = 0
        while i < s.count {
            if i == s.count - 1 {
                if nextVal != 0 {
                    res += nextVal
                } else {
                    let cur = String(s[s.index(s.startIndex, offsetBy: i)])
                    res += dic[cur]!
                }
                break
            }
            
            var curVal = nextVal
            if curVal == 0 {
                let cur = String(s[s.index(s.startIndex, offsetBy: i)])
                curVal = dic[cur]!
            }
            let next = String(s[s.index(s.startIndex, offsetBy: i + 1)])
            nextVal = dic[next]!
            if curVal < nextVal {
                res += nextVal - curVal
                i += 2
                nextVal = 0
                continue
            }
            i += 1
            res += curVal
        }
        
        return res
    }
    
    //    func romanToInt(_ s: String) -> Int {
    //
    //        var dic:[String : Int] = ["I" : 1, "V" : 5, "X" : 10, "L" : 50, "C" : 100, "D" : 500, "M" : 1000]
    //        var res: Int = 0
    //        var i = 0
    //        while i < s.count {
    //            let cur = String(s[s.index(s.startIndex, offsetBy: i)])
    //            if i == s.count - 1{
    //                res += dic[cur]!
    //                break
    //            }
    //            let next = String(s[s.index(s.startIndex, offsetBy: i+1)])
    //            if dic[cur] == 1 , dic[next] == 5 {
    //                res += 4
    //                i += 2
    //                continue
    //            }
    //            if dic[cur] == 1 , dic[next] == 10 {
    //                res += 9
    //                i += 2
    //                continue
    //            }
    //            if dic[cur] == 10 , dic[next] == 50{
    //                res += 40
    //                i += 2
    //                continue
    //            }
    //            if dic[cur] == 10 , dic[next] == 100{
    //                res += 90
    //                i += 2
    //                continue
    //            }
    //            if dic[cur] == 100 , dic[next] == 500{
    //                res += 400
    //                i += 2
    //                continue
    //            }
    //            if dic[cur] == 100 , dic[next] == 1000{
    //                res += 900
    //                i += 2
    //                continue
    //            }
    //            i += 1
    //            res += dic[cur]!
    //        }
    //
    //        return res
    //    }
    
    /// 柯里化特性
    func add(_ num: Int) -> (Int) -> Int {
        func interAdd(_ val: Int) -> Int {
            return val + num
        }
        return interAdd
    }
}
