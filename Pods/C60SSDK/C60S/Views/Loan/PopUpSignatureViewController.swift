//
//  PopUpSignatureViewController.swift
//  C60S
//
//  Created by Felipe Mendoza on 21/02/22.
//

import UIKit
import SwiftSignatureView

class PopUpSignatureViewController: BaseViewController {

    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var noAccept: UIButton!
    @IBOutlet weak var accept: UIButton!
    
    @IBOutlet weak var buttonContainer: UIStackView!
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
        
        let topBorder = CALayer()
        topBorder.borderColor = UIColor.gray.cgColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRect(x: 0, y: 0, width: 250, height: 1)
        
        let leftBorder = CALayer()
        leftBorder.borderColor = UIColor.gray.cgColor;
        leftBorder.borderWidth = 1;
        leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: 46)
        
        self.buttonContainer.layer.addSublayer(topBorder)
        self.accept.layer.addSublayer(leftBorder)
        
        
        
        noAccept.titleLabel?.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)!
        accept.titleLabel?.font = UIFont(name: visualAssets.font, size: visualAssets.fontSize)!
        
        noAccept.titleLabel!.adjustsFontSizeToFitWidth = true
        noAccept.titleLabel!.minimumScaleFactor = 0.2
        noAccept.titleLabel!.numberOfLines = 0
        
        accept.titleLabel!.adjustsFontSizeToFitWidth = true
        accept.titleLabel!.minimumScaleFactor = 0.2
        accept.titleLabel!.numberOfLines = 0
        
        SCSRequests().setTracker(id: 15, orgid: 1, typeid: 15){
            s in print("RESPUESTA EN TRACKER PANTALLA 15 ####### \(s)")
        }
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
