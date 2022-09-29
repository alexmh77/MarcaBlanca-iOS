//
//  HeaderCell.swift
//  C60S
//
//  Created by Sayab Perez on 24/05/22.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    //static let HeaderCellReusable = String(describing: HeaderCell.self)
    @IBOutlet weak var logo: UIImageView!

    static func nib() -> UINib {
        
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
       }
        if !matches.isEmpty {
            print(matches.last!)
            
            return UINib(nibName: "HeaderCell", bundle: matches.last!)
        }else{
            return UINib(nibName: "HeaderCell", bundle: nil)
        }
        
    }
}
