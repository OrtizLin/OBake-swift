//
//  CalculateViewController.swift
//  OBake
//
//  Created by Otis on 2019/4/26.
//  Copyright © 2019 Otis. All rights reserved.
//

import UIKit
import Foundation


class CalculateViewController: UIViewController {
    
    @IBOutlet weak var kgTextField: UITextField!
    @IBOutlet weak var gTextField: UITextField!
    @IBOutlet weak var cattyTextField: UITextField!
    @IBOutlet weak var poundTextField: UITextField!
    @IBOutlet weak var ozTextField: UITextField!
    
    var selectType:(WeightType) = .g
    var weightResult:(Weight)?
    var nowValue:(String) = "empty"
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        kgTextField.inputView = UIView()
        kgTextField.delegate = self
        gTextField.inputView = UIView()
        gTextField.delegate = self
        cattyTextField.inputView = UIView()
        cattyTextField.delegate = self
        poundTextField.inputView = UIView()
        poundTextField.delegate = self
        ozTextField.inputView = UIView()
        ozTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func numberTap(_ sender: Any) {
      showValueOnTextField((sender as AnyObject).tag!)
    }
    
    @IBAction func backTap(_ sender: Any) {
        
        guard nowValue != "empty" else{return}
        
        if nowValue.count > 1 {
            nowValue = String(nowValue.dropLast())
            showValueOnTextField(999)
        }
        else{
            cleanTextField()
        }
        
    }
    
}

extension CalculateViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == kgTextField {
           selectType = .kg
        }
        else if textField == gTextField {
            selectType = .g
        }
        else if textField == cattyTextField{
            selectType = .twCatty
        }
        else if textField == poundTextField{
            selectType = .lb
        }
        else{
            selectType = .oz
        }
        
        cleanTextField()

    }
    
    func cleanTextField(){
        
        kgTextField.text = ""
        gTextField.text = ""
        cattyTextField.text = ""
        poundTextField.text = ""
        ozTextField.text = ""
        nowValue = "empty"
        
    }
    
    func showValueOnTextField(_ tag: Int){
        
        if tag != 999 {
            if nowValue == "empty"{
                nowValue = String(tag)
            }
            else{
                nowValue += String(tag)
            }
        }
        
        weightResult = WeightConvert.shared.weightConvertValue(type: selectType, value: Double(nowValue) ?? 0)
        
        kgTextField.text = "\(weightResult?.kg ?? 0)"
        gTextField.text = "\(weightResult?.g ?? 0)"
        cattyTextField.text = "\(weightResult?.twCatty ?? 0)"
        poundTextField.text = "\(weightResult?.lb ?? 0)"
        ozTextField.text = "\(weightResult?.oz ?? 0)"
        
        switch selectType {
        case .kg: kgTextField.text = nowValue
        case .g: gTextField.text = nowValue
        case .lb: poundTextField.text = nowValue
        case .twCatty: cattyTextField.text = nowValue
        case .oz: ozTextField.text = nowValue
        }
        
    }

}
