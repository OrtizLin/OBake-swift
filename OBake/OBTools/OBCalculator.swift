//
//  OBCalculator.swift
//  OBake
//
//  Created by Otis on 2019/4/26.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation

protocol WeightConvertion {
    func weightConvertValue(type: WeightType , value: Double) -> Weight
    func sizeConvertValue(type: SizeType, value: Weight) -> Weight
    func updateNowValue(_ tag: Int, Value: String) -> String
}

class WeightConvert: WeightConvertion {
    
    static let shared = WeightConvert()
    
    func weightConvertValue(type: WeightType, value: Double) -> Weight {
        
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
    
    func sizeConvertValue(type: SizeType, value: Weight) -> Weight {
        
        var basic: Double = 0
        
        switch type {
        case .none: basic = 1.0
        case .fourToEight: basic = 2.8
        case .fourToSix: basic = 1.8
        case .SixToFour: basic = 0.6
        case .SixToEight: basic = 1.78
        case .EightToFour: basic = 0.4
        case .EightToSix: basic = 0.56
        }
        let weight = Weight(kg: round(100*value.kg!*basic)/100, g: round(100*value.g!*basic)/100, twCatty: round(100*value.twCatty!*basic)/100, lb: round(100*value.lb!*basic)/100, oz: round(100*value.oz!*basic)/100)
        
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

}
