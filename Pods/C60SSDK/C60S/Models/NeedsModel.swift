//
//  NeedsModel.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import Foundation

class NeedsModel {
    var id: Int
    var name: String?
    var description: String?
    var categoryid: Int
    var status = false
    var index: Int?
    
    init(id: Int, name: String?, description: String?, categoryid: Int, status: Bool, index: Int) {
        self.id = id
        self.name = name
        self.description = description
        self.categoryid = categoryid
        self.status = status
        self.index = index
    }
}
