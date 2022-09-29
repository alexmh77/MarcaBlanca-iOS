//
//  VisualAssets.swift
//  C60S
//
//  Created by Oscar Inowe on 03/12/21.
//

import Foundation
import UIKit

struct VisualAssets {
    let colorNameBlue = getColorBlue() //UIColor(named: "AppBlueColor")!
    let colorNameLightBlue = getColorLigthBlue()//UIColor(named: "BlueLightColor")!
    let fontSize: Double = 20.0
    let font: String = "Avenir Medium"
    let fontLabel: String = "Avenir Heavy"
}

func getColorBlue()->UIColor{
    let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
        if let identifier = aBundle.bundleIdentifier {
            return identifier.contains("org.cocoapods.C60SSDK")
        } else {
            return false
        }
    }
    if !matches.isEmpty {
         print(matches.last!)
        return UIColor(named: "AppBlueColor",in: matches.last!, compatibleWith: nil)!
        // icon.image = UIImage(named: model.icon ?? "", in: matches.last!, with: nil)
     } else {
         return UIColor(named: "AppBlueColor")!
        // icon.image = UIImage(named: model.icon ?? "")
     }
}

func getColorLigthBlue()->UIColor{
    let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
        if let identifier = aBundle.bundleIdentifier {
            return identifier.contains("org.cocoapods.C60SSDK")
        } else {
            return false
        }
    }
    if !matches.isEmpty {
         print(matches.last!)
        return UIColor(named: "BlueLightColor",in: matches.last!, compatibleWith: nil)!
        // icon.image = UIImage(named: model.icon ?? "", in: matches.last!, with: nil)
     } else {
         return UIColor(named: "BlueLightColor")!
        // icon.image = UIImage(named: model.icon ?? "")
     }
}

class cornerCustom: UICollectionView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 20
       
    }
    
}
