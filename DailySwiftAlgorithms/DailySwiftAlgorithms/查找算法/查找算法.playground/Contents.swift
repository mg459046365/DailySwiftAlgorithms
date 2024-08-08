import Foundation
// 顺序查找算法,时间复杂度O(n),空间复杂度O(1)，对于线性的单链表只能使用顺序查找算法
func sequentialFind(_ target: Int, in list: [Int]) -> Bool {
    for i in list {
        if i == target { return true }
    }
    return false
}

// 二分查找/折半查找,时间复杂度O(logn),空间复杂度O(1)，list必须有序，假设list里面元素是从小到大排序
func halfFind(_ target: Int, in list: [Int]) -> Bool {
    guard !list.isEmpty else { return false }
    var left = 0
    var right = list.count - 1
    while left <= right {
        let mid = (left + right) / 2
        if target == list[mid] { return true }
        if target < list[mid] {
            right = mid - 1
        }
        if target > list[mid] {
            left = mid + 1
        }
    }
    return false
}

// 插值查找，时间复杂度O(logn),空间复杂度O(1)，list必须有序，假设list里面元素是从小到大排序
// 插值查找与二分查找的区别，插值查找是二分查找的变体，在于分割点位置的选择，二分查找选中间位置
// 插值查找一般是a = (target - list[left])/(list[right] - list[left]),插值分割点位left + Int((right-left)*比例a)
// 数组元素较少或者数组中元素的分布不均匀时，插值查找的性能会比二分查找算法更差
func interpolationFind(_ target: Int, in list: [Int]) -> Bool {
    guard !list.isEmpty else { return false }
    var left = 0
    var right = list.count - 1
    while left <= right {
        let mid = left + (right - left) * (target - list[left]) / (list[right] - list[left]) // 这个是关键点，插值查找的分割点与二分的区别
        if target == list[mid] { return true }
        if target < list[mid] {
            right = mid - 1
        }
        if target > list[mid] {
            left = mid + 1
        }
    }
    return false
}

// 斐波那契查找算法也是二分法的一种变体，数组必须有序
// 在进行有序数组中元素的查找时，可以先在斐波那契数列中找到一个等于或大于数组中元素个数的数值F(n)，之后将数组进行斐波那契分割
// 即将数组分割成F(n-1)和F(n-2)两部分，分析出要查找的元素所在的那一部分后，继续进行斐波那契分割，直到找到元素或者无法再分割
func fibonacciFind(_ target: Int, in list: [Int]) -> Bool {
    guard !list.isEmpty else { return false }
    // 假设要查找的数组中的元素个数不超过144
    let F = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]
    let count = list.count
    var left = 0
    var right = count - 1
    var k = 0
    // 找到一个大于或等于元素个数的斐波那契数列中的数
    while F[k] < right {
        k += 1
    }
    while left <= right {
        // 进行越界检查
        if k <= 0 {
            k = 1
        }
        var mid = left + F[k - 1] - 1
        // 进行越界检查
        if mid > count - 1 {
            mid = count - 1
        }
        if mid < 0 {
            mid = 0
        }
        if target == list[mid] {
            return true
        }

        // 对F(n-1)在进行斐波那契分割
        if target < list[mid] {
            right = mid - 1
            k -= 1
        }
        // 对F(n-2)在进行斐波那契分割
        if target > list[mid] {
            left = mid + 1
            k -= 2
        }
    }
    return false
}

// 二叉查找树查找算法，时间复杂度是O(logn)
// 二叉查找树，①任意节点的左子树的值均小于当前节点的值，②任意节点的右子树的值均不小于当前节点的值，③任意节点的左右子树均是二叉查找树
fileprivate class Node {
    // 节点值
    let value: Int
    // 左子树
    var left: Node?
    // 右子树
    var right: Node?
    init(value: Int, left: Node? = nil, right: Node? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

func nodeFind(_ target: Int, in node: Node) -> Bool {
    var curNode: Node? = node
    while let nd = curNode {
        if target == nd.value {
            return true
        } else if target < nd.value {
            curNode = nd.left
        } else {
            curNode = nd.right
        }
    }
    return false
}

// 分块查找算法
// 分块查找算法是对顺序查找算法的一种优化，其首先需要将数组中的元素分割成多个部分，保证每个部分“块”之间有序，”块内可“可以无序。
// 在查找时，将"块"中最大的元素和其位置建立索引，进行元素查找时先从索引表中查找元素可能在的块，之后在块内进行顺序查找、
// blockArray为块，元组第一个为元素为最大的元素，第二个为其位置索引
func blockFind(_ target: Int, in list: [Int], blockArray: [(Int, Int)]) -> Bool {
    var nextIndex = 0
    for i in 0 ..< blockArray.count {
        if blockArray[i].0 > target {
            let index = blockArray[i].1
            if i < blockArray.count - 1 {
                nextIndex = blockArray[i + 1].1
            } else {
                nextIndex = blockArray.count - 1
            }
            for j in index ... nextIndex {
                if target == list[j] {
                    return true
                }
            }
        }
    }
    return false
}

