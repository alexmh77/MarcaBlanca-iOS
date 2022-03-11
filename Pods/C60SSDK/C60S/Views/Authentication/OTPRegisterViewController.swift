//
//  OTPRegisterViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Amplify
import Material
import ProgressHUD

class OTPRegisterViewController: UIViewController {

    var username: String?
    var password: String?
    let visualAssets = VisualAssets()
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var otpTextField: TextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        otpTextField.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)
        // Do any additional setup after loading the view.
        otpTextField.textColor = visualAssets.colorNameBlue
        otpTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        otpTextField.dividerActiveColor = visualAssets.colorNameBlue
        otpTextField.dividerNormalColor = visualAssets.colorNameBlue
        otpTextField.placeholderActiveColor = visualAssets.colorNameBlue
        otpTextField.placeholderNormalColor = visualAssets.colorNameBlue
        otpTextField.textContentType = .oneTimeCode
        otpTextField.keyboardType = .numberPad
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        Amplify.Auth.resendConfirmationCode(for: AuthUserAttributeKey.phoneNumber, listener: nil)
    }
    
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        confirmSignUp(for: username!, with: otpTextField.text!)
    }
    
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                // TODO: START SURVEY
                self.performSignIn()
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                DispatchQueue.main.sync {
                    ProgressHUD.showError("Error en registro de usuario")
                }
            }
        }
    }
    
    
    func performSignIn() {
        Amplify.Auth.signIn(username: self.username, password: self.password) { result in
            do {
                let signinResult = try result.get()
                switch signinResult.nextStep {
                    case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
                        print("SMS code send to \(deliveryDetails.destination)")
                        print("Additional info \(info)")
                    case .resetPassword(let info):
                        print("Reset password additional info \(info)")
                    case .confirmSignUp(let info):
                        print("Confirm signup additional info \(info)")
                    case .done:
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "loanRequestInstructions", sender: nil)
                        }
                    default:
                        DispatchQueue.main.sync {
                            ProgressHUD.showError("Error en inicio de sesion")
                        }
                }
            } catch {
                print ("Sign in failed \(error)")
                DispatchQueue.main.sync {
                    ProgressHUD.showError("Error en inicio de sesion")
                }
            }
        }
    }

}
