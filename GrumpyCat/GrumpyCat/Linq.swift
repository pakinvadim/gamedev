//
//  Linq.swift
//  GrumpyCat
//
//  Created by admin on 23.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation

extension Array {
    func ForEach(fn: (T) -> ()) {
        for i in self {
            fn(i)
        }
    }
    
    func Find(fn: (T) -> Bool) -> [T] {
        var to = [T]()
        for x in self {
            let t = x as T
            if fn(t) {
                to.append(t)
            }
        }
        return to
    }
    
    func IndexOf<T : Equatable>(x:T) -> Int? {
        for i in 0..<self.count {
            if self[i] as T == x {
                return i
            }
        }
        return nil
    }
    
    func Any(fn: (T) -> Bool) -> Bool {
        return self.Find(fn).count > 0
    }
    
    func All(fn: (T) -> Bool) -> Bool {
        return self.Find(fn).count == self.count
    }
    
    func Sum<T : Addable>() -> T {
        return self.map { $0 as T }.reduce(T()) { $0 + $1 }
    }
    
    func Sum<U, T : Addable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T()) { $0 + $1 }
    }
    
    func Min<T : Reducable>() -> T {
        return self.map { $0 as T }.reduce(T.max()) { $0 < $1 ? $0 : $1 }
    }
    
    func Min<U, T : Reducable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T.max()) { $0 < $1 ? $0 : $1 }
    }
    
    func Max<T : Reducable>() -> T {
        return self.map { $0 as T }.reduce(T()) { $0 > $1 ? $0 : $1 }
    }
    
    func Max<U, T : Reducable>(fn: (U) -> T) -> T {
        return self.map { fn($0 as U) }.reduce(T()) { $0 > $1 ? $0 : $1 }
    }
    
    func Avg<T : Averagable>() -> Double{
        return self.map { $0 as T }.reduce(T()) { $0 + $1 } / self.count
    }
    
    func Avg<U, T : Averagable>(fn: (U) -> T) -> Double {
        return self.map { fn($0 as U) }.reduce(T()) { $0 + $1 } / self.count
    }
    
    func FirstOrDefault(fn: (T) -> Bool) -> T? {
        for x in self {
            if fn(x) {
                return x
            }
        }
        return nil
    }
    
    func LastOrDefault(fn: (T) -> Bool) -> T? {
        for x in self.reverse() {
            if fn(x) {
                return x
            }
        }
        return nil
    }
    
    func Skip(count:Int) -> [T] {
        var to = [T]()
        var i = count
        while i < self.count {
            to.append(self[i++])
        }
        return to
    }
}

protocol Addable {
    func +(lhs: Self, rhs: Self) -> Self
    init()
}

protocol Reducable : Addable, Averagable, Comparable {
    class func max() -> Self
}

protocol Averagable : Addable {
    func /(lhs: Self, rhs: Int) -> Double
}

extension Int : Reducable {
    static func max() -> Int {
        return Int.max
    }
}

extension Double : Reducable {
    static func max() -> Double {
        return Double(Int.max)
    }
}

extension CGFloat : Reducable {
    static func max() -> CGFloat {
        return CGFloat(Int.max)
    }
}

func /(lhs: Int, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}

func /(lhs: Double, rhs: Int) -> Double {
    return lhs / Double(rhs)
}

func /(lhs: CGFloat, rhs: Int) -> Double {
    return Double(lhs) / Double(rhs)
}
