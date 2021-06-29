//
//  ThreadSafeDictionary.swift
//  SwiftTools
//
//  Created by Andrey Raevnev on 04/10/2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

import Foundation

/// A thread-safe dictionary
@available(*, deprecated, message: "Refactoring needed, unsafe threading")
public class ThreadSafeDictionary<Key: Hashable, Value> {
    private let queue = DispatchQueue(label: "swifttools.ThreadSafeDictionary", attributes: .concurrent)
    private var dictionary = [Key: Value]()
    
    public init() { }
    
    public convenience init(_ dictionary: [Key: Value]) {
        self.init()
        self.dictionary = dictionary
    }
}

// MARK: - Properties
public extension ThreadSafeDictionary {
    
    /// The first element of the collection.
    var keys: Dictionary<Key, Value>.Keys? {
        var keys: Dictionary<Key, Value>.Keys?
        queue.sync { keys = self.dictionary.keys }
        return keys
    }
 
    /// The number of elements in the array.
    var count: Int {
        var result = 0
        queue.sync { result = self.dictionary.count }
        return result
    }
    
    /// A Boolean value indicating whether the collection is empty.
    var isEmpty: Bool {
        var result = false
        queue.sync { result = self.dictionary.isEmpty }
        return result
    }
    
    /// A textual representation of the array and its elements.
    var description: String {
        var result = ""
        queue.sync { result = self.dictionary.description }
        return result
    }
}


// MARK: - Immutable
public extension ThreadSafeDictionary {
    
    func contains(where predicate: ((key: Key, value: Value)) -> Bool) -> Bool {
        var result = false
        queue.sync { result = self.dictionary.contains(where: predicate) }
        return result
    }
    
}

public extension ThreadSafeDictionary {
    
    subscript(key: Key) -> Value? {
        get {
            var result: Value?
            queue.sync { result = self.dictionary[key] }
            return result
        }
        set {
            guard let newValue = newValue else { return }
            queue.async(flags: .barrier) {
                self.dictionary[key] = newValue
            }
        }
    }
    
    func removeValue(forKey key: Key, completion: ((Value?) -> Void)? = nil) {
        queue.async(flags: .barrier) {
            let value = self.dictionary.removeValue(forKey: key)
            DispatchQueue.main.async { completion?(value) }
        }
    }
    
}

