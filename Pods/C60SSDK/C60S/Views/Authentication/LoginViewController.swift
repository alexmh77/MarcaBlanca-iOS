//
//  LoginViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
//import Amplify
import ProgressHUD
import Material
import LocalAuthentication

class LoginViewController: BaseViewController,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        return cell
    }
    
    
    
    //@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var countryCodePickerView: UIPickerView!
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var authSwitch: UISwitch!
    var codeCountry = ["+52","+51","+1"]
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Ingresar: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    let visualAssets = VisualAssets()
    var context = LAContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phoneNumberTextField.placeholder = NSLocalizedString("Número telefónico", comment: "Texto de telefono")
        self.passwordTextField.placeholder = NSLocalizedString("Contraseña", comment: "Texto de contraseña")
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
                
        self.Ingresar.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        countryCodePickerView.delegate = self
        countryCodePickerView.dataSource = self
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header

        dismissButton.setTitle("", for: .normal)
                
                
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
                
                        
                
                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissCustom))
                view.addGestureRecognizer(tap)
        
        SCSRequests().setTracker(id: 21, orgid: 1, typeid: 21){
            s in print("RESPUESTA EN TRACKER PANTALLA 21 ####### \(s)")
        }
    }
    
    @objc func dismissCustom(){
        view.endEditing(true)
    }
    
    
    @IBAction func authChanged(_ sender: UISwitch) {
        
    }
    
    
    func signIn(username: String, password: String) {
        print("Signing in...")
        
//        Amplify.Auth.signIn(username: username, password: password) { result in
//            do {
//                let signinResult = try result.get()
//                switch signinResult.nextStep {
//                    case .confirmSignInWithSMSMFACode(let deliveryDetails, let info):
//                        print("SMS code send to \(deliveryDetails.destination)")
//                        print("Additional info \(info)")
//
//                        // Prompt the user to enter the SMSMFA code they received
//                        // Then invoke `confirmSignIn` api with the code
//                    case .resetPassword(let info):
//                        print("Reset password additional info \(info)")
//                    case .confirmSignUp(let info):
//                        print("Confirm signup additional info \(info)")
//                        
//                        // User was not confirmed during the signup process.
//                        // Invoke `confirmSignUp` api to confirm the user if
//                        // they have the confirmation code. If they do not have the
//                        // confirmation code, invoke `resendSignUpCode` to send the
//                        // code again.
//                        // After the user is confirmed, invoke the `signIn` api again.
//                    case .done:
//                    
//                    self.fetchAttributes()
//                        DispatchQueue.main.sync {
//                            self.performSegue(withIdentifier: "homeLoginSegue", sender: nil)
//                        }
//                    default:
//                        DispatchQueue.main.sync {
//                            ProgressHUD.showError(NSLocalizedString("Error en inicio de sesión", comment: "error inicio de sesion"))
//                        }
//                }
//            } catch {
//                print ("Sign in failed \(error)")
//                DispatchQueue.main.sync {
//                    ProgressHUD.showError(NSLocalizedString("Error en inicio de sesión", comment: "error inicio de sesion"))
//                }
//            }
//        }
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        print("si entre aqui")
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
                        ProgressHUD.showError(NSLocalizedString("Error al intentar iniciar sesión con biometría", comment: "error biometria"))
                    }
                }
            }
            else {
                // Handle permission denied or error
            }
        } else {
            let prefix = String(self.codeCountry[self.countryCodePickerView.selectedRow(inComponent: 0)])
            print("prefix \(prefix)")
            let phone = phoneNumberTextField.text!.filter("0123456789".contains)
            signIn(username: prefix + phone, password: passwordTextField.text!)
        }
    }

    
    func fetchAttributes() {
//        Amplify.Auth.fetchUserAttributes() { result in
//            switch result {
//            case .success(let attributes):
//                print("User attributes - \(attributes)")
//            case .failure(let error):
//                print("Fetching user attributes failed with error \(error)")
//            }
//        }
    }
}


extension LoginViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
            return codeCountry.count
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
            return codeCountry[row].description
        
    }
    
    
}


