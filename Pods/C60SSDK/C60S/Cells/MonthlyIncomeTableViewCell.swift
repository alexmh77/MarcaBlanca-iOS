//
//  MonthlyIncomeTableViewCell.swift
//  C60S
//
//  Created by Oscar Inowe on 18/01/22.
//

import UIKit

protocol MonthlyIncomeDelegate: AnyObject {
    func monthlyPressed(model: MonthlyIncomeModel)
}

class MonthlyIncomeTableViewCell: UITableViewCell {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: MonthlyIncomeModel?
    weak var delegate: MonthlyIncomeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        card.addGestureRecognizer(tap)
    }

    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.monthlyPressed(model: model!)
    }

    
    func setModel(model: MonthlyIncomeModel) {
        self.model = model
        titleLabel.text = model.description
        card.layer.borderColor = VisualAssets().colorNameLightBlue.cgColor
        if model.status {
            card.layer.borderColor = VisualAssets().colorNameLightBlue.cgColor
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.backgroundColor = VisualAssets().colorNameLightBlue.cgColor
            self.titleLabel.textColor = .white
        } else {
            card.layer.cornerRadius = 30
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOffset = CGSize(width: 2, height: 2)
            card.layer.shadowOpacity = 0.3
            card.layer.shadowRadius = 5.0
            card.layer.borderWidth = 1.5
        }
    }
}
