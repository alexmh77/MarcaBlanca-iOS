//
//  AmountModel.swift
//  C60S
//
//  Created by Oscar Inowe on 18/01/22.
//

import Foundation

class AmountModel {
    var id: Int
    var name: String?
    var description: String?
    var value: Int?
    var categoryid: Int?
    var status = false
    var index: Int?
    
    init(id: Int, name: String?, description: String?, value: Int?, categoryid: Int?, status: Bool, index: Int?) {
        self.id = id
        self.name = name
        self.description = description
        self.value = value
        self.categoryid = categoryid
        self.status = status
        self.index = index
    }
}
