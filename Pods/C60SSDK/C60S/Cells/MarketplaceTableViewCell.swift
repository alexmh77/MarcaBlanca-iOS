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
    
    @IBOutlet weak var amountPreLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
//        card.addGestureRecognizer(tap)
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        //delegate?.cardPressed(model: self.model)
    }

    
    @IBAction func expandPressed(_ sender: UIButton) {
        
//        imageExpanded = imageExpanded?.rotate(radians: .pi)
//        expand.setImage(imageExpanded, for: .normal)
        delegate?.cardPressed(model: self.model)
       
        
        delegate?.expandedPressed(idPressed: card.tag, listBank: bankListLabel.text!)
    }
    
    func setModelData(modelData: Listing){
        self.model = modelData
    }
    
    // TODO: EXPAND AND SET MODEL
    func setModel(urlBankIcon: String, id: Int, isExapanded: Bool, listBank: String) {
        // self.model = model
        if let urlIcon = URL(string: urlBankIcon) {
            bankIcon.pin_updateWithProgress = true
            bankIcon.pin_setImage(from: urlIcon)
        }
        expand.setTitle("", for: .normal)
        
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
        }
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
    }
    

}
