//
//  Cache.swift
//  Astronomy
//
//  Created by Mitchell Budge on 10/3/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class Cache<Key: Hashable, Value> {
    
    // a place for items to be cached
    private var cache = [Key : Value]()
    // serial queue so that everyone can use shared resources without using NSLock
    private var queue = DispatchQueue(label: "com.LambdaSchool.Astronomy.ConcurrentOperationStateQueue")
    
    // have a function to add items to the cache
    func cache(value: Value, key: Key) {
        queue.async {
            self.cache[key] = value
        }
    }
    
    // have a function to returns items that are cache
    func value(key: Key) -> Value? {
        return queue.sync {
            cache[key]
        }
    }
}
