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

enum SizeType: String, CaseIterable{
    case none = "轉換成你要的尺寸"
    case fourToSix = "4->6"
    case fourToEight = "4->8"
    case SixToEight = "6->8"
    case SixToFour = "6->4"
    case EightToSix = "8->6"
    case EightToFour = "8->4"
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


