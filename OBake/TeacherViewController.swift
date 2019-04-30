//
//  TeacherViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/25.
//  Copyright © 2019 Otis. All rights reserved.
//

import UIKit

class TeacherViewController: UIViewController {
    var teachers: [TeacherData]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad(){
        super.viewDidLoad()
        teachers = getFakeDataArray()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        setNavBackBotton()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension TeacherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeacherTableViewCell", for: indexPath) as! TeacherTableViewCell
        cell.nameLabel.text = teachers?[indexPath.row].Name
        let str = "經歷: \n" + (teachers?[indexPath.row].Class)!
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 5
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.paragraphStyle: paraph]
        cell.resumeLabel.attributedText = NSAttributedString(string: str, attributes: attributes)
        cell.photoImageView?.loadImageUsingCacheWithUrlString(urlString: (teachers?[indexPath.row].ImageUrl)!)
        cell.photoImageView?.contentMode = .scaleAspectFit
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension TeacherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "師資介紹"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    self.performSegue(withIdentifier: "teacherDetail", sender: nil)
     
    }
}

extension TeacherViewController {
    func getFakeDataArray() -> [TeacherData] {
        let dataOne = TeacherData(Name: "李大華", Class: "法國藍帶美國舊金山分校第一名畢業. 義大利Sorrento專研義式傳統料理. 美國紐約ICE(Institute of Culinary Education)烹飪學校學習甜點", ImageUrl: "https://i.imgur.com/15vFKUC.jpg")
        let dataSecond = TeacherData(Name: "林中強", Class: "2018 T.U.C.C 泰國廚藝挑戰賽,西式職業組個人現場烹調. 1.鯖魚烹調（銅牌）2.羊肉烹調（銅牌）3.亞洲菜烹調（佳作）4.豬雞雙拼烹調（銀牌）", ImageUrl: "https://i.imgur.com/MO5fvJa.jpg")
        let dataThird = TeacherData(Name: "康小龍", Class: "美而美餐飲集團積極轉型，除旗下早餐品牌「瑞麟美而美」推出全新旗艦店型，更跨足冰品與手搖飲料，推出「康青龍」", ImageUrl: "https://i.imgur.com/og2lmPH.jpg")
        
        var dataArray = [TeacherData]()
        dataArray.append(dataOne)
        dataArray.append(dataSecond)
        dataArray.append(dataThird)
        
        return dataArray
    }
}
