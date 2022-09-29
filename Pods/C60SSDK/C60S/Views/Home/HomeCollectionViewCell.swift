//
//  HomeCollectionViewCell.swift
//  C60S
//
//  Created by Felipe Mendoza on 24/04/22.
//

import UIKit
import Material

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cardView: Card!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

}


class customCardRequest: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = bounds.height / 2
        backgroundColor = .white
        layer.borderColor = UIColor.gray.cgColor
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = bounds.height / 2
        layer.borderWidth = 0.2
    }
    
}
