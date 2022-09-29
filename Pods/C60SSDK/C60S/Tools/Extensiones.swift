//
//  Extensiones.swift
//
//  Created by Madhouse Studio on 2022/07/15.
//  Copyright © 2022 storm. All rights reserved.
//

import UIKit

/// New custom functions in UITextField for validate forms.
extension UITextField {
    
    enum ValidationType {
        case userName
        case email
        case pass
        case confPass
        case phone
        case requerido
        case onlyNumber
        case remove
    }
    
    /// Remove the view of the alert with the corresponding tag.
    /// - Parameter tag: alert tag
    func removeAlert(WithTag tag: Int)  {
        guard let superView = self.superview else { return }
        for view in superView.subviews {
            if view.tag == tag {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    /// Add a subview alert in superview.
    /// - Parameters:
    ///   - alertLabel: UILabel for the alert
    ///   - text: Text for the alert
    ///   - tag: Tag for the alert
    func setAlert(alertLabel: UILabel, withText text: String, andTag tag: Int) {
        alertLabel.text = text
        alertLabel.tag = tag
        alertLabel.numberOfLines = 0
        alertLabel.adjustsFontSizeToFitWidth = true
        
        removeAlert(WithTag: alertLabel.tag)
        self.superview?.addSubview(alertLabel)
    }
    
    /// This function commands to call the differents validations of the form fields.
    /// - Parameters:
    ///   - validationType: type of validation
    ///   - text: text to validate
    ///   - mensaje: mensaje personalizado
    ///   - tag: numero de tag que se quiere remover
    /// - Returns: True if the text field is correct
    func validateTextField(like validationType: ValidationType, withText text: String, mensaje mensajeText: String?, tag removeTag: Int?) -> Bool {
        
        let validation = Validation()
        let alertLabel = UILabel()
        let topMargin: CGFloat = 3
        
        var heightAlert: CGFloat = 13
        if validationType == .pass {
            heightAlert = 60
        }
        
        
        print(self.frame)
        alertLabel.textColor = .red
        alertLabel.font = GlobalConstants.Design.Font.fuenteAlertaLabel
        alertLabel.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y + self.frame.height + topMargin, width: self.frame.size.width, height: heightAlert)
        
        switch validationType {
            case .userName:
                let isValidateName = validation.validateUserName(userName: text)
                if (isValidateName == false /* !isValidateName */) {
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? "Nombre de usuario incorrecto", andTag: 7771)
                    print("Incorrect Name")
                    return false
                } else {
                    removeAlert(WithTag: 7771)
                    print("Correct Name")
                    return true
                }
            case .email:
                let isValidateName = validation.validateEmail(emailID: text)
                if (isValidateName == false) {
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? NSLocalizedString("Email incorrecto", comment: "Texto de email incorrecto"), andTag: 7772)
                    print("Incorrect Email")
                    return false
                } else {
                    removeAlert(WithTag: 7772)
                    print("Correct Email")
                    return true
                }
            case .pass:
                let isValidatePass = validation.validatePassword(password: text)
                UserDefaults.standard.setValue(text, forKey: "passUser")
                if (isValidatePass == false) {
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? NSLocalizedString("Password incorrecto", comment: "Pass incorrecto"), andTag: 7773)
                    print("Incorrect Pass")
                    return false
                } else {
                    removeAlert(WithTag: 7773)
                    print("Correct Pass")
                    //Persistir el string del password para después compararlo con el de confirmación para implementarlo en la validación de este último.
                    return true
                }
            case .confPass:
                let passUser =  UserDefaults.standard.string(forKey: "passUser")
                let confirmarPass = text
                if (passUser == confirmarPass) {
                    removeAlert(WithTag: 7774)
                    print("Correct Confirmar Pass")
                    return true
                } else {
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? NSLocalizedString("Confirma password incorrecto", comment: "Confirm pass incorrecto"), andTag: 7774)
                    print("Incorrect Confirmar Pass")
                    return false
                }
            case .phone:
                let isValidatePass = validation.validatePhoneNumber(phoneNumber: text)
                if (isValidatePass == false) {
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? "Número de teléfono incorrecto", andTag: 7775)
                    print("Incorrect Phone")
                    return false
                } else {
                    removeAlert(WithTag: 7775)
                    print("Correct Phone")
                    return true
                }
           case .requerido:
                let isRequerido : Bool
                if (text == ""){
                    isRequerido = false
                }else{
                    isRequerido = true
                }
                if isRequerido == false{
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? NSLocalizedString("Campo requerido", comment: "campo requerido confirmacion"), andTag: 7776)
                    print("campo vacio")
                    return false
                } else {
                    removeAlert(WithTag: 7776)
                    print("Correct Phone")
                    return true
                }
            case .onlyNumber:
                let onlyNumberValidate = validation.validateOnlyNumbers(otherField: text)
                if(onlyNumberValidate == false){
                    print("soy mensaje de Text:")
                    setAlert(alertLabel: alertLabel, withText: mensajeText ?? NSLocalizedString("Solo números", comment: "solo numeros verificacion"), andTag: 7777)
                    print("Incorrect valor")
                    return false
                }else{
                    removeAlert(WithTag: 7777)
                    print("Correct valor")
                    return true
                }
            case .remove:
                removeAlert(WithTag: removeTag ?? 0)
                return true
        }
    }
}
