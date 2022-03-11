//
//  WorkSurveyModel.swift
//  C60S
//
//  Created by Oscar Inowe on 05/01/22.
//

import Foundation

class WorkSurveyModel {
    var id: Int?
    var name: String?
    var categoryid: Int?
    var description: String?
    var status = false
    var index: Int?
    
    init(id: Int?, name: String?, categoryid: Int?, description: String?, status: Bool, index: Int) {
        self.id = id
        self.name = name
        self.categoryid = categoryid
        self.description = description
        self.status = status
        self.index = index
    }
}
