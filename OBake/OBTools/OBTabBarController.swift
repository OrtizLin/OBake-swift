//
//  OBTabBarController.swift
//  OBake
//
//  Created by Otis on 2019/4/25.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit

class OTTabBar: UIViewController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
    }

}


