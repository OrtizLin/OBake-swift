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

enum ShapeSelect: Int {
    case circleToCircle = 0
    case circleToSquare = 1
    case squareToSquare = 2
    case squareToCircle = 3
}

class Weight {
    var kg: Double?
    var g: Double?
    var twCatty: Double?
    var lb: Double?
    var oz: Double?
    
    init(kg: Double, g: Double, twCatty: Double, lb: Double, oz: Double) {
        self.kg = kg
        self.g = g
        self.twCatty = twCatty
        self.lb = lb
        self.oz = oz
    }
}


