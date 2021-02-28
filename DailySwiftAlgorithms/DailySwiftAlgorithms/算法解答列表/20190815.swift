//
//  20190815.swift
//  DailySwiftAlgorithms
//
//  Created by Beryter on 2019/8/15.
//  Copyright © 2019 Beryter. All rights reserved.
//

/// 实现LRU(Least Recently Used)，最近最少使用。暂未考虑线程安全的问题。双向链表

import Foundation

fileprivate class LRUNode {
    let key: String!
    var value: Int!
    var pre: LRUNode?
    var next: LRUNode?
    init(key: String, value: Int) {
        self.key = key
        self.value = value
    }
}


class LRUCache {
    private var head: LRUNode?
    private var end: LRUNode?
    private var map = [String: LRUNode]()
    ///缓存上限
    private var limit: Int
    
    init(limit: Int) {
        self.limit = limit
    }
    
    /// 获取某个key对应的值
    func getValue(withKey key: String) -> Int? {
        guard !key.isEmpty else { return nil }
        guard let node = map[key] else { return nil }
        return node.value
    }
    
    func remove(withKey key: String) -> (String, Int)? {
        guard let node = map[key] else { return nil }
        removeNode(node)
        return (node.key, node.value)
    }
    
    func put(key: String, value: Int) {
        guard !key.isEmpty else { return }
        if let node = map[key] {
            //存在key
            node.value = value
            refreshNode(node)
            return
        }
        //key不存在
        let n = LRUNode(key: key, value: value)
        if map.count >= limit {
            //删除头结点
            removeNode(head!)
        }
        addNode(n)
    }
    
    private func refreshNode(_ node: LRUNode) {
        if node.key == end?.key {
            //尾节点无需移动
            return
        }
        removeNode(node)
        addNode(node)
    }
    
    /// 尾部插入节点
    private func addNode(_ node: LRUNode) {
        map[node.key] = node
        if let ed = end {
            ed.next = node
            node.pre = ed
        }
        end = node
        if head == nil {
            head = node
        }
    }
    
    /// 删除节点
    private func removeNode(_ node: LRUNode) {
        let hd = node.pre
        let nt = node.next
        map.removeValue(forKey: node.key)
        if node.key == head?.key, node.key == end?.key {
            //唯一一条数据
            head = nil
            end = nil
        }else if node.key == end?.key {
            //删除尾节点
            hd?.next = nil
        }else if node.key == head?.key {
            //删除头结点
            nt?.pre = nil
        }else {
            //删除中间节点
            hd?.next = nt
            nt?.pre = hd
        }
    }
}

