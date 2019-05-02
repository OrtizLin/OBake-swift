//
//  TeacherModel.swift
//  OBake
//
//  Created by Otis on 2019/4/30.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation

struct TeacherData {
    let Name : String
    let Resume : String
    let ImageUrl : String
    let Title : String
}

protocol TeacherManageable {
    func getFakeTeacherArray() -> [TeacherData]
}

class TeacherManager: TeacherManageable {
   
    static let shared = TeacherManager()
    
    func getFakeTeacherArray() -> [TeacherData] {
      
        let dataOne = TeacherData(Name: "李大華", Resume: "法國藍帶美國舊金山分校第一名畢業. 義大利Sorrento專研義式傳統料理. 美國紐約ICE(Institute of Culinary Education)烹飪學校學習甜點", ImageUrl: "https://i.imgur.com/15vFKUC.jpg", Title: "我最棒棒！")
        let dataSecond = TeacherData(Name: "林中強", Resume: "2018 T.U.C.C 泰國廚藝挑戰賽  西式職業組個人現場烹調 1.鯖魚烹調（銅牌）2.羊肉烹調（銅牌）3.亞洲菜烹調 （佳作）4.豬雞雙拼烹調（銀牌）2016年亞洲名廚精英薈料理廚藝比賽(個人賽) 金牌獎2016年亞洲名廚精英薈料理廚藝比賽(團體賽) 最佳造型獎", ImageUrl: "https://i.imgur.com/MO5fvJa.jpg", Title: "GOGOGO!")
        let dataThird = TeacherData(Name: "康小龍", Resume: "美而美餐飲集團積極轉型，並朝向多角化經營，除旗下早餐品牌「瑞麟美而美」推出全新旗艦店型，更跨足冰品與手搖飲料，推出「思慕昔」與「康青龍」兩大品牌，事業版圖已擴及中國大陸、韓國，今年預計往東南亞、日本等地發展，全力搶攻海外市場商機。"
           , ImageUrl: "https://i.imgur.com/og2lmPH.jpg", Title: "雙北最好喝飲料")
            
            var dataArray = [TeacherData]()
            dataArray.append(dataOne)
            dataArray.append(dataSecond)
            dataArray.append(dataThird)
            
            return dataArray
    }
    
}
