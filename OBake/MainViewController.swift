//
//  MainViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/21.
//  Copyright © 2019年 Otis. All rights reserved.
//

import UIKit
import Foundation
import FSPagerView

class MainViewController: UIViewController {
  
    @IBOutlet weak var newsView: FSPagerView!
    @IBOutlet weak var newsLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        NewsManager.shared.initView(view:newsView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func tempButton(_ sender: Any) {
        let calculateVC = instantiate(storyboard: .main, viewController: .size)
        let nav = UINavigationController(rootViewController: calculateVC)
        present(nav, animated: true, completion:  nil)
    }
    
    @IBAction func tempTwoButton(_ sender: Any) {let calculateVC = instantiate(storyboard: .main, viewController: .teacher)
        let nav = UINavigationController(rootViewController: calculateVC)
        present(nav, animated: true, completion:  nil)
    }
    
    @IBAction func tampThreeButton(_ sender: Any) {
        let classVC = instantiate(storyboard: .main, viewController: .classes)
        let nav = UINavigationController(rootViewController: classVC)
        present(nav, animated: true, completion:  nil)
    }
}

