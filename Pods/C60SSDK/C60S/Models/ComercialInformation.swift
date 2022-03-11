//
//  ComercialInformation.swift
//  C60S
//
//  Created by Bruno Trindade on 07/02/22.
//

import Foundation

class ComercialInformation {
    
    var name: String
    var giro: String
    var ubicacion: String
    var antiquedad: String
    var rfc: String
    
    init(name: String, giro: String, ubicacion: String, antiquedad: String, rfc: String) {
        self.name = name
        self.giro = giro
        self.ubicacion = ubicacion
        self.antiquedad = antiquedad
        self.rfc = rfc
    }
    
}
