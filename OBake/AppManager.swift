//
//  AppManager.swift
//  OBake
//
//  Created by Otis on 2019/4/21.
//  Copyright © 2019年 Otis. All rights reserved.
//
import UIKit
import Foundation

protocol Accessible {
    func start()
}

class AppManager: Accessible {
    var window: UIWindow
    
    init(window: UIWindow){
        self.window = window
        
        let navigationBarAppearnce = UINavigationBar.appearance()
        // 導覽列背景顏色
        navigationBarAppearnce.tintColor = .white
        // 導覽列指示圖, 按鈕名稱, 按鈕圖片
        navigationBarAppearnce.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        
        // 螢幕恆亮
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
    func start(){
        // 顯示主畫面
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        self.window.rootViewController = mainVC
    }
}
