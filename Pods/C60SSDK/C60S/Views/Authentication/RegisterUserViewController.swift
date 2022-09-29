//
//  RegisterUserViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//
import Foundation
import UIKit
import Material
import ProgressHUD
//import Amplify

class RegisterUserViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //@IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var espacio: UIView!
    @IBOutlet weak var constrainPass: NSLayoutConstraint!
    @IBOutlet weak var alturaConstraintContenedor: NSLayoutConstraint!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var lastnameTextField: TextField!
    @IBOutlet weak var phoneNumberTextField: TextField!
    @IBOutlet weak var emailTextField: TextField!
    @IBOutlet weak var passwordTextField: TextField!
    @IBOutlet weak var confirmPasswordTextField: TextField!
    @IBOutlet weak var registerButton: UIButton!
    //@IBOutlet weak var countryPickerView: UIPickerView!
    //@IBOutlet weak var statePickerView: UIPickerView!
    @IBOutlet weak var countryCodePickerView: UIPickerView!
    
    @IBOutlet weak var countryField: TextField!
    @IBOutlet weak var stateField: TextField!
    //@IBOutlet weak var pickerViewCountryField: UIPickerView!
    let pickerViewCountryField = UIPickerView()
    //@IBOutlet weak var pickerViewStateField: UIPickerView!
    let pickerViewStateField = UIPickerView()
    
    @IBOutlet weak var titleBig: UILabel!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var containerForm: UIView!
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    //@IBOutlet weak var TitleBig: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var buttonCodeCountry: UIButton!
    
    
    @IBOutlet weak var background: UIImageView!
    let visualAssets = VisualAssets()
    let requests = SCSRequests()
    let fontSize: Double = 20.0
    let userValidators = UserDataValidators()
    var idPhoneNumber: String?
    var countries: [Country] = []
    var codeCountry = ["+52","+51","+1"]
    var states: [States] = []
    let inputColor =  UIColor(named: "AppGrayLightColor")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        espacio.isHidden = true
        //let countryTest = ["country1", "country2", "country3"]
        //let pickerViewCountryField = UIPickerView()
        pickerViewCountryField.delegate = self
        pickerViewCountryField.dataSource = self
        pickerViewCountryField.tag = 0
        
        //let pickerViewStateField = UIPickerView()
        pickerViewStateField.delegate = self
        pickerViewStateField.dataSource = self
        pickerViewStateField.tag = 1
        //picker style in input
        countryField.inputView = pickerViewCountryField
        stateField.inputView = pickerViewStateField
        //picker style in input
        
        self.titleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        // header
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.layer.cornerRadius = 30.0
        self.HeaderTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        // Ask data from SCS
       // countryPickerView.delegate = self
       // countryPickerView.dataSource = self
       // countryPickerView.tag = 0
       // statePickerView.tag = 1
        countryCodePickerView.tag = 2
       // statePickerView.delegate = self
       // statePickerView.dataSource = self
        countryCodePickerView.delegate = self
        countryCodePickerView.dataSource = self
        
        //card
        containerForm.layer.cornerRadius = 20
        //button
        self.registerButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        //labels
        self.nameLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.confirmPasswordLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.passwordLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.emailLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.phoneLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.lastnameLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        //self.TitleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        self.instructionsLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.countryLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.stateLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        
        
        // Do any additional setup after loading the view.
        //backButton.setTitle("", for: .normal)
        //registerButton.isEnabled = false
        
        nameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        lastnameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        phoneNumberTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        emailTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        passwordTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        confirmPasswordTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        countryField.font = UIFont(name: "Avenir Medium", size: fontSize)
        stateField.font = UIFont(name: "Avenir Medium", size: fontSize)
        
        nameTextField.textColor = .black
        //nameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        nameTextField.dividerActiveColor = inputColor
        nameTextField.dividerNormalColor = inputColor
        //nameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //nameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        lastnameTextField.textColor = .black
        //lastnameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        lastnameTextField.dividerActiveColor = inputColor
        lastnameTextField.dividerNormalColor = inputColor
        //lastnameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //lastnameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        phoneNumberTextField.textColor = .black
        //phoneNumberTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        phoneNumberTextField.dividerActiveColor = inputColor
        phoneNumberTextField.dividerNormalColor = inputColor
        //phoneNumberTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //phoneNumberTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        emailTextField.textColor = .black
        //emailTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        emailTextField.dividerActiveColor = inputColor
        emailTextField.dividerNormalColor = inputColor
        //emailTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //emailTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        passwordTextField.textColor = .black
        //passwordTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        passwordTextField.dividerActiveColor = inputColor
        passwordTextField.dividerNormalColor = inputColor
        //passwordTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //passwordTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        confirmPasswordTextField.textColor = .black
        //confirmPasswordTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        confirmPasswordTextField.dividerActiveColor = inputColor
        confirmPasswordTextField.dividerNormalColor = inputColor
        //confirmPasswordTextField.placeholderActiveColor = visualAssets.colorNameBlue
        //confirmPasswordTextField.placeholderNormalColor = visualAssets.colorNameBlue
        
        countryField.textColor = .black

        countryField.dividerActiveColor = inputColor
        countryField.dividerNormalColor = inputColor
        
        stateField.textColor = .black

        stateField.dividerActiveColor = inputColor
        stateField.dividerNormalColor = inputColor
        
        phoneNumberTextField.keyboardType = .numberPad
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissCustom))
        view.addGestureRecognizer(tap)
        
        SCSRequests().setTracker(id: 23, orgid: 1, typeid: 23){
            s in print("RESPUESTA EN TRACKER PANTALLA 23 ####### \(s)")
        }
        
    }
    
    @IBAction func codePressed(_ sender: Any) {
        print("tap code")
    }
    @objc func dismissCustom(){
        
        view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.setValue("", forKey: "passUser")
        requests.getCountries(completion: { countries in
            self.countries = countries ?? []
           // self.countryPickerView.reloadAllComponents()
            self.requests.getStates(countryId: countries?[0].id ?? 0, completion: { states in
                self.states = states ?? []
                //self.statePickerView.reloadAllComponents()
                self.countryCodePickerView.reloadAllComponents()
            })
        })
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func valueChangedTextEdit(_ sender: TextField) {
        
        /*if sender.tag == 1{
            print("Soy campo nombre")
            
            let namePersona = self.nameTextField.text ?? ""
            
            let nameValid = nameTextField.validateTextField(like: .requerido, withText: namePersona, mensaje: NSLocalizedString("Por favor, escriba su(s) nombre(s)", comment: "escriba nombre"))
            
            if(nameValid){
                formValidate = true
            }
        }
        else
        if sender.tag == 2{
            print("Soy campo apellido")
            let lasNamePersona = self.lastnameTextField.text ?? ""
            
            let lastNameValid = lastnameTextField.validateTextField(like: .requerido, withText: lasNamePersona, mensaje: NSLocalizedString("Por favor, escriba su(s) apellido(s)", comment: "estriba apellidos"))
            
            if(lastNameValid){
                formValidate = true
            }
        }
        else
        if sender.tag == 3{
            print("Soy campo telefono")
            let phoneNumberPersona = self.phoneNumberTextField.text ?? ""
            
            let pNValidate = phoneNumberTextField.validateTextField(like: .requerido, withText: phoneNumberPersona, mensaje: NSLocalizedString("Por favor, escriba su número celular", comment: "escriba celular"))
            
            if(pNValidate){
                pNValid = phoneNumberTextField.validateTextField(like: .phone, withText: phoneNumberPersona, mensaje: nil)
                p
            }
        }
        else
        if sender.tag == 4{
            print("Soy campo email")
        }
        else
        if sender.tag == 5{
            print("Soy campo contraseña")
        }
        else
        if sender.tag == 6{
            print("Soy campo conf contraseña")
        }
        else
        if sender.tag == 7{
            print("Soy campo pais")
        }
        else
        if sender.tag == 8{
            print("Soy campo estado")
        }*/
        //print("cambie 😝")
        //registerButton.isEnabled = true
        //print("registerButton.isEnabled true")
        //TO DO Agregar un mensaje cuando el password este incorrecto
        /*if (!(nameTextField.text?.isEmpty)! && !(lastnameTextField.text?.isEmpty)! && !(countryField.text?.isEmpty)! && !(stateField.text?.isEmpty)! && !(phoneNumberTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)! && !(confirmPasswordTextField.text?.isEmpty)!) {
            registerButton.isEnabled = true
            print("registerButton.isEnabled true")
        } else {
            registerButton.isEnabled = false
            print("registerButton.isEnabled false")
        }*/
        
        validateFormRegister()
    }
    
    
    @IBAction func registerUser(_ sender: UIButton) {
        
        print("entre a register user")
        
        /*if (!userValidators.isValid(name: nameTextField.text!)) {
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
        
        signUp(phoneNumber: phoneNumberTextField.text!, password: passwordTextField.text!, email: emailTextField.text!, name: nameTextField.text!, lastname: lastnameTextField.text!)*/
        
        if validateFormRegister(){
            signUp(phoneNumber: phoneNumberTextField.text!, password: passwordTextField.text!, email: emailTextField.text!, name: nameTextField.text!, lastname: lastnameTextField.text!)
        }
    }
    
    func validateFormRegister() -> Bool{
        guard let namePersona = self.nameTextField.text,
              let lasNamePersona = self.lastnameTextField.text,
              let phoneNumberPersona = self.phoneNumberTextField.text,
              let emailPersona = self.emailTextField.text,
              let passPersona = self.passwordTextField.text,
              let confPassPersona = self.confirmPasswordTextField.text,
              let countryPersona = self.countryField.text,
              let statePersona = self.stateField.text
        else{
            return true
        }
        
        let nameValidate = nameTextField.validateTextField(like: .requerido, withText: namePersona, mensaje: NSLocalizedString("Por favor, escriba su(s) nombre(s)", comment: "escriba nombre"), tag: nil)
        let lasNameValidate = lastnameTextField.validateTextField(like: .requerido, withText: lasNamePersona, mensaje: NSLocalizedString("Por favor, escriba su(s) apellido(s)", comment: "estriba apellidos"), tag: nil)
        let phoneNumberValidate = phoneNumberTextField.validateTextField(like: .requerido, withText: phoneNumberPersona, mensaje: NSLocalizedString("Por favor, escriba su número celular", comment: "escriba celular"), tag: nil)
        let passValidate = passwordTextField.validateTextField(like: .requerido, withText: passPersona, mensaje: NSLocalizedString("Por favor, escriba su contraseña", comment: "escriba contraseña"), tag: nil)
        let confPass = confirmPasswordTextField.validateTextField(like: .confPass, withText: confPassPersona, mensaje: NSLocalizedString("Su contraseña no coincide con la primera ingresada", comment: "contraseña coincide"), tag: nil)
        let countryValidate = countryField.validateTextField(like: .requerido, withText: countryPersona, mensaje: NSLocalizedString("Por favor, seleccione el país", comment: "seleccion pais"), tag: nil)
        let stateValidate = stateField.validateTextField(like: .requerido, withText: statePersona, mensaje: NSLocalizedString("Por favor, seleccione el estado", comment: "seleccion estado"), tag: nil)
        
        if(phoneNumberPersona != ""){
            let pNValidate = phoneNumberTextField.validateTextField(like: .phone, withText: phoneNumberPersona, mensaje: nil, tag: nil)
            
            if(!pNValidate){
                return false
            }
        }else{
            _ = phoneNumberTextField.validateTextField(like: .remove, withText: "", mensaje: nil, tag: 7775)
        }
        
        if(emailPersona != ""){
            let emailValidate = emailTextField.validateTextField(like: .email, withText: emailPersona, mensaje: NSLocalizedString("Formato de correo incorrecto", comment: "formato incorrecto correo"), tag: nil)
            
            if(!emailValidate){
               return false
            }
        }else{
            _ = emailTextField.validateTextField(like: .remove, withText: "", mensaje: nil, tag: 7772)
        }
        
        if(passPersona != ""){
            let passwValidate = passwordTextField.validateTextField(like: .pass, withText: passPersona, mensaje: NSLocalizedString("Su contraseña debe contener al menos 1 minúscula, 1 mayúscula, 1 dígito y 1 caracter especial, no debe tener espacios. Mínimo 8 caracteres y máximo 16", comment: "contraseña restricciones"), tag: nil)
            
            if (passwValidate) {
                self.alturaConstraintContenedor.constant = 800
                self.constrainPass.constant = 52
                self.espacio.isHidden = true
            }else{
                self.alturaConstraintContenedor.constant = 838
                self.constrainPass.constant = 90
                self.espacio.isHidden = false
            }
        }else {
            self.alturaConstraintContenedor.constant = 800
            self.constrainPass.constant = 52
            self.espacio.isHidden = true
            _ = passwordTextField.validateTextField(like: .remove, withText: "", mensaje: nil, tag: 7773)
            _ = confirmPasswordTextField.validateTextField(like: .remove, withText: "", mensaje: nil, tag: 7774)
        }
        
        if(nameValidate && lasNameValidate && phoneNumberValidate && passValidate && confPass && countryValidate && stateValidate){
            return true
        }
        return false
    }//validateFormRegister
    
    func signUp(phoneNumber: String, password: String, email: String, name: String, lastname: String) {
//        let prefix = String(self.codeCountry[self.countryCodePickerView.selectedRow(inComponent: 0)])
//        print("prefix \(prefix)")
//        let newphoneNumber = prefix + phoneNumber.filter("0123456789".contains) // Mexico
//        idPhoneNumber = newphoneNumber
//        var userAttributes: [AuthUserAttribute]?
//        
//        //let countryId = String(self.countries[self.countryPickerView.selectedRow(inComponent: 0)].id)
//        
//        let countryId = String(self.countries[self.pickerViewCountryField.selectedRow(inComponent: 0)].id)
//        
//        print("el country que elegi es:")
//        print(countryId)
//        
//        //let stateId = String(self.states[Int(self.statePickerView.selectedRow(inComponent: 0))].id)
//        let stateId = String(self.states[Int(self.pickerViewStateField.selectedRow(inComponent: 0))].id)
//        
//        print("el state que elegi es:")
//        print(stateId)
//        
//        print("CountryId: \(countryId)")
//        print("StateId: \(stateId)")
//        
//        if (email == "") {
//            userAttributes = [AuthUserAttribute(.phoneNumber, value: newphoneNumber),
//                              AuthUserAttribute(.name, value: name),
//                              AuthUserAttribute(.familyName, value: lastname),
//                              AuthUserAttribute(.custom("countryId"), value: countryId),
//                              AuthUserAttribute(.custom("stateId"), value: stateId),
//                              AuthUserAttribute(.custom("consumerId"), value: String(SurveyData.shared.getConsumerId()))]
//        } else {
//            userAttributes = [AuthUserAttribute(.phoneNumber, value: newphoneNumber),
//                              AuthUserAttribute(.email, value: email),
//                              AuthUserAttribute(.name, value: name),
//                              AuthUserAttribute(.familyName, value: lastname),
//                              AuthUserAttribute(.custom("countryId"), value: countryId),
//                              AuthUserAttribute(.custom("stateId"), value: stateId),
//                              AuthUserAttribute(.custom("consumerId"), value: String(SurveyData.shared.getConsumerId()))]
//        }
//        
//        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
//        Amplify.Auth.signUp(username: newphoneNumber, password: password, options: options) { result in
//            switch result {
//            case .success(let signUpResult):
//                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
//                    print("Delivery details \(String(describing: deliveryDetails))")
//                    
//                    DispatchQueue.main.sync {
//                        self.updateConsumer()
//                        SurveyData.shared.setName(customerName: self.nameTextField.text ?? "")
//                        UserDefaults.standard.setValue("", forKey: "passUser")
//                        self.performSegue(withIdentifier: "otpRegisterSegue", sender: nil)
//                    }
//                } else {
//                    print("SignUp Complete")
//                }
//            case .failure(let error):
//                print("An error occurred while registering a user \(error)")
//                //Se verificar el tipo de error para enviar el mensaje del mismo
//                let string = "\(error)"
//                if (string as NSString).contains("usernameExists") {
//                    DispatchQueue.main.sync {
//                        ProgressHUD.showError(NSLocalizedString("Error el usuario ya existe", comment: "Usuario existe"))
//                    }
//                    
//                }else{
//                    DispatchQueue.main.sync {
//                        ProgressHUD.showError(NSLocalizedString("Error en registro de usuario", comment: "error registro usuario"))
//                    }
//                }
//                
//            }
//        }
    }
    
    
    func updateConsumer(){
        
        let data:[String:Any] = [
            "created": "\(Date.now)",
            "modified": "nil",
            "deleted": "nil",
            "id": SurveyData.shared.getConsumerId(),
            "name": nameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "phone": phoneNumberTextField.text?.filter("0123456789".contains) ?? "",
            "stateid": String(self.states[self.pickerViewStateField.selectedRow(inComponent: 0)].id),
            "countryid": String(self.countries[self.pickerViewCountryField.selectedRow(inComponent: 0)].id),
            "password": passwordTextField.text ?? "",
            "consumeruuid": SurveyData.shared.getConsumerId(),
            "firebasetoken": "nil",
            "fathersname": lastnameTextField.text ?? "",
            "mothersname": "",
            "firstname": nameTextField.text ?? "",
            "secondname": lastnameTextField.text ?? "",
            "claro360id": "null"
        ]
        
        
        let datanew:[String:Any] = [
            
            
            "id": SurveyData.shared.getConsumerId(),
            "name": nameTextField.text ?? "",
            "email": emailTextField.text ?? "",
            "phone": phoneNumberTextField.text?.filter("0123456789".contains) ?? "",
            "website": "string",
            "description": "string",
            "lowscorethreshold": 0,
            "campaigncostlimit": 0,
            "dailycostlimit": 0,
            "countryid": String(self.countries[self.pickerViewCountryField.selectedRow(inComponent: 0)].id),
            "stateid": String(self.states[self.pickerViewStateField.selectedRow(inComponent: 0)].id),
            "password": passwordTextField.text ?? "",
            "lenderuuid": "string",
            "kycflag": false,
            "createdate": "2021-01-30T08:30:00Z",
            "modifydate": "2021-01-30T08:30:00Z"
            
            
        ]
        SCSRequests().updateConsumerUser(data: datanew){
            s in
            
            //SurveyData.shared.setName(customerName: s?.name ?? "")
            
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return countries.count
        } else if pickerView.tag == 1{
            return states.count
        }else{
            return codeCountry.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return countries[row].name
        } else if pickerView.tag == 1 {
            return states[row].name
        }else{
            return codeCountry[row].description
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            countryField.text = countries[row].name
        } else if pickerView.tag == 1{
            stateField.text = states[row].name
        }else{
          //  return codeCountry.count
        }
    }
    
    //func header
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell

        return cell
    }
    //func header
    
    
}//RegisterUserViewController


//extension RegisterUserViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //countryField.inputView = countryPickerView
    
    /*func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        print("entro a pickerview")
        if pickerView.tag == 0 {
            return countries.count
        } else if pickerView.tag == 1{
            return states.count
        }else{
            return codeCountry.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("entro a title fpor row")
        if pickerView.tag == 0 {
            return countries[row].name
        } else if pickerView.tag == 1 {
            return states[row].name
        }else{
            return codeCountry[row].description
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TODO
        print("entro a didselectrow")
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
    //func header*/
    
//}


