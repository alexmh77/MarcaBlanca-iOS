//
//  CreditTypeModel.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import Foundation
import UIKit

class CreditTypeModel {
    var id: Int
    var icon: String?
    var mainLabel: String
    var subLabel: String
    var buttonLabel: String
    
    init(id: Int, icon: String, mainLabel: String, subLabel: String, buttonLabel: String) {
        self.id = id
        self.icon = icon
        self.mainLabel = mainLabel
        self.subLabel = subLabel
        self.buttonLabel = buttonLabel
    }
}
