//
//  OTPRegisterViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
//import Amplify
import Material
import ProgressHUD

class OTPRegisterViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    var username: String?
    var password: String?
    let visualAssets = VisualAssets()
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var otpTextField: TextField!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var boton: UIButton!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var TitleBig: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        self.confirmButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
    
        
        otpTextField.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)
        // Do any additional setup after loading the view.
        otpTextField.textColor = visualAssets.colorNameBlue
        //otpTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        otpTextField.dividerActiveColor = .lightGray
        otpTextField.dividerNormalColor = .lightGray
        //otpTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //otpTextField.placeholderNormalColor = visualAssets.colorNameBlue
        otpTextField.textContentType = .oneTimeCode
        otpTextField.keyboardType = .numberPad
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissCustom))
        view.addGestureRecognizer(tap)
        
        // header
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.layer.cornerRadius = 30.0
        self.HeaderTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        self.card.viewStyle(bgcolor: "cardBackgroundColor")
        card.layer.cornerRadius = 20
        self.boton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        self.TitleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        self.instructionsLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        SCSRequests().setTracker(id: 24, orgid: 1, typeid: 24){
            s in print("RESPUESTA EN TRACKER PANTALLA 24 ####### \(s)")
        }
    }
    
    
    @objc func dismissCustom(){
        
        self.view.endEditing(true)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func valueChanged(_ sender: UITextField) {
        if (otpTextField.text!.count >= 6) {
            confirmButton.isEnabled = true
        } else {
            confirmButton.isEnabled = false
        }
    }
    
    
    @IBAction func resendCode(_ sender: UIButton) {
        // TODO: LOGIC
//        Amplify.Auth.resendConfirmationCode(for: AuthUserAttributeKey.phoneNumber, listener: nil)
    }
    
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        confirmSignUp(for: username!, with: otpTextField.text!)
    }
    
    //func header
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
       // cell.backgroundColor = UIColor.black
        return cell
    }
    //func header
    
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        print("entre")
        print(username)
//        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
//            print("resul")
//            print(result)
//            switch result {
//            case .success:
//                print("Confirm signUp succeeded")
//                // TODO: START SURVEY
//                self.performSignIn()
//            case .failure(let error):
//                //codeMismatch -> no coincide el codigo de envio que ingresaron
//                print("An error occurred while confirming sign up \(error)")
//                DispatchQueue.main.sync {
//                    ProgressHUD.showError(NSLocalizedString("Error en registro de usuario", comment: "error registro usuario"))
//                }
//            }
//        }
    }
    
    
    func performSignIn() {
//        Amplify.Auth.signIn(username: self.username, password: self.password) { result in
//            do {
//                let signinResult = try result.get()
//                switch signinResult.nextStep {
//                    case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
//                        print("SMS code send to \(deliveryDetails.destination)")
//                        print("Additional info \(info)")
//                    case .resetPassword(let info):
//                        print("Reset password additional info \(info)")
//                    case .confirmSignUp(let info):
//                        print("Confirm signup additional info \(info)")
//                    case .done:
//                        DispatchQueue.main.sync {
//                            self.performSegue(withIdentifier: "loanRequestInstructions", sender: nil)
//                        }
//                    default:
//                        DispatchQueue.main.sync {
//                            ProgressHUD.showError("Error en inicio de sesion")
//                        }
//                }
//            } catch {
//                print ("Sign in failed \(error)")
//                DispatchQueue.main.sync {
//                    ProgressHUD.showError("Error en inicio de sesion")
//                }
//            }
//        }
    }
    
    
    
    
    

}
