//
//  LoginViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Amplify
import ProgressHUD
import Material
import LocalAuthentication

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var authSwitch: UISwitch!
    
    let visualAssets = VisualAssets()
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.setTitle("", for: .normal)
        
        
        phoneNumberTextField.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)
        passwordTextField.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)

        phoneNumberTextField.textColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        phoneNumberTextField.dividerActiveColor = visualAssets.colorNameBlue
        phoneNumberTextField.dividerNormalColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderActiveColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderNormalColor = visualAssets.colorNameBlue
        phoneNumberTextField.keyboardType = .asciiCapableNumberPad
        
        
        passwordTextField.textColor = visualAssets.colorNameBlue
        passwordTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        passwordTextField.dividerActiveColor = visualAssets.colorNameBlue
        passwordTextField.dividerNormalColor = visualAssets.colorNameBlue
        passwordTextField.placeholderActiveColor = visualAssets.colorNameBlue
        passwordTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
                
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    @IBAction func authChanged(_ sender: UISwitch) {
        
    }
    
    
    func signIn(username: String, password: String) {
        print("Signing in...")
        Amplify.Auth.signIn(username: username, password: password) { result in
            do {
                let signinResult = try result.get()
                switch signinResult.nextStep {
                    case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
                        print("SMS code send to \(deliveryDetails.destination)")
                        print("Additional info \(info)")

                        // Prompt the user to enter the SMSMFA code they received
                        // Then invoke `confirmSignIn` api with the code
                    case .resetPassword(let info):
                        print("Reset password additional info \(info)")
                    case .confirmSignUp(let info):
                        print("Confirm signup additional info \(info)")
                        
                        // User was not confirmed during the signup process.
                        // Invoke `confirmSignUp` api to confirm the user if
                        // they have the confirmation code. If they do not have the
                        // confirmation code, invoke `resendSignUpCode` to send the
                        // code again.
                        // After the user is confirmed, invoke the `signIn` api again.
                    case .done:
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "homeLoginSegue", sender: nil)
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
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func validateCredentialsPressed(_ sender: UIButton) {
        
        var error: NSError?
        
        if (authSwitch.isOn) {

            let permissions = context.canEvaluatePolicy(
                .deviceOwnerAuthentication,
                error: &error
            )
            
            if permissions {
                // Proceed to authentication
                let reason = "Log in with Face ID"
                context.evaluatePolicy(
                    .deviceOwnerAuthentication,
                    localizedReason: reason
                ) { success, error in
                    if success {
                        // Handle successful authentication
                        print("SUCCESS FACE ID")
                        
                    } else {
                        // Handle LAError error
                        ProgressHUD.showError("Error al intentar iniciar sesion con biometría")
                    }
                }
            }
            else {
                // Handle permission denied or error
            }
        } else {
            signIn(username: "+52" + phoneNumberTextField.text!, password: passwordTextField.text!)
        }
    }

}
