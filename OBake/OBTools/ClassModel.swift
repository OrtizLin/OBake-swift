//
//  ClassModel.swift
//  OBake
//
//  Created by Otis on 2019/5/2.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation

struct ClassData {
    var Name : String
    let CourseTime : String
    var ImageUrl : String
    var lastCount : Int
    var Intro : String
    
    init() {
        let now:Date = Date()
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日"
        let dateString:String = dateFormat.string(from: now)
        CourseTime = dateString
        Name = ""
        ImageUrl = ""
        Intro = ""
        lastCount = 0
    }
}

protocol ClassManageable {
    func getFakeClassArray() -> [ClassData]
}

class ClassManager: ClassManageable {
    
    static let shared = ClassManager()
    
    func getFakeClassArray() -> [ClassData] {
        var dataOne = ClassData.init()
        dataOne.ImageUrl = "https://i.imgur.com/UYyw6Mu.jpg"
        dataOne.lastCount = 4
        dataOne.Name = "布丁狗的好吃戚風蛋糕"
        dataOne.Intro = "鬆軟的戚風蛋糕是家中最常烘烤的蛋糕，只要掌握住幾個基本步驟，注意蛋白霜確實打發，混合過程不要過度，不需要添加任何膨脹劑，蓬鬆柔軟的蛋糕就能夠完美出爐。"
    
        var dataTwo = ClassData.init()
        dataTwo.ImageUrl = "https://i.imgur.com/BN2FJuY.jpg"
        dataTwo.lastCount = 0
        dataTwo.Name = "酷企鵝的香甜橙條"
        dataTwo.Intro = "橙皮經過蜜漬，再批覆上苦甜巧克力，橙橘果酸與苦甜巧克力完美的結合，讓人愛不釋手！"
        
        var dataThree = ClassData.init()
        dataThree.ImageUrl = "https://i.imgur.com/kFgx9OT.jpg"
        dataThree.lastCount = 30
        dataThree.Name = "美樂蒂的難吃巧克力"
        dataThree.Intro = "每當心情不好、生理期或者想吃甜食時，就會想到巧克力，它能給人帶來安寧的感覺，並能消除緊張情緒、緩解壓力。但你知道巧克力種類有哪些嗎？"
        
        var dataArray = [ClassData]()
            dataArray.append(dataOne)
            dataArray.append(dataTwo)
            dataArray.append(dataThree)
        
        return dataArray
    }
}
