//
//  TeacherDetailViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/30.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

class TeacherDetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    
    var teacherIndex: Int?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.title = "教師資訊";
        detailScrollView.contentSize.width = 0
        detailScrollView.isDirectionalLockEnabled = true
        searchButton.themeButtonStyle(isSolid: false)
        nameLabel.text = TeacherManager.shared.getFakeTeacherArray()[teacherIndex ?? 0].Name
        titleLabel.text = "稱號：" + TeacherManager.shared.getFakeTeacherArray()[teacherIndex ?? 0].Title
        let str = "經歷：\n" + TeacherManager.shared.getFakeTeacherArray()[teacherIndex ?? 0].Resume
        let paraph = NSMutableParagraphStyle()
        paraph.lineSpacing = 5
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.paragraphStyle: paraph]
        experienceLabel.attributedText = NSAttributedString(string: str , attributes: attributes)
        photoImageView?.loadImageUsingCacheWithUrlString(urlString:TeacherManager.shared.getFakeTeacherArray()[teacherIndex ?? 0].ImageUrl )
        photoImageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func searchButtonTap(_ sender: Any) {
        self.view.makeToast("請選擇其他老師的課程。", duration: 2.0, point: CGPoint(x: screenWidth/2, y: screenHeight/2), title: "課程已滿", image: UIImage(named: "noCourse")) { didTap in
            if didTap {
                print("completion from tap")
            } else {
                print("completion without tap")
            }
        }
    }
}


