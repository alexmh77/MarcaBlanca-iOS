//
//  AmountCollectionViewCell.swift
//  C60S
//
//  Created by Oscar Inowe on 18/01/22.
//

import UIKit

protocol AmountCellDelegate: AnyObject {
    func amountSelected(model: AmountModel)
}

class AmountCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    
    var model: AmountModel?
    weak var delegate: AmountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        card.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.amountSelected(model: self.model!)
    }
    
    
    func setModel(model: AmountModel) {
        
        print("entre a set model 👺")
        self.model = model
        print(model)
        self.amountLabel.text = model.name
        
        if model.status {
            
            print("if de model estatus")
            
            var totalamount = model.name ?? "0"
            
            print("total amount")
            print(totalamount)
            
            totalamount = totalamount.replacingOccurrences(of: "$", with: "", options: .literal, range: nil)
            totalamount = totalamount.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            print("selected::: \(totalamount)")
            SurveyData.shared.setTotalAmount(totalamount: Int(totalamount) ?? 0)
           // card.layer.borderColor = VisualAssets().colorNameLightBlue.cgColor
            //card.layer.shadowColor = UIColor.black.cgColor
            //card.layer.backgroundColor = VisualAssets().colorNameLightBlue.cgColor
            //self.amountLabel.textColor = .white
            /*self.card.viewStyle(bgcolor: "cardBackgroundColor")*/
        } else {
            //card.layer.cornerRadius = 25
            self.amountLabel.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
            card.layer.borderWidth = 0
            card.layer.borderColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            /*card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOffset = CGSize(width: 2, height: 2)
            card.layer.shadowOpacity = 0.3
            card.layer.shadowRadius = 5.0*/
            card.layer.backgroundColor = CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            //self.amountLabel.textColor = VisualAssets().colorNameBlue
            self.card.viewStyle(bgcolor: "cardBackgroundColor")
        }
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
            
            return UINib(nibName: "AmountCollectionViewCell", bundle: matches.last!)
        }else{
            return UINib(nibName: "AmountCollectionViewCell", bundle: nil)
        }
        
    }

}
