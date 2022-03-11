//
//  PopUpSignatureViewController.swift
//  C60S
//
//  Created by Felipe Mendoza on 21/02/22.
//

import UIKit
import SwiftSignatureView

class PopUpSignatureViewController: UIViewController {

    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var noAccept: UIButton!
    @IBOutlet weak var accept: UIButton!
    
    @IBOutlet weak var signatureView: SwiftSignatureView!
    let visualAssets = VisualAssets()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        popUp.layer.cornerRadius = 30
        popUp.layer.borderColor = UIColor.black.cgColor
        popUp.layer.shadowColor = UIColor.black.cgColor
        popUp.layer.shadowOffset = CGSize(width: 2, height: 2)
        popUp.layer.shadowOpacity = 0.3
        popUp.layer.shadowRadius = 5.0
        popUp.layer.borderWidth = 0.0
        
        noAccept.titleLabel?.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)!
        accept.titleLabel?.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)!
        
        noAccept.titleLabel!.adjustsFontSizeToFitWidth = true
        noAccept.titleLabel!.minimumScaleFactor = 0.2
        noAccept.titleLabel!.numberOfLines = 0
        
        accept.titleLabel!.adjustsFontSizeToFitWidth = true
        accept.titleLabel!.minimumScaleFactor = 0.2
        accept.titleLabel!.numberOfLines = 0
        
        
        // TODO: Evaluate permissions from user
    }
    
    
    @IBAction func noAcceptPressed(_ sender: UIButton) {
        //self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "seguesignature", sender: nil)
    }
    
    
    @IBAction func acceptPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "seguesignature", sender: signatureView.signature)
        //self.dismiss(animated: true, completion: nil)
        //prepare(for: , sender: )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue")
        if segue.identifier == "seguesignature" {
            if let destinationVC = segue.destination as? TermsAndConditionsViewController {
                destinationVC.signatureImage = sender as? UIImage
            }
        }
    }
}
