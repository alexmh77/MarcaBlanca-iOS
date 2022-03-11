//
//  ComercialInformalStepThreeViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 02/02/22.
//

import UIKit
import Material

class ComercialInformalStepThreeViewController: UIViewController {

    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var giroTextField: TextField!
    @IBOutlet weak var ubicacionTextField: TextField!
    @IBOutlet weak var antiquedadTextField: TextField!
    @IBOutlet weak var rfcTextField: TextField!
    
    let visualAssets = VisualAssets()
    let fontSize: Double = 16.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.continueButton.isEnabled = true
        
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardCustom))
        view.addGestureRecognizer(tap)
        
        backUIButton.setTitle("", for: .normal)
    }
    @objc func dismissKeyboardCustom() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // TODO: WRITE in singleton element
        self.performSegue(withIdentifier: "cualEsTuIngressoSegue", sender: nil)
    }
    
}
