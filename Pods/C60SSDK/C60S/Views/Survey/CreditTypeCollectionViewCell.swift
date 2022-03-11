//
//  CredityTypeCollectionViewCell.swift
//  C60S
//
//  Created by Oscar Inowe on 21/02/22.
//

import UIKit

class CreditTypeCollectionViewCell: UICollectionViewCell {

    var model: CreditTypeModel?
    weak var delegate: CreditTypeDelegate?
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear
    }
    
    
    func setModel(model: CreditTypeModel) {

        self.model = model
        //C60SSDK_START().start(sessionID: "")
        card.layer.cornerRadius = 20
        //card.layer.borderWidth = 0.5
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 2, height: 2)
        card.layer.shadowOpacity = 0.3
        card.layer.shadowRadius = 5.0
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
        }
        if !matches.isEmpty {
            print(matches.last!)
            
            icon.image = UIImage(named: model.icon ?? "", in: matches.last!, with: nil)
        } else {
            icon.image = UIImage(named: model.icon ?? "")
        }
        
        mainLabel.text = model.mainLabel
        subLabel.text = model.subLabel
    }

    
    @IBAction func requestPressed(_ sender: UIButton) {
        delegate?.selectRequestType(model: self.model!)
    }
    
    
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
            
            return UINib(nibName: "CreditTypeCollectionViewCell", bundle: matches.last!)
        } else {
            return UINib(nibName: "CreditTypeCollectionViewCell", bundle: nil)
        }
    }

}
