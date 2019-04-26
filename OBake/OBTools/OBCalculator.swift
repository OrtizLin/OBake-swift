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
        
        let weight = Weight(kg: round(1000*basic)/1000, g: round(1000*1000*basic)/1000, twCatty: round(1000 * 1.66 * basic)/1000 , lb:round(1000 * 2.2 * basic)/1000, oz:round(1000 * 35.2 * basic)/1000)
        
        return weight
    }
    
    func sizeConvertValue(type: SizeType, value: Weight) -> Weight {
        
        var basic: Double = 0
        
        switch type {
        case .fourToEight:
            basic = 2.8
        case .fourToSix:
            basic = 1.8
        case .SixToFour:
            basic = 0.6
        case .SixToEight:
            basic = 1.78
        case .EightToFour:
            basic = 0.4
        case .EightToSix:
            basic = 0.56
        }
        let weight = Weight(kg: value.kg! * basic, g: value.g! * basic, twCatty: value.twCatty! * basic, lb: value.lb! * basic, oz: value.oz! * basic)
        
        return weight
    }
    
}
