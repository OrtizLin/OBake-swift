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
        teachers = TeacherManager.shared.getFakeTeacherArray()
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
        let str = "經歷: \n" + (teachers?[indexPath.row].Resume)!
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
       
    self.performSegue(withIdentifier: "teacherDetail", sender: indexPath)
     
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
            segue.identifier == "teacherDetail" {
            let viewController = segue.destination as! TeacherDetailViewController
            viewController.teacherIndex = indexPath.row
        }
    }
}


