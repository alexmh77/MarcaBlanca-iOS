//
//  HeaderTableViewCell.swift
//  C60S
//
//  Created by Daniel Garnier on 25/05/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageCell: UIImageView!
    
    

    override func awakeFromNib() {
        //super.awakeFromNib()
        // Initialization code
        self.imageCell.downloaded(asset: "bannerImage", bgcolor: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       // super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
