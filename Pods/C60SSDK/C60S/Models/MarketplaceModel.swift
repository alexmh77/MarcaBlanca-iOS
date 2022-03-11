//
//  MarketplaceModel.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import Foundation

class MarketplaceModel {
    var id: Int?
    var productid: Int?
    var lenderid: Int?
    var name: String?
    var description: String?
    var unitcost: Int?
    var currencyid: String?
    var tandcid: Int?
    var countryid: Int?
    var stateid: Int?
    var highscore: Int?
    var lowscore: Int?
    var createdate: String?
    var modifydate: String?
    var iconURL: String?
    var collapsed = false
    
    init(id: Int?, productid: Int?, lenderid: Int?, name: String?, description: String?, unitcost: Int?, currencyid: String?, tandcid: Int?, countryid: Int?, stateid: Int?, highscore: Int?, lowscore: Int?, createdate: String?, modifydate: String?, iconURL: String?, collapsed: Bool) {
        self.id = id
        self.productid = productid
        self.lenderid = lenderid
        self.name = name
        self.description = description
        self.unitcost = unitcost
        self.currencyid = currencyid
        self.tandcid = tandcid
        self.countryid = countryid
        self.stateid = stateid
        self.highscore = highscore
        self.lowscore = lowscore
        self.createdate = createdate
        self.modifydate = modifydate
        self.iconURL = iconURL
        self.collapsed = collapsed
    }
}
