//
//  GlobalFuc.swift
//  OBake
//
//  Created by Otis on 2019/4/21.
//  Copyright © 2019年 Otis. All rights reserved.
//

import UIKit

func instantiate<T: UIViewController>(storyboard: StoryboardName, viewController: ViewControllerID) -> T {
    let storyboard = UIStoryboard(name: storyboard.rawValue, bundle:nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: viewController.rawValue) as! T
    return viewController
}

enum StoryboardName: String {
    case main = "Main"
}

enum ViewControllerID: String {
    case main = "MainViewController"
    case teacher = "TeacherViewController"
    case calculate = "CalculateViewController"
    case teacherDetail = "TeacherDetailViewController"
}
