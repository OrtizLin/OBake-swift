//
//  ClassViewController.swift
//  OBake
//
//  Created by Otis on 2019/5/2.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit

class ClassViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad(){
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        setNavBackBotton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ClassViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ClassManager.shared.getFakeClassArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassTableViewCell" , for: indexPath) as! ClassTableViewCell
        cell.teacherNameLabel.text = ClassManager.shared.getFakeClassArray()[indexPath.row].Name
        cell.classTimeLabel.text = ClassManager.shared.getFakeClassArray()[indexPath.row].CourseTime
        cell.numberCountLabel.text = "剩餘 \(ClassManager.shared.getFakeClassArray()[indexPath.row].lastCount) 位"
        cell.photoImageView?.loadImageUsingCacheWithUrlString(urlString: ClassManager.shared.getFakeClassArray()[indexPath.row].ImageUrl)
        cell.photoImageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension ClassViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        if let textLabel = header.textLabel {
            textLabel.font = UIFont(name: textLabel.font.fontName, size: 25)
            textLabel.textColor = UIColor.darkGray
        }
        header.backgroundView?.backgroundColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "2019年課程"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if ClassManager.shared.getFakeClassArray()[indexPath.row].lastCount == 0 {
            self.view.makeToast("請選擇其他課程。", duration: 1.0, point: CGPoint(x: screenWidth/2, y: screenHeight/2), title: "課程已滿", image: UIImage(named: "noCourse")) { didTap in
                if didTap {
                    print("completion from tap")
                } else {
                    print("completion without tap")
                }
            }
        }
        else {
            self.performSegue(withIdentifier: "classDetail", sender: indexPath)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = sender as? IndexPath,
            segue.identifier == "classDetail" {
            let viewController = segue.destination as! ClassDetailViewController
            viewController.classIndex = indexPath.row
        }
    }
    
}
