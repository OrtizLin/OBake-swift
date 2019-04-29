//
//  UIViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/29.
//  Copyright © 2019 Otis. All rights reserved.
//

import UIKit

extension UIViewController {
    func setNavBackBotton() {
        // Call Func Page
        let navigationBarAppearnce = UINavigationBar.appearance()
        
        navigationBarAppearnce.barTintColor = UIColor(red: 0.180, green: 0.459, blue: 0.733, alpha: 1.00)
        
        navigationBarAppearnce.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                                           style: .plain, target: self, action: #selector(navBackAction))
        // Next Nav Page
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func navBackAction() {
        dismiss(animated: true, completion: nil)
    }
}

