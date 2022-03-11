//
//  CreditTypeCell.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import UIKit

protocol CreditTypeDelegate: AnyObject {
    func selectRequestType(model: CreditTypeModel)
}


class CreditTypeCell: UITableViewCell {
    
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
        
        card.layer.cornerRadius = 20
        //card.layer.borderWidth = 0.5
        card.layer.borderColor = UIColor.black.cgColor
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOffset = CGSize(width: 2, height: 2)
        card.layer.shadowOpacity = 0.3
        card.layer.shadowRadius = 5.0
        icon.image = UIImage(named: model.icon ?? "")
        mainLabel.text = model.mainLabel
        subLabel.text = model.subLabel
    }

    
    @IBAction func requestPressed(_ sender: UIButton) {
        delegate?.selectRequestType(model: self.model!)
    }
    

}
