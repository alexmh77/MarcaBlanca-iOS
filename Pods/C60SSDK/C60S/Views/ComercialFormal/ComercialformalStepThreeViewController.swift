//
//  ComercialformalStepThreeViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit
//import Amplify
import ProgressHUD
import Material

class ComercialformalStepThreeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var buttonNext: UIButton!
    @IBOutlet weak var backUIButton: UIButton!
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var giroTextField: TextField!
    @IBOutlet weak var ubicacionTextField: TextField!
    @IBOutlet weak var antiquedadTextField: TextField!
    @IBOutlet weak var rfcTextField: TextField!
    @IBOutlet weak var containerForm: UIView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: TableView!
    
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rfcLabel: UILabel!
    @IBOutlet weak var antiguedadLabel: UILabel!
    @IBOutlet weak var ubicacionLabel: UILabel!
    @IBOutlet weak var giroLabel: UILabel!
    
    let visualAssets = VisualAssets()
    let fontSize: Double = 16.0
    //let colorNameGray = UIColor(named: "AppGrayLightColor")!
    
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
        
        print("3")
        print(SurveyData.shared.needs)
        
        super.viewDidLoad()
        self.buttonNext.isEnabled = true
        
        nameTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        nameTextField.textColor = .black
        nameTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        nameTextField.dividerActiveColor = getColorBlue()
        nameTextField.dividerNormalColor = getColorBlue()
        nameTextField.placeholderActiveColor = visualAssets.colorNameBlue
        nameTextField.placeholderNormalColor = visualAssets.colorNameBlue
        self.nameLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        
        giroTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        giroTextField.textColor = .black
        giroTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        giroTextField.dividerActiveColor = getColorBlue()
        giroTextField.dividerNormalColor = getColorBlue()
        giroTextField.placeholderActiveColor = visualAssets.colorNameBlue
        giroTextField.placeholderNormalColor = visualAssets.colorNameBlue
        self.giroLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        ubicacionTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        ubicacionTextField.textColor = .black
        ubicacionTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        ubicacionTextField.dividerActiveColor = getColorBlue()
        ubicacionTextField.dividerNormalColor = getColorBlue()
        ubicacionTextField.placeholderActiveColor = visualAssets.colorNameBlue
        ubicacionTextField.placeholderNormalColor = visualAssets.colorNameBlue
        self.ubicacionLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        antiquedadTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        antiquedadTextField.textColor = .black
        antiquedadTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        antiquedadTextField.dividerActiveColor = getColorBlue()
        antiquedadTextField.dividerNormalColor = getColorBlue()
        antiquedadTextField.placeholderActiveColor = visualAssets.colorNameBlue
        antiquedadTextField.placeholderNormalColor = visualAssets.colorNameBlue
        self.antiguedadLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        rfcTextField.font = UIFont(name: "Avenir Medium", size: fontSize)
        rfcTextField.textColor = .black
        rfcTextField.placeholderLabel.textColor = visualAssets.colorNameBlue
        rfcTextField.dividerActiveColor = getColorBlue()
        rfcTextField.dividerNormalColor = getColorBlue()
        rfcTextField.placeholderActiveColor = visualAssets.colorNameBlue
        rfcTextField.placeholderNormalColor = visualAssets.colorNameBlue
        self.rfcLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissCustom))
        view.addGestureRecognizer(tap)
        SCSRequests().setTracker(id: 27, orgid: 1, typeid: 27){
            s in print("RESPUESTA EN TRACKER PANTALLA 27 ####### \(s)")
        }
        
        containerForm.layer.cornerRadius = 20
        self.containerForm.viewStyle(bgcolor: "cardBackgroundColor")
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        // header
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.layer.cornerRadius = 30.0
        self.HeaderTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        self.buttonNext.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        antiquedadTextField.keyboardType = .numberPad
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
    
    @objc func dismissCustom(){
        
        self.view.endEditing(true)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toNextAction(_ sender: UIButton) {
        /*if (nameTextField.text == "" || giroTextField.text == "" || ubicacionTextField.text == "" || antiquedadTextField.text == "" || rfcTextField.text == "")  {
            self.showErrorForm()
        }else{
            // TODO: WRITE in singleton element
            self.performSegue(withIdentifier: "ingresosegue", sender: nil)
        }*/
        if validateFormRegisterComercialFormal(){
            
            SCSRequests().setBusiness(nameBusiness: self.nameTextField.text!, description: self.giroTextField.text!, adress: self.ubicacionTextField.text!, seniority: Int(self.antiquedadTextField.text!)!, rfc: self.rfcTextField.text!){
                s in
                
                print("RESPUESTA bussiness ######## \(s) ")
            }
            
            self.performSegue(withIdentifier: "ingresosegue", sender: nil)
        }
        
    }
    
    @IBAction func valueChangedTextEditComercialFormal(_ sender: Any) {
        validateFormRegisterComercialFormal()
    }
    func validateFormRegisterComercialFormal() -> Bool{
        guard let nameComercial = self.nameTextField.text,
              let giroComercial = self.giroTextField.text,
              let ubicacionComercial = self.ubicacionTextField.text,
              let antiguedadComercial = self.antiquedadTextField.text,
              let rfcComercial = self.rfcTextField.text
        else{
            return true
        }
        let nameValidate = nameTextField.validateTextField(like: .requerido, withText: nameComercial, mensaje: NSLocalizedString("Por favor, escriba el nombre de su empresa", comment: "name empresa"), tag: nil)
        let giroValidate = giroTextField.validateTextField(like: .requerido, withText: giroComercial, mensaje: NSLocalizedString("Por favor, escriba el giro de su empresa", comment: "giro empresa"), tag: nil)
        let ubicacionValidate = ubicacionTextField.validateTextField(like: .requerido, withText: ubicacionComercial, mensaje: NSLocalizedString("Por favor, escriba el domicilio/dirección de su empresa", comment: "domicilio empresa"), tag: nil)
        let antiguedadValidate = antiquedadTextField.validateTextField(like: .requerido, withText: antiguedadComercial, mensaje: NSLocalizedString("Por favor, escriba el número de años de antigüedad de su empresa", comment: "antiguedad empresa") , tag: nil)
        let rfcValidate = rfcTextField.validateTextField(like: .requerido, withText: rfcComercial, mensaje: NSLocalizedString("Por favor, escriba la clave fiscal de su empresa", comment: "fiscal empresa"), tag: nil)
        
        if(antiguedadComercial != ""){
            let antiguedadNums = antiquedadTextField.validateTextField(like: .onlyNumber, withText: antiguedadComercial, mensaje: nil, tag: nil)
            if(!antiguedadNums){
                return false
            }
        }else{
            _ = antiquedadTextField.validateTextField(like: .remove, withText: "", mensaje: nil, tag: 7777)
        }
        
        if (nameValidate && giroValidate && ubicacionValidate && antiguedadValidate && rfcValidate){
            return true
        }
        return false
    }//validateFormRegisterComercial
    
    
    
    func showErrorForm(){
        ProgressHUD.showError(NSLocalizedString("Todos los datos son necesarios, por favor capturalos", comment: "todos los datos"))
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

