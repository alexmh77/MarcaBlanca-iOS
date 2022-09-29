//
//  SupportSurveyModel.swift
//  C60S
//
//  Created by Oscar Inowe on 07/01/22.
//

import Foundation
import UIKit

class SupportSurveyModel {
    var id: Int?
    var name: String?
    var icon: String?
    var categoryid: Int?
    var description: String?
    var status = false
    var index: Int?
    var imagen : UIImage? = nil
    
    init(id: Int?, name: String?, icon: String?, categoryid: Int?, description: String?, status: Bool, index: Int) {
        self.id = id
        self.name = name
        self.icon = icon
        self.categoryid = categoryid
        self.description = description
        self.status = status
        self.index = index
    }
}
