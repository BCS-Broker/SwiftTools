//
//  Array+.swift
//  BCSSwiftTools
//
//  Created by Alexey Nenastev on 13.05.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    
    func currentIndexOfFatal(for element: Element) -> Int {
        firstIndex(of: element)!
    }
    
    func next(current: Element, doWithNext: (Element) -> Void, or: () -> Void) {
        let currentIndex = currentIndexOfFatal(for: current)
        if  count - 1 == currentIndex {
            or()
        } else {
            let nextIndex = index(after: currentIndex)
            let nextElement = self[nextIndex]
            doWithNext(nextElement)
        }
    }
    
    func previous(current: Element, doWithPrevious: (Element) -> Void, or: () -> Void) {
        let currentIndex = currentIndexOfFatal(for: current)
        if  0 == currentIndex {
            or()
        } else {
            let beforeIndex = index(before: currentIndex)
            let breforeElement = self[beforeIndex]
            doWithPrevious(breforeElement)
        }
    }
}

public extension Array {
    
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func sum(path: KeyPath<Element, Double>) -> Double {
          return self.reduce(0) { $0 + $1[keyPath: path] }
      }
}
 
