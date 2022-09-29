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
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var subLabel2: UILabel!
    @IBOutlet weak var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.clear
        self.button.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        self.mainLabel.labelStyle(bgcolor: "tabBackgroundColor", textcolor: "tabTextColor")
        
        self.subLabel2.labelStyle(bgcolor: "", textcolor: "cardTitleColor")
        
        self.card.viewStyle(bgcolor: "cardBackgroundColor")

    }
    
    
    func setModel(model: CreditTypeModel) {
        self.model = model
        //C60SSDK_START().start(sessionID: "")
        card.layer.cornerRadius = 20
        mainLabel.layer.cornerRadius = 10
        mainLabel.layer.masksToBounds = true
        subLabel2.numberOfLines = 1
        subLabel2.adjustsFontSizeToFitWidth = true
        subLabel2.font.withSize(30)        
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
       /* if !matches.isEmpty {
            print(matches.last!)
            
            icon.image = UIImage(named: model.icon ?? "", in: matches.last!, with: nil)
        } else {
            icon.image = UIImage(named: model.icon ?? "")
        }*/

        let iconUrl = model.icon as! String

        self.icon.downloadedString(asset: iconUrl, bgcolor: "bodyBackgroundColor")
        
        
       /* let image2 = URL(string: iconUrl)  as! URL
        self.contentMode = .scaleAspectFit
        URLSession.shared.dataTask(with: image2) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }

            DispatchQueue.main.async() { [weak self] in
                self!.icon.image = image
            }
        }.resume()*/
        
        //split string get amount
        let myString: String = model.subLabel;
        let myStringArr = myString.components(separatedBy: "$")
        let myStringPrice = "$" + myStringArr[1]
        
        mainLabel.text = model.mainLabel
        subLabel.text = myStringArr[0]
        subLabel2.text = myStringPrice
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
