//
//  AccountRequestViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit
import Material

class AccountRequestViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var accountTextField: TextField!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: TableView!
    @IBOutlet weak var VewClabe: UIView!
    
    @IBOutlet weak var titleBig: UILabel!
    @IBOutlet weak var intructionsLabel: UILabel!
    @IBOutlet weak var labelCLABE: UILabel!
    
    let visualAssets = VisualAssets()
    let fontSize: Double = 16.0
    let limitAccountDigits = 18
    //let colorNameGray = getColorBlue()
    
    
    func getColorBlue()->UIColor{
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
        }
        if !matches.isEmpty {
             print(matches.last!)
            return UIColor(named: "AppGrayLightColor",in: matches.last!, compatibleWith: nil)!
            // icon.image = UIImage(named: model.icon ?? "", in: matches.last!, with: nil)
         } else {
             return UIColor(named: "AppGrayLightColor")!
            // icon.image = UIImage(named: model.icon ?? "")
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
                
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        VewClabe.layer.cornerRadius = 10
        
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        accountTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        accountTextField.textColor = .black
        accountTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        accountTextField.dividerActiveColor = getColorBlue()
        accountTextField.dividerNormalColor = getColorBlue()
        accountTextField.placeholderActiveColor = visualAssets.colorNameBlue
        accountTextField.placeholderNormalColor = visualAssets.colorNameBlue
        accountTextField.delegate = self
        self.labelCLABE.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.intructionsLabel.labelStyle(bgcolor: "", textcolor: "bodyTextColor")
        self.titleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardCustom))
        
        
        view.addGestureRecognizer(tap)
        SCSRequests().setTracker(id: 13, orgid: 1, typeid: 13){
            s in print("RESPUESTA EN TRACKER PANTALLA 13 ####### \(s)")
        }
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
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        return cell
    }
    
}
