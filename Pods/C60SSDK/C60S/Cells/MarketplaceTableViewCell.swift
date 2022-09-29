//
//  MarketplaceTableViewCell.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import UIKit
import PINRemoteImage


protocol MarketplaceCellDelegate: AnyObject {
    func cardPressed(model: Listing?)
    func expandedPressed(idPressed: Int, listBank: String)
}

class MarketplaceTableViewCell: UITableViewCell {

    @IBOutlet weak var bankIcon: UIImageView!
    @IBOutlet weak var expand: UIButton!
    @IBOutlet weak var card: UIView!
    var imageExpanded = UIImage(named: "expand_more")
    var model: Listing?
    var delegate: MarketplaceCellDelegate?
    
    @IBOutlet weak var bankListLabel: UILabel!
    
    @IBOutlet weak var buttonChoice: UIButton!
    @IBOutlet weak var amountLabelText: UILabel!
    @IBOutlet weak var amountPreLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabelText: UILabel!
    @IBOutlet weak var interestLabelText: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    
    @IBOutlet weak var tasaLabelText: UILabel!
    @IBOutlet weak var tasaLabel: UILabel!
    
    @IBOutlet weak var tasaLabelUp: UILabel!
    @IBOutlet weak var tasaLabelTextUp: UILabel!
    
    @IBOutlet weak var totalLabelUp: UILabel!
    @IBOutlet weak var totalLabelTextUp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear
        bankListLabel.numberOfLines = 1
        bankListLabel.adjustsFontSizeToFitWidth = true
        self.totalAmountLabel.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        self.amountPreLabel.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        
        self.tasaLabelText.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        self.tasaLabelTextUp.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        self.totalLabelTextUp.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        
        self.interestLabel.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        self.bankListLabel.labelStyle(bgcolor: "", textcolor: "cardSubTitleColor")
        self.totalAmountLabelText.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.interestLabelText.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        self.tasaLabel.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.tasaLabelUp.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.totalLabelUp.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        
        self.amountLabelText.labelStyle(bgcolor: "", textcolor: "inputLabelColor")
        self.buttonChoice.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        card.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        
        //delegate?.cardPressed(model: self.model)
    }

    
    @IBAction func expandPressed(_ sender: UIButton) {
        print("expand")
//        imageExpanded = imageExpanded?.rotate(radians: .pi)
//        expand.setImage(imageExpanded, for: .normal)
        delegate?.cardPressed(model: self.model)
       
        
        delegate?.expandedPressed(idPressed: card.tag, listBank: bankListLabel.text!)
    }
    
    func setModelData(modelData: Listing){
        self.model = modelData
    }
    
    // TODO: EXPAND AND SET MODEL
    func setModel(urlBankIcon: String, id: Int, isExapanded: Bool, listBank: String, interest: Double) {
        
        print("isExpanded")
        print(isExapanded)
        
        // self.model = model
        if let urlIcon = URL(string: urlBankIcon) {
            bankIcon.pin_updateWithProgress = true
            bankIcon.pin_setImage(from: urlIcon)
        }
        expand.setTitle("", for: .normal)
        
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                
                //print("en if de matches")
               // print(identifier)
                
               return identifier.contains("org.cocoapods.C60SSDK")
                //return identifier.contains("com.prosperas.marketplace")
            } else {
                print("emn else de matvches")
                return false
            }
        }
        
        print("matches")
        print(matches)
        
        
        if !matches.isEmpty {
            print(matches.last!)
            
            
            imageExpanded = isExapanded ? imageExpanded?.rotate(radians: .pi) : imageExpanded
            
            
            if(isExapanded){
                expand.setImage(UIImage(named: "expand_more", in: matches.last!, with: nil)!.rotate(radians: .pi), for: .normal)
            }else{
                expand.setImage(UIImage(named: "expand_more", in: matches.last!, with: nil), for: .normal)
            }
            
           
        } else {
            if(isExapanded){
                expand.setImage(UIImage(named: "expand_more")!.rotate(radians: .pi), for: .normal)
            }else{
                expand.setImage(UIImage(named: "expand_more"), for: .normal)
            }
        }
        
        //expand.setImage(UIImage(named: "expand_more")!.withRenderingMode(.alwaysTemplate), for: .normal)
        bankListLabel.text = listBank
        expand.tintColor = UIColor.gray
        card.layer.cornerRadius = 10
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 2, height: 2)
        card.layer.shadowOpacity = 0.3
        card.layer.shadowRadius = 5.0
        card.layer.borderWidth = 0.0
        card.tag = id
        
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current

        // We'll force unwrap with the !, if you've got defined data you may need more error checking

        print("surveydata.shared")
        print(SurveyData.shared)
        print("totalamount")
        print(SurveyData.shared.getTotalAmount())
        
        self.amountPreLabel.text = currencyFormatter.string(from: NSNumber(value: SurveyData.shared.getTotalAmount()))!
    
        let percent = calculatePercentage(value: Double(SurveyData.shared.getTotalAmount()), percentageVal: interest)
        
        self.interestLabel.text = currencyFormatter.string(from: NSNumber(value: percent))!
        
        self.totalAmountLabel.text = currencyFormatter.string(from: NSNumber(value: percent + Double(SurveyData.shared.getTotalAmount())))!
        
        self.totalLabelTextUp.text = currencyFormatter.string(from: NSNumber(value: percent + Double(SurveyData.shared.getTotalAmount())))!
        
        self.tasaLabelText.text = String(interest) + "%"
        self.tasaLabelTextUp.text = String(interest) + "%"
    }
    
    public func calculatePercentage(value:Double,percentageVal:Double)->Double{
        let val = value * percentageVal
        return val / 100.0
    }

}
