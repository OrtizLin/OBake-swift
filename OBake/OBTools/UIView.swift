//
//  UIView.swift
//  OBake
//
//  Created by Otis on 2019/04/24.
//  Copyright © 2019年 Otis. All rights reserved.


import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func themeBorderStyle(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1).cgColor
    }
    
    func themeButtonStyle(isSolid: Bool) {
        if isSolid {
            self.layer.cornerRadius = 30
            self.backgroundColor = UIColor(red:0, green:0.64, blue:0.87, alpha:1)
        } else {
            self.layer.cornerRadius = 30
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor(red:0, green:0.64, blue:0.87, alpha:1).cgColor
        }

    }
}

