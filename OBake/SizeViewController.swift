//
//  SizeViewController.swift
//  OBake
//
//  Created by Otis on 2019/5/3.
//  Copyright © 2019 Otis. All rights reserved.
//

import Foundation
import UIKit

class SizeViewController: UIViewController {
    //sizeButton
    @IBOutlet weak var circleToCircle: UIButton!
    @IBOutlet weak var circleToSquare: UIButton!
    @IBOutlet weak var squareToSquare: UIButton!
    @IBOutlet weak var squareToCircle: UIButton!
    
    //firstViewLabel
    @IBOutlet weak var verticalSliderOne: UISlider!
    @IBOutlet weak var horizontalSliderOne: UISlider!
    @IBOutlet weak var heightSliderOne: UISlider!
    
    //secondViewLabel
    @IBOutlet weak var horizontalSlider: UISlider!
    @IBOutlet weak var verticalSlider: UISlider!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var shapeSelect: ShapeSelect = .circleToCircle
    var topShape = CAShapeLayer()
    var bottomShape = CAShapeLayer()
    var topBool = false
    var bottomBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBackBotton()
        configureSlider()
        configureShape()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    func configureSlider() {
        //slide bar verticalized
        verticalSliderOne.transform = verticalSliderOne.transform.rotated(by: CGFloat(1.5 * Float.pi))
        verticalSlider.transform = verticalSlider.transform.rotated(by: CGFloat(1.5 * Float.pi))
        heightSliderOne.transform = heightSliderOne.transform.rotated(by: CGFloat(1.5 * Float.pi))
        heightSlider.transform = heightSlider.transform.rotated(by: CGFloat(1.5 * Float.pi))
        
        verticalSlider.isHidden = true
        verticalSliderOne.isHidden = true
        horizontalSlider.isHidden = true
        horizontalSliderOne.isHidden = true
        heightSlider.isHidden = true
        heightSliderOne.isHidden = true
    }
    
    func configureShape() {
        topShape.fillColor = nil // 若想為透明可設為 nil
        topShape.lineWidth = 1 // 線條寬度
        topShape.strokeColor = UIColor.black.cgColor // 線條顏色
        topShape.position = CGPoint(x: view.center.x, y:  horizontalSliderOne.frame.origin.y - 40)
        view.layer.addSublayer(topShape)
        
        bottomShape.fillColor = nil // 若想為透明可設為 nil
        bottomShape.lineWidth = 1 // 線條寬度
        bottomShape.strokeColor = UIColor.black.cgColor // 線條顏色
        bottomShape.position = CGPoint(x: view.center.x, y: screenHeight - 130)
        view.layer.addSublayer(bottomShape)
    }
    
    func configureViewAfterSelect() {
        verticalSlider.isHidden = false
        verticalSliderOne.isHidden = false
        horizontalSlider.isHidden = false
        horizontalSliderOne.isHidden = false
        heightSlider.isHidden = false
        heightSliderOne.isHidden = false
        switch shapeSelect {
        case .circleToCircle:
            verticalSlider.isHidden = true
            verticalSliderOne.isHidden = true
        case .circleToSquare:
            verticalSliderOne.isHidden = true
        case .squareToSquare:
            print("do nothing")
        case .squareToCircle:
            verticalSlider.isHidden = true
        }
    }
    
    func valueChange() {
        sizeLabel.text = WeightConvert.shared.valueChange(Int(horizontalSliderOne.value).description, y1: Int(verticalSliderOne.value).description, z1: Int(heightSliderOne.value).description, x2: Int(horizontalSlider.value).description, y2: Int(verticalSlider.value).description, z2: Int(heightSlider.value).description, type:shapeSelect)
    
        switch shapeSelect {
        case .circleToCircle:
            topBool = true
            bottomBool = true
        case .circleToSquare:
            topBool = true
            bottomBool = false
        case .squareToSquare:
            topBool = false
            bottomBool = false
        case .squareToCircle:
            topBool = false
            bottomBool = true
        }
        
        topShape.path = WeightConvert.shared.updatePath(Int(horizontalSliderOne.value), y: Int(verticalSliderOne.value), z: Int(heightSliderOne.value), circle: topBool).cgPath
        
        bottomShape.path = WeightConvert.shared.updatePath(Int(horizontalSlider.value), y: Int(verticalSlider.value), z: Int(heightSlider.value), circle: bottomBool).cgPath
        
        resultLabel.text = "倍率：" + WeightConvert.shared.magnificationChange(Int(horizontalSliderOne.value), y1: Int(verticalSliderOne.value), z1: Int(heightSliderOne.value), x2: Int(horizontalSlider.value), y2: Int(verticalSlider.value), z2: Int(heightSlider.value), type:shapeSelect)
    }
    
    @IBAction func sliderValueChange(_ sender: UISlider) {
       valueChange()
    }
    
    @IBAction func selectType(_ sender: UIButton) {
        shapeSelect = ShapeSelect(rawValue: sender.tag)!
        configureViewAfterSelect()
        valueChange()
        
    }
}
