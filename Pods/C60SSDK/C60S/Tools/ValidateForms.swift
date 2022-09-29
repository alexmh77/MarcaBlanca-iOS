//
//  ValidateForms.swift
//  BaseMagicTools
//
//  Created by Madhouse Studio on 15/07/2022.
//

import Foundation

/// Class to validate the various text fields
class Validation {
    
    public func validateUserName(userName: String) ->Bool {
        // Length be 18 characters max and 3 characters minimum, you can always modify.
        let nameRegex = "^\\w{3,18}$"
        let trimmedString = userName.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    
    public func validatePhoneNumber(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
    
    public func validateEmail(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = emailID.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValidateEmail = validateEmail.evaluate(with: trimmedString)
        return isValidateEmail
    }
    
    public func validatePassword(password: String) -> Bool {
        //Minimum 8 characters at least 1 Alphabet and 1 Number:
        let passRegEx = "^(?=.*\\d)(?=.*[\\u0021-\\u002F\\u003c-\\u0040\\u005F])(?=.*[A-Z])(?=.*[a-z])\\S{8,16}$"
        let trimmedString = password.trimmingCharacters(in: .whitespaces)
        let validatePassord = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        let isvalidatePass = validatePassord.evaluate(with: trimmedString)
        return isvalidatePass
    }
    
    public func validateOnlyNumbers(otherField: String) -> Bool {
        let onlyNumbers = "^[0-9]+$"
        let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
        let validateOnlyNumbers = NSPredicate(format: "SELF MATCHES %@", onlyNumbers)
        let isValidateOnlyNumbers = validateOnlyNumbers.evaluate(with: trimmedString)
        return isValidateOnlyNumbers
    }
    
    public func validateAnyOtherTextField(otherField: String) -> Bool {
        let otherRegexString = "Your regex String"
        let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
