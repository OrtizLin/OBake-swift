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
    
    @IBOutlet weak var sizePicker: UIPickerView!
    @IBOutlet weak var kgTransTextField: UITextField!
    @IBOutlet weak var gTransTextField: UITextField!
    @IBOutlet weak var cattyTransTextField: UITextField!
    @IBOutlet weak var poundTransTextField: UITextField!
    @IBOutlet weak var ozTransTextField: UITextField!
    
    var selectType: (WeightType) = .g
    var weightResult: (Weight)?
    var weightTransferResult: (Weight)?
    var nowValue: (String) = "empty"
    var selectShape: (ShapeType) = .none
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setNavBackBotton()
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
        
        sizePicker.delegate = self
        sizePicker.dataSource = self
        kgTransTextField.isUserInteractionEnabled = false
        gTransTextField.isUserInteractionEnabled = false
        cattyTransTextField.isUserInteractionEnabled = false
        poundTransTextField.isUserInteractionEnabled = false
        ozTransTextField.isUserInteractionEnabled = false
        hideTransTextField()
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
    
}
extension CalculateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return SizeType.allCases.count
        }
        else {
            return ShapeType.allCases.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return SizeType.allCases[row].rawValue
        }
        else {
            return ShapeType.allCases[row].rawValue
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        guard nowValue != "empty" else{
            hideTransTextField()
            return
        }
        
        guard sizePicker.selectedRow(inComponent: 0) != 0 || sizePicker.selectedRow(inComponent: 1) != 0 else {
            hideTransTextField()
            return
        }
        
        weightTransferResult = WeightConvert.shared.sizeConvertValue(type: SizeType.allCases[sizePicker.selectedRow(inComponent: 0)], shape:ShapeType.allCases[sizePicker.selectedRow(inComponent: 1)] ,value: weightResult!)
        updateValueOnTransTextField()
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
        hideTransTextField()
        
    }
    
    func showValueOnTextField(_ tag: Int){

        if tag == 100 && nowValue == "empty" || tag == 100 && nowValue . contains("."){
           return
        }
        
        nowValue = WeightConvert.shared.updateNowValue(tag, Value: nowValue)
        weightResult = WeightConvert.shared.weightConvertValue(type: selectType, value: Double(nowValue) ?? 0)
        weightTransferResult = WeightConvert.shared.sizeConvertValue(type:SizeType.allCases[sizePicker.selectedRow(inComponent: 0)], shape:ShapeType.allCases[sizePicker.selectedRow(inComponent: 1)], value: weightResult!)
        
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
        
        guard sizePicker.selectedRow(inComponent: 0) != 0 else{return}
        updateValueOnTransTextField()
        
    }
    
    func updateValueOnTransTextField(){
        
        kgTransTextField.text = "\(weightTransferResult?.kg ?? 0)"
        gTransTextField.text = "\(weightTransferResult?.g ?? 0)"
        cattyTransTextField.text = "\(weightTransferResult?.twCatty ?? 0)"
        poundTransTextField.text = "\(weightTransferResult?.lb ?? 0)"
        ozTransTextField.text = "\(weightTransferResult?.oz ?? 0)"
        
        kgTransTextField.isHidden = false
        gTransTextField.isHidden = false
        cattyTransTextField.isHidden = false
        poundTransTextField.isHidden = false
        ozTransTextField.isHidden = false
    }
    
    func hideTransTextField(){
        //hidden transfer label
        kgTransTextField.isHidden = true
        gTransTextField.isHidden = true
        cattyTransTextField.isHidden = true
        poundTransTextField.isHidden = true
        ozTransTextField.isHidden = true
    }

}
