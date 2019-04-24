//
//  GlobalSettings.swift
//  OBake
//
//  Created by Otis on 2019/4/21.
//  Copyright © 2019年 Otis. All rights reserved.
//

import UIKit
import UserNotifications



/// Basic Configuration
let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
let navigationBarHeight: CGFloat = 44
let tabBarHeigh: CGFloat = 49
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let themeColor = UIColor(red:0, green:0.64, blue:0.87, alpha:1)
let redColor = UIColor(red:1, green:0.17, blue:0.32, alpha:1)

/// 推播登記
let isRegisteredRN = UIApplication.shared.isRegisteredForRemoteNotifications
/// 推播的顯示設定
func isRegisteredSuccess() {
    UNUserNotificationCenter.current().getNotificationSettings { (settings) in
        print("Checking notification status")
        switch settings.authorizationStatus {
        case .authorized:
            print("authorized")
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        default:
            print("unknown")
            break
        }
    }
}


