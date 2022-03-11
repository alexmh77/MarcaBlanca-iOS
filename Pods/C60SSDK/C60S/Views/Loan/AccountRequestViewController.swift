//
//  AccountRequestViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit
import Material

class AccountRequestViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var accountTextField: TextField!
    
    let visualAssets = VisualAssets()
    let fontSize: Double = 16.0
    let limitAccountDigits = 18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        accountTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        accountTextField.textColor = visualAssets.colorNameBlue
        accountTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        accountTextField.dividerActiveColor = visualAssets.colorNameBlue
        accountTextField.dividerNormalColor = visualAssets.colorNameBlue
        accountTextField.placeholderActiveColor = visualAssets.colorNameBlue
        accountTextField.placeholderNormalColor = visualAssets.colorNameBlue
        accountTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardCustom))
        
        
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboardCustom() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        self.backButton.setTitle("", for: .normal)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                  return false
              }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= limitAccountDigits
    }
    
    
    @IBAction func textChanged(_ sender: TextField) {
        if sender.text?.count == 18 {
            self.continueButton.isEnabled = true
        } else {
            self.continueButton.isEnabled = false
        }
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        
        SCSRequests().AccountSave(data: SurveyData.shared.getAccountRequestData(depositAcct: accountTextField.text!)){
            
            s in print(s?.depositacct)
        }
        
        self.performSegue(withIdentifier: "confirmDocumentationSegue", sender: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
