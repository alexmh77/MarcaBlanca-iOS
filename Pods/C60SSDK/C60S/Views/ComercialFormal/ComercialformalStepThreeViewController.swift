//
//  ComercialformalStepThreeViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit
import Amplify
import ProgressHUD
import Material

class ComercialformalStepThreeViewController: UIViewController {
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var giroTextField: TextField!
    @IBOutlet weak var ubicacionTextField: TextField!
    @IBOutlet weak var antiquedadTextField: TextField!
    @IBOutlet weak var rfcTextField: TextField!
    
    let visualAssets = VisualAssets()
    let fontSize: Double = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonNext.isEnabled = true
        
        nameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        nameTextField.textColor = visualAssets.colorNameBlue
        nameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        nameTextField.dividerActiveColor = visualAssets.colorNameBlue
        nameTextField.dividerNormalColor = visualAssets.colorNameBlue
        nameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        nameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        
        giroTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        giroTextField.textColor = visualAssets.colorNameBlue
        giroTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        giroTextField.dividerActiveColor = visualAssets.colorNameBlue
        giroTextField.dividerNormalColor = visualAssets.colorNameBlue
        giroTextField.placeholderActiveColor = visualAssets.colorNameBlue
        giroTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        ubicacionTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        ubicacionTextField.textColor = visualAssets.colorNameBlue
        ubicacionTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        ubicacionTextField.dividerActiveColor = visualAssets.colorNameBlue
        ubicacionTextField.dividerNormalColor = visualAssets.colorNameBlue
        ubicacionTextField.placeholderActiveColor = visualAssets.colorNameBlue
        ubicacionTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        antiquedadTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        antiquedadTextField.textColor = visualAssets.colorNameBlue
        antiquedadTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        antiquedadTextField.dividerActiveColor = visualAssets.colorNameBlue
        antiquedadTextField.dividerNormalColor = visualAssets.colorNameBlue
        antiquedadTextField.placeholderActiveColor = visualAssets.colorNameBlue
        antiquedadTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        rfcTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        rfcTextField.textColor = visualAssets.colorNameBlue
        rfcTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        rfcTextField.dividerActiveColor = visualAssets.colorNameBlue
        rfcTextField.dividerNormalColor = visualAssets.colorNameBlue
        rfcTextField.placeholderActiveColor = visualAssets.colorNameBlue
        rfcTextField.placeholderNormalColor = visualAssets.colorNameBlue
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toNextAction(_ sender: UIButton) {
    }
    
    
}


extension UITextField{
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.endEditing(true)
    }
}

