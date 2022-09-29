//
//  WorkSurveyTableViewCell.swift
//  C60S
//
//  Created by Oscar Inowe on 05/01/22.
//

import UIKit
import Material


protocol WorkSurveyCellDelegate: AnyObject {
    func radioPressed(model: WorkSurveyModel)
}

class WorkSurveyTableViewCell: UITableViewCell {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var radioButton: RadioButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var model: WorkSurveyModel?
    weak var delegate: WorkSurveyCellDelegate?
    let visualAssets = VisualAssets()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear
        card.viewStyle(bgcolor: "cardBackgroundColor")
        radioButton.isHidden = true
        radioButton.setTitle("", for: .normal)
        radioButton.pulseColor = visualAssets.colorNameLightBlue
        radioButton.shadowColor = UIColor.clear
        radioButton.setTitleShadowColor(UIColor.clear, for: .normal)
        radioButton.setIconColor(visualAssets.colorNameLightBlue, for: .selected)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        card.addGestureRecognizer(tap)
        self.titleLabel.labelStyle(bgcolor: "", textcolor: "cardSubTitleColor")
    }

    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        delegate?.radioPressed(model: self.model!)
    }
    
    
    @IBAction func radioPressed(_ sender: RadioButton) {
        delegate?.radioPressed(model: self.model!)
    }
    
    func setModel(model: WorkSurveyModel) {
        self.model = model
        titleLabel.text = model.name
        //print("icon en setmodel")
        let iconUrl = model.icon as! String
        if iconUrl.isEmpty {
            print("El icono esta vacío o es nulo")
            icon.image = nil;
        }else{
            print(model.icon)
           icon.downloadedString(asset: iconUrl, bgcolor: "bodyBackgroundColor")
        }
        radioButton.setSelected(false, animated: false)
        if model.status {
            card.layer.borderColor = visualAssets.colorNameLightBlue.cgColor
            card.layer.borderWidth = 1.5
            radioButton.setSelected(true, animated: true)
        } else {
            card.layer.cornerRadius = 15
            card.layer.borderColor = UIColor.black.cgColor
            card.layer.shadowColor = UIColor.black.cgColor
            card.layer.shadowOffset = CGSize(width: 2, height: 2)
            card.layer.shadowOpacity = 0.3
            card.layer.shadowRadius = 5.0
            card.layer.borderWidth = 0.0
            //radioButton.setSelected(false, animated: false)
        }
    }

}
