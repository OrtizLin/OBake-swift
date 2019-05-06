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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "單位換算", style: .plain, target: self, action: #selector(calculate))
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
        
        hideAllScrollBar(true)
    }
    
    func configureShape() {
        topShape.fillColor = nil
        topShape.lineWidth = 1
        topShape.strokeColor = UIColor.init(red: 253/255, green: 103/255, blue: 43/255, alpha: 1).cgColor
        topShape.position = CGPoint(x: view.center.x, y:  horizontalSliderOne.frame.origin.y - 40)
        view.layer.addSublayer(topShape)
        
        bottomShape.fillColor = nil
        bottomShape.lineWidth = 1
        bottomShape.strokeColor = UIColor.init(red: 21/255, green: 174/255, blue: 48/255, alpha: 1).cgColor
        bottomShape.position = CGPoint(x: view.center.x, y: horizontalSlider.frame.origin.y - 40)
        view.layer.addSublayer(bottomShape)
    }
    
    func configureViewAfterSelect() {
        hideAllScrollBar(false)
        
        switch shapeSelect {
        case .circleToCircle:
            verticalSlider.isHidden = true
            verticalSliderOne.isHidden = true
        case .circleToSquare:
            verticalSliderOne.isHidden = true
        case .squareToSquare: hideAllScrollBar(false)
        case .squareToCircle:
            verticalSlider.isHidden = true
        }
    }
    
    func hideAllScrollBar(_ boolValue: Bool){
        verticalSlider.isHidden = boolValue
        verticalSliderOne.isHidden = boolValue
        horizontalSlider.isHidden = boolValue
        horizontalSliderOne.isHidden = boolValue
        heightSlider.isHidden = boolValue
        heightSliderOne.isHidden = boolValue
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
        //chanage all button to default color
        circleToCircle.setTitleColor(.lightGray, for: .normal)
        circleToSquare.setTitleColor(.lightGray, for: .normal)
        squareToSquare.setTitleColor(.lightGray, for: .normal)
        squareToCircle.setTitleColor(.lightGray, for: .normal)
        
        //select to change color
        switch sender.tag {
        case 0: circleToCircle.setTitleColor(.blue, for: .normal)
        case 1: circleToSquare.setTitleColor(.blue, for: .normal)
        case 2: squareToSquare.setTitleColor(.blue, for: .normal)
        default: squareToCircle.setTitleColor(.blue, for: .normal)
        }
        
        shapeSelect = ShapeSelect(rawValue: sender.tag)!
        configureViewAfterSelect()
        valueChange()
        
    }
    
    @objc func calculate() {
         self.performSegue(withIdentifier: "calculateDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "calculateDetail" {
            let viewController = segue.destination as! CalculateViewController
            viewController.magnification = Double(WeightConvert.shared.magnificationChange(Int(horizontalSliderOne.value), y1: Int(verticalSliderOne.value), z1: Int(heightSliderOne.value), x2: Int(horizontalSlider.value), y2: Int(verticalSlider.value), z2: Int(heightSlider.value), type:shapeSelect))
        }
    }
}
