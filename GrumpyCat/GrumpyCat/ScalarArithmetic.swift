//
//  ScalarArithmetic.swift
//  GrumpyCat
//
//  Created by admin on 10.10.14.
//  Copyright (c) 2014 COON. All rights reserved.
//

import Foundation
//import CoreGraphics

/*protocol ScalarFloatingPointType {
    var toDouble:Double { get }
    var toFloat:Float { get }
    init(_ value:Double)
}

extension CGFloat : ScalarFloatingPointType {
    var toDouble:Double { return Double(self)}
    var toFloat:Float { return Float(self)}
}

extension Float : ScalarFloatingPointType {
    var toDouble:Double { return Double(self)}
    var toFloat:Float { return Float(self)}
}

protocol ScalarIntegerType : ScalarFloatingPointType {
    var toInt:Int { get }
}

extension Int : ScalarIntegerType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    var toInt:Int { return Int(self) }
    
}
extension Int16 : ScalarIntegerType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    var toInt:Int { return Int(self) }
    
}
extension Int32 : ScalarIntegerType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    var toInt:Int { return Int(self) }
    
}
extension Int64 : ScalarIntegerType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    var toInt:Int { return Int(self) }
    
}
extension UInt : ScalarFloatingPointType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    
}
extension UInt16  : ScalarFloatingPointType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    
}
extension UInt32 : ScalarFloatingPointType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
}
extension UInt64 : ScalarFloatingPointType {
    var toDouble:Double { return Double(self) }
    var toFloat:Float { return Float(self)}
    func _conversion() -> Double { return Double(self) }
    
}



func + <T:ScalarIntegerType>(lhs:T, rhs:Int) -> Int { return lhs + rhs }
func + <T:ScalarIntegerType>(lhs:Int, rhs:T) -> Int { return lhs + rhs.toInt }

func - <T:ScalarIntegerType>(lhs:T, rhs:Int) -> Int { return lhs.toInt - rhs }
func - <T:ScalarIntegerType>(lhs:Int, rhs:T) -> Int { return lhs - rhs.toInt }

func * <T:ScalarIntegerType>(lhs:T, rhs:Int) -> Int { return lhs.toInt * rhs }
func * <T:ScalarIntegerType>(lhs:Int, rhs:T) -> Int { return lhs * rhs.toInt }

func / <T:ScalarIntegerType>(lhs:T, rhs:Int) -> Int { return lhs.toInt / rhs }
func / <T:ScalarIntegerType>(lhs:Int, rhs:T) -> Int { return lhs / rhs.toInt }

/*func < (lhs:CGFloat, rhs:CGFloat) -> Bool { return Float(lhs) < Float(rhs) }
func < (lhs:Float, rhs:CGFloat) -> Bool { return lhs < Float(rhs) }
func < (lhs:CGFloat, rhs:Float) -> Bool { return Float(lhs) < rhs }
func > (lhs:CGFloat, rhs:CGFloat) -> Bool { return lhs.toFloat > rhs.toFloat }
func > (lhs:Float, rhs:CGFloat) -> Bool { return lhs > rhs.toFloat }
func > (lhs:CGFloat, rhs:Float) -> Bool { return lhs.toFloat > rhs }
func <= (lhs:CGFloat, rhs:CGFloat) -> Bool { return (lhs.toFloat <= rhs.toFloat) }
func <= (lhs:Float, rhs:CGFloat) -> Bool { return (lhs <= rhs.toFloat) }
func <= (lhs:CGFloat, rhs:Float) -> Bool { return (lhs.toFloat <= rhs) }
func >= (lhs:CGFloat, rhs:CGFloat) -> Bool { return lhs.toFloat >= rhs.toFloat }
func >= (lhs:Float, rhs:CGFloat) -> Bool { return lhs >= rhs.toFloat }
func >= (lhs:CGFloat, rhs:Float) -> Bool { return lhs.toFloat >= rhs }*/



//Equality T<===>T
/*func == <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:U,rhs:T) -> Bool { return (lhs.toDouble == rhs.toDouble) }
func == <T:ScalarFloatingPointType> (lhs:Double,rhs:T) -> Bool { return (lhs == rhs.toDouble) }
func == <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs.toDouble == rhs) }

func != <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:U,rhs:T) -> Bool { return (lhs.toDouble == rhs.toDouble) == false }
func != <T:ScalarFloatingPointType> (lhs:Double,rhs:T) -> Bool { return (lhs == rhs.toDouble) == false }
func != <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs.toDouble == rhs) == false }

func <= <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:T,rhs:U) -> Bool { return (lhs.toDouble <= rhs.toDouble) }
func <= <T:ScalarFloatingPointType> (lhs:Double, rhs:T) -> Bool { return (lhs <= rhs.toDouble) }
func <= <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs.toDouble <= rhs) }

func < <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:T,rhs:U) -> Bool { return (lhs.toDouble <  rhs.toDouble) }
func < <T:ScalarFloatingPointType> (lhs:Double, rhs:T) -> Bool { return (lhs <  rhs.toDouble) }
func < <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs.toDouble <  rhs) }

func >  <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:T,rhs:U) -> Bool { return (lhs <= rhs) == false }
func >  <T:ScalarFloatingPointType> (lhs:Double, rhs:T) -> Bool { return (lhs <= rhs) == false}
func >  <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs <= rhs) == false }

func >= <T:ScalarFloatingPointType, U:ScalarFloatingPointType> (lhs:T,rhs:U) -> Bool { return (lhs < rhs) == false }
func >= <T:ScalarFloatingPointType> (lhs:Double, rhs:T) -> Bool { return (lhs < rhs) == false }
func >= <T:ScalarFloatingPointType> (lhs:T,rhs:Double) -> Bool { return (lhs < rhs) == false }*/



//Double
//SUBTRACTION
func - <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(lhs:U, rhs:T) -> Double  {return (lhs.toDouble - rhs.toDouble) }
func - <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> T  { return T(lhs - rhs.toDouble) }
func - <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> T  { return T(lhs.toDouble - rhs) }
func - <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> Double  { return (lhs - rhs.toDouble) }
func - <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> Double  { return (lhs.toDouble - rhs) }
func -= <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(inout lhs:T, rhs:U) { lhs = T(lhs.toDouble - rhs.toDouble) }
func -= <T:ScalarFloatingPointType>(inout lhs:Double, rhs:T)  { lhs = lhs - rhs.toDouble }

//ADDITION
func + <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(lhs:U, rhs:T) -> Double  {return (lhs.toDouble + rhs.toDouble) }
func + <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> T  { return T(lhs + rhs.toDouble) }
func + <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> T  { return T(lhs.toDouble + rhs) }
func + <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> Double  { return (lhs + rhs.toDouble) }
func + <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> Double  { return (lhs.toDouble + rhs) }
func += <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(inout lhs:T, rhs:U) { lhs = T(lhs.toDouble + rhs.toDouble) }
func += <T:ScalarFloatingPointType>(inout lhs:Double, rhs:T)  { lhs = lhs + rhs.toDouble }

//MULTIPLICATION
func * <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(lhs:U, rhs:T) -> Double  {return (lhs.toDouble * rhs.toDouble) }
func * <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> T  { return T(lhs * rhs.toDouble) }
func * <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> T  { return T(lhs.toDouble * rhs) }
func * <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> Double  { return (lhs * rhs.toDouble) }
func * <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> Double  { return (lhs.toDouble * rhs) }
func *= <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(inout lhs:T, rhs:U) { lhs = T(lhs.toDouble * rhs.toDouble) }
func *= <T:ScalarFloatingPointType>(inout lhs:Double, rhs:T)  { lhs = lhs * rhs.toDouble }

//DIVISION
func / <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(lhs:U, rhs:T) -> Double  {return (lhs.toDouble / rhs.toDouble) }
func / <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> T  { return T(lhs / rhs.toDouble) }
func / <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> T  { return T(lhs.toDouble / rhs) }
func / <T:ScalarFloatingPointType>(lhs:Double, rhs:T) -> Double  { return (lhs / rhs.toDouble) }
func / <T:ScalarFloatingPointType>(lhs:T, rhs:Double) -> Double  { return (lhs.toDouble / rhs) }
func /= <T:ScalarFloatingPointType, U:ScalarFloatingPointType>(inout lhs:T, rhs:U) { lhs = T(lhs.toDouble / rhs.toDouble) }
func /= <T:ScalarFloatingPointType>(inout lhs:Double, rhs:T)  { lhs = lhs / rhs.toDouble }


//Float
//SUBTRACTION
func - <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> T  { return T(lhs.toDouble - rhs.toDouble) }
func - <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> T  { return T(lhs.toDouble - rhs) }
func - <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> Double  { return (lhs.toDouble - rhs.toDouble) }
func - <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> Double  { return (lhs.toDouble - rhs.toDouble) }
func -= <T:ScalarFloatingPointType>(inout lhs:Float, rhs:T)  { lhs = lhs - rhs.toFloat }

//ADDITION
func + <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> T  { return T(lhs + rhs.toDouble) }
func + <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> T  { return T(lhs.toDouble + rhs) }
func + <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> Double  { return (lhs + rhs.toDouble) }
func + <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> Double  { return (lhs.toDouble + rhs) }
func += <T:ScalarFloatingPointType>(inout lhs:Float, rhs:T)  { lhs = lhs + rhs.toDouble }

//MULTIPLICATION
func * <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> T  { return T(lhs * rhs.toDouble) }
func * <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> T  { return T(lhs.toDouble * rhs) }
func * <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> Double  { return (lhs * rhs.toDouble) }
func * <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> Double  { return (lhs.toDouble * rhs) }
func *= <T:ScalarFloatingPointType>(inout lhs:Float, rhs:T)  { lhs = lhs * rhs.toDouble }

//DIVISION
func / <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> T  { return T(lhs / rhs.toDouble) }
func / <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> T  { return T(lhs.toDouble / rhs) }
func / <T:ScalarFloatingPointType>(lhs:Float, rhs:T) -> Double  { return (lhs / rhs.toDouble) }
func / <T:ScalarFloatingPointType>(lhs:T, rhs:Float) -> Double  { return (lhs.toDouble / rhs) }
func /= <T:ScalarFloatingPointType>(inout lhs:Float, rhs:T)  { lhs = lhs / rhs.toDouble }*/


