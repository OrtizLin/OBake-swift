//
//  ClassDetailViewController.swift
//  OBake
//
//  Created by Otis on 2019/5/2.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit

class ClassDetailViewController: UIViewController {

    @IBOutlet weak var classScrollView: UIScrollView!
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    var classIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configureData() {
        self.navigationItem.title = ClassManager.shared.getFakeClassArray()[classIndex ?? 0].Name;
        
        classScrollView.contentSize.width = 0
        classScrollView.isDirectionalLockEnabled = true
            let str = "介紹：\n" + ClassManager.shared.getFakeClassArray()[classIndex ?? 0].Intro
            let paraph = NSMutableParagraphStyle()
            paraph.lineSpacing = 5
            let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12),
                          NSAttributedString.Key.paragraphStyle: paraph]
            introLabel.attributedText = NSAttributedString(string: str , attributes: attributes)
        classImageView?.loadImageUsingCacheWithUrlString(urlString:ClassManager.shared.getFakeClassArray()[classIndex ?? 0].ImageUrl )
            classImageView?.contentMode = .scaleAspectFit
            orderButton.themeButtonStyle(isSolid: true)
        
     
    }
    @IBAction func orderButtonTap(_ sender: Any) {
        self.view.makeToastActivity(.center)
        //call server register from this app.
        guard let url = URL(string:"https://www.surveycake.com/s/JzWL5") else { return }
        UIApplication.shared.open(url)
        self.view.hideToastActivity()
    }
}
