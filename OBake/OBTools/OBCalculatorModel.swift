//
//  OBCalculatorModel.swift
//  OBake
//
//  Created by Otis on 2019/4/26.
//  Copyright © 2019年 Otis. All rights reserved.
//

import Foundation

enum WeightType {
    case kg
    case g
    case twCatty
    case lb
    case oz
}

class Weight {
    var kg: Double?
    var g: Double?
    var twCatty: Double?
    var lb: Double?
    var oz: Double?
    
    init(kg: Double, g: Double, twCatty: Double, lb: Double, oz: Double){
        self.kg = kg
        self.g = g
        self.twCatty = twCatty
        self.lb = lb
        self.oz = oz
    }
}

protocol WeightConvertion {
    func weightConvertValue(type: WeightType , value: Double) -> Weight
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
        
        let weight = Weight(kg: basic, g: basic * 1000, twCatty: basic * 1.66, lb: basic * 2.2, oz: basic * 35.2)
        
        return weight
    }
    
}
