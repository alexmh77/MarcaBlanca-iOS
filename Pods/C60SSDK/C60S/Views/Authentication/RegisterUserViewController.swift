//
//  RegisterUserViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Material
import ProgressHUD
import Amplify

class RegisterUserViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var lastnameTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var statePickerView: UIPickerView!
    
    let visualAssets = VisualAssets()
    let requests = SCSRequests()
    let fontSize: Double = 20.0
    let userValidators = UserDataValidators()
    var idPhoneNumber: String?
    var countries: [Country] = []
    var states: [States] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask data from SCS
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        statePickerView.delegate = self
        statePickerView.dataSource = self
        
        
        

        // Do any additional setup after loading the view.
        backButton.setTitle("", for: .normal)
        registerButton.isEnabled = false
        
        nameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        lastnameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        phoneNumberTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        emailTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        passwordTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        confirmPasswordTextField.font = UIFont(name: "Avenir Medium", size: fontSize)

        nameTextField.textColor = visualAssets.colorNameBlue
        nameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        nameTextField.dividerActiveColor = visualAssets.colorNameBlue
        nameTextField.dividerNormalColor = visualAssets.colorNameBlue
        nameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        nameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        lastnameTextField.textColor = visualAssets.colorNameBlue
        lastnameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        lastnameTextField.dividerActiveColor = visualAssets.colorNameBlue
        lastnameTextField.dividerNormalColor = visualAssets.colorNameBlue
        lastnameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        lastnameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        phoneNumberTextField.textColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        phoneNumberTextField.dividerActiveColor = visualAssets.colorNameBlue
        phoneNumberTextField.dividerNormalColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderActiveColor = visualAssets.colorNameBlue
        phoneNumberTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        emailTextField.textColor = visualAssets.colorNameBlue
        emailTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        emailTextField.dividerActiveColor = visualAssets.colorNameBlue
        emailTextField.dividerNormalColor = visualAssets.colorNameBlue
        emailTextField.placeholderActiveColor = visualAssets.colorNameBlue
        emailTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        passwordTextField.textColor = visualAssets.colorNameBlue
        passwordTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        passwordTextField.dividerActiveColor = visualAssets.colorNameBlue
        passwordTextField.dividerNormalColor = visualAssets.colorNameBlue
        passwordTextField.placeholderActiveColor = visualAssets.colorNameBlue
        passwordTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        confirmPasswordTextField.textColor = visualAssets.colorNameBlue
        confirmPasswordTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        confirmPasswordTextField.dividerActiveColor = visualAssets.colorNameBlue
        confirmPasswordTextField.dividerNormalColor = visualAssets.colorNameBlue
        confirmPasswordTextField.placeholderActiveColor = visualAssets.colorNameBlue
        confirmPasswordTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        
        phoneNumberTextField.keyboardType = .numberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        requests.getCountries(completion: { countries in
            self.countries = countries ?? []
            self.countryPickerView.reloadAllComponents()
            self.requests.getStates(countryId: countries?[0].id ?? 0, completion: { states in
                self.states = states ?? []
                self.statePickerView.reloadAllComponents()
            })
        })
    }
    
    

    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func valueChangedTextEdit(_ sender: TextField) {
        if (!(nameTextField.text?.isEmpty)! && !(lastnameTextField.text?.isEmpty)! && !(phoneNumberTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && !(confirmPasswordTextField.text?.isEmpty)!) {
            registerButton.isEnabled = true
        } else {
            registerButton.isEnabled = false
        }
    }
    
    
    @IBAction func registerUser(_ sender: UIButton) {
        if (!userValidators.isValid(name: nameTextField.text!)) {
            ProgressHUD.showError("Nombre no valido, ingresalo nuevamente")
            return
        }
        
        if (!userValidators.isValid(name: lastnameTextField.text!)) {
            ProgressHUD.showError("Apellido no valido, ingresalo nuevamente")
            return
        }
        
        
        if (passwordTextField.text != confirmPasswordTextField.text) {
            ProgressHUD.showError("Las contraseñas no coinciden, ingresalas nuevamente")
            return
        }
        
        signUp(phoneNumber: phoneNumberTextField.text!, password: passwordTextField.text!, email: emailTextField.text!, name: nameTextField.text!, lastname: lastnameTextField.text!)
    }
    
    
    func signUp(phoneNumber: String, password: String, email: String, name: String, lastname: String) {
        let newphoneNumber = "+52" + phoneNumber // Mexico
        idPhoneNumber = newphoneNumber
        var userAttributes: [AuthUserAttribute]?
        
        let countryId = String(self.countries[self.countryPickerView.selectedRow(inComponent: 0)].id)
        let stateId = String(self.states[self.statePickerView.selectedRow(inComponent: 0)].id)
        print("CountryId: \(countryId)")
        print("StateId: \(stateId)")
        
        if (email == "") {
            userAttributes = [AuthUserAttribute(.phoneNumber, value: newphoneNumber),
                                  AuthUserAttribute(.name, value: name),
                                  AuthUserAttribute(.familyName, value: lastname),
                                  AuthUserAttribute(.custom("countryId"), value: countryId),
                                  AuthUserAttribute(.custom("stateId"), value: stateId)]
        } else {
            userAttributes = [AuthUserAttribute(.phoneNumber, value: newphoneNumber),
                                  AuthUserAttribute(.email, value: email),
                                  AuthUserAttribute(.name, value: name),
                                  AuthUserAttribute(.familyName, value: lastname),
                                  AuthUserAttribute(.custom("countryId"), value: countryId),
                                  AuthUserAttribute(.custom("stateId"), value: stateId)]
        }
        
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: newphoneNumber, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    
                    DispatchQueue.main.sync {
                        self.performSegue(withIdentifier: "otpRegisterSegue", sender: nil)
                    }
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                DispatchQueue.main.sync {
                    ProgressHUD.showError("Error en registro de usuario")
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "otpRegisterSegue") {
            // pass data to next view
            let viewController = segue.destination as? OTPRegisterViewController
            viewController!.username = idPhoneNumber
            viewController!.password = passwordTextField.text!
        }
    }
}


extension RegisterUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return countries.count
        } else {
            return states.count
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return countries[row].name
        } else {
            return states[row].name
        }
    }
}
