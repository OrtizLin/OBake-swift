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
    
    @IBOutlet weak var kgTransTextField: UITextField!
    @IBOutlet weak var gTransTextField: UITextField!
    @IBOutlet weak var cattyTransTextField: UITextField!
    @IBOutlet weak var poundTransTextField: UITextField!
    @IBOutlet weak var ozTransTextField: UITextField!
    
    var selectType: (WeightType) = .g
    var weightResult: (Weight)?
    var weightTransferResult: (Weight)?
    var nowValue: (String) = "empty"
    
    var magnification: Double?
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = "倍率：" + String(magnification ?? 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "清除", style: .plain, target: self, action: #selector(clean))

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
        
        kgTransTextField.isUserInteractionEnabled = false
        gTransTextField.isUserInteractionEnabled = false
        cattyTransTextField.isUserInteractionEnabled = false
        poundTransTextField.isUserInteractionEnabled = false
        ozTransTextField.isUserInteractionEnabled = false
        hideTransTextField(true)
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
    
    func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @objc func clean() {
        cleanTextField()
    }
    
}

extension CalculateViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case kgTextField: selectType = .kg
        case gTextField: selectType = .g
        case cattyTextField: selectType = .twCatty
        case poundTextField: selectType = .lb
        default: selectType = .oz
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
        hideTransTextField(true)
        
    }
    
    func showValueOnTextField(_ tag: Int){
        if tag == 100 && nowValue == "empty" || tag == 100 && nowValue . contains("."){
           return
        }
        
        nowValue = WeightConvert.shared.updateNowValue(tag, Value: nowValue)
        
        weightResult = WeightConvert.shared.weightConvertValue(type: selectType, value: Double(nowValue) ?? 0)
        
        weightTransferResult = WeightConvert.shared.sizeConvertResult(magnification: magnification!, value: weightResult!)
        
        updateValueOnTextField()
        updateValueOnTransTextField()
        
    }
    
    func updateValueOnTextField(){
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
    
    func updateValueOnTransTextField(){
        kgTransTextField.text = "\(weightTransferResult?.kg ?? 0)"
        gTransTextField.text = "\(weightTransferResult?.g ?? 0)"
        cattyTransTextField.text = "\(weightTransferResult?.twCatty ?? 0)"
        poundTransTextField.text = "\(weightTransferResult?.lb ?? 0)"
        ozTransTextField.text = "\(weightTransferResult?.oz ?? 0)"
        
        hideTransTextField(false)
    }
    
    func hideTransTextField(_ hidden: Bool){
        //hidden transfer label
        kgTransTextField.isHidden = hidden
        gTransTextField.isHidden = hidden
        cattyTransTextField.isHidden = hidden
        poundTransTextField.isHidden = hidden
        ozTransTextField.isHidden = hidden
    }

}
