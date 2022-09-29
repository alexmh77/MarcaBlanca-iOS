//
//  Constants.swift
//  BaseMagicTools
//
//  Created by Madhouse Studio on 15/07/2022.
//

import Foundation
import UIKit

/// Global constants
struct GlobalConstants {
    
    static let SIM: Bool = true
    
    static let version : String = "V 1.7.22"
    
    struct Design {
        
        struct Color {
            static let fondoPrincipal: UIColor = UIColor(named: "Fondo") ?? UIColor()
            static let fondoPrincipal2: UIColor = UIColor(named: "Fondo2") ?? UIColor()
        }
        
        struct Image {
            static let userPic: UIImage = UIImage(named: "UserPic") ?? UIImage()
        }
        
        struct Font {
            static let fuentePrincipal: UIFont = UIFont(name: "Helvetica Neue", size: 16) ?? UIFont()
            static let fuenteAlertaLabel: UIFont = UIFont(name: "Helvetica Neue", size: 12) ?? UIFont()
        }

        struct HomeScreen {
            static let rowHeighOperatorA: CGFloat = 6.0
            static let rowHeighOperatorB: CGFloat = 14.0
        }
    }
    
}
