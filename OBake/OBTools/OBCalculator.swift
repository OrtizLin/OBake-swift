//
//  OBCalculator.swift
//  OBake
//
//  Created by Otis on 2019/4/26.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit

protocol WeightConvertion {
    func weightConvertValue(type: WeightType , value: Double) -> Weight
    func sizeConvertResult(magnification: Double, value: Weight) -> Weight
    func updateNowValue(_ tag: Int, Value: String) -> String
    func valueChange(_ x1:String, y1:String, z1:String, x2:String, y2:String, z2:String, type:ShapeSelect) -> String
    func updatePath(_ x:Int, y:Int, z:Int, circle: Bool) -> UIBezierPath
    func magnificationChange(_ x1:Int, y1:Int, z1:Int, x2:Int, y2:Int, z2:Int, type:ShapeSelect) -> String
}

class WeightConvert: WeightConvertion {
   
    static let shared = WeightConvert()
    var firstString = ""
    var secondString = ""
    
    func weightConvertValue(type: WeightType, value: Double) -> Weight {
        // base on the unit user select, convert others.
        var basic: Double = 0
        
        switch type {
        case .kg:
            basic = value
        case .g:
            basic = value / 1000
        case .twCatty:
            basic = value * 0.6
        case .lb:
            basic = value * 0.453
        case .oz:
            basic = value * 0.028
        }
        
        let weight = Weight(kg: round(100*basic)/100, g: round(1000*100*basic)/100, twCatty: round(100 * 1.66 * basic)/100 , lb:round(100 * 2.2 * basic)/100, oz:round(100 * 35.2 * basic)/100)
        
        return weight
    }
    
    func sizeConvertResult(magnification: Double, value: Weight) -> Weight {
        let weight = Weight(kg: round(100*value.kg!*magnification)/100, g: round(100*value.g!*magnification)/100, twCatty: round(100*value.twCatty!*magnification)/100, lb: round(100*value.lb!*magnification)/100, oz: round(100*value.oz!*magnification)/100)
        
        return weight
    }
    
    func updateNowValue(_ tag: Int, Value: String) -> String {
        var nowValue = Value
        
        if tag == 100{
                nowValue += "."
        }
        else if tag != 999 {
            if nowValue == "empty"{
                nowValue = String(tag)
            }
            else{
                nowValue += String(tag)
            }
        }
        return nowValue
        
    }
    
    func valueChange(_ x1: String, y1: String, z1: String, x2: String, y2: String, z2: String, type: ShapeSelect) -> String {
        switch type {
        case .circleToCircle:
            firstString = "圓形 \(x1) 吋 , 高 : \(z1)"
            secondString = "圓形 \(x2) 吋 , 高 : \(z2)"
        case .circleToSquare:
            firstString = "圓形 \(x1) 吋 , 高 : \(z1)"
            secondString = "方形 \(x2) x \(y2) x \(z2)"
        case .squareToSquare:
            firstString = "方形 \(x1) x \(y1) x \(z1)"
            secondString = "方形 \(x2) x \(y2) x \(z2)"
        case .squareToCircle:
            firstString = "方形 \(x1) x \(y1) x \(z1)"
            secondString = "圓形 \(x2) 吋 , 高 : \(z2)"
        }
        return firstString + " -> " + secondString
        
    }
    
    func updatePath(_ x: Int, y: Int, z: Int, circle: Bool) -> UIBezierPath {
        //draw square
        if circle == false {
            let path = UIBezierPath()
            var point = CGPoint(x: 0+x, y: 0-x)
            path.move(to: point)
            point = CGPoint(x: 50+y+x, y: 0-x)
            path.addLine(to: point)
            point = CGPoint(x: 5+y, y: 20)
            path.addLine(to: point)
            point = CGPoint(x: -50, y: 20)
            path.addLine(to: point)
            point = CGPoint(x: 0+x, y: 0-x)
            path.addLine(to: point)
            point = CGPoint(x: -50, y: 20)
            path.addLine(to: point)
            point = CGPoint(x: -50, y: 37+z)
            path.addLine(to: point)
            point = CGPoint(x: 5+y, y: 37+z)
            path.addLine(to: point)
            point = CGPoint(x: 5+y, y: 20)
            path.addLine(to: point)
            point = CGPoint(x: 50+y+x, y: 0-x)
            path.addLine(to: point)
            point = CGPoint(x: 50+y+x, y: 17+z-x)
            path.addLine(to: point)
            point = CGPoint(x: 5+y, y: 37+z)
            path.addLine(to: point)

            return path
        }
        // draw circle
        else {
            let path =  UIBezierPath(ovalIn: CGRect(x: -32-x, y: -20-z, width: 65+x, height: 60+x))
            var point = CGPoint(x: -32-x, y: 15-z)
            path.move(to: point)
            point = CGPoint(x: -30-x, y: 45+x)
            path.addLine(to: point)
            path.addCurve(to: CGPoint(x:31, y: 45+x), controlPoint1: CGPoint(x: -13-x, y: 65+x+x), controlPoint2: CGPoint(x: 12, y: 65+x+x))
            point = CGPoint(x: 33, y: 15-z)
            path.addLine(to: point)
            
            return path
        }
    }
    
    func magnificationChange(_ x1: Int, y1: Int, z1: Int, x2: Int, y2: Int, z2: Int, type: ShapeSelect) -> String {
        switch type {
        case .circleToCircle:
            return String(format: "%.2f",(Double(x2) * Double(x2) * Double(Float.pi) * Double(z2))/(Double(x1) * Double(x1) * Double(Float.pi) * Double(z1)))
        case .circleToSquare:
            return String(format: "%.2f",(Double(x2) * Double(x2) * Double(Float.pi) * Double(z2))/(Double(x1) * Double(y1) * Double(z1)))
        case .squareToSquare:
            return String(format: "%.2f",(Double(x2) * Double(y2) * Double(z2))/(Double(x1) * Double(y1) * Double(z1)))
        case .squareToCircle:
            return String(format: "%.2f",(Double(x2) * Double(y2) * Double(z2))/(Double(x1) * Double(x1) * Double(Float.pi) * Double(z1)))
        }
    }

}

//updateNowValue tag
// 0 = 0, 1 = 1, 2 = 2, ..... 9 = 9
// 100 = .
// 999 = back
