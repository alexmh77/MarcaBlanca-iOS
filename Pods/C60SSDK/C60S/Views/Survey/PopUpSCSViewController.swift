//
//  PopUpSCSViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import UIKit

class PopUpSCSViewController: UIViewController {

    @IBOutlet weak var popUp: UIView!
    @IBOutlet weak var noAccept: UIButton!
    @IBOutlet weak var accept: UIButton!
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var botonContainer: UIStackView!
    
    let visualAssets = VisualAssets()
    
    override func viewDidLoad() {
        
        print("entre a la venta de pop up ")
        
        super.viewDidLoad()
        
        print("3")
        print(SurveyData.shared.incomeId)
        
        let topBorder = CALayer()
        topBorder.borderColor = UIColor.lightGray.cgColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRect(x: 0, y: 0, width: 284, height: 1)
        
        let leftBorder = CALayer()
        leftBorder.borderColor = UIColor.lightGray.cgColor;
        leftBorder.borderWidth = 1;
        leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: self.accept.frame.height)
        
        self.botonContainer.layer.addSublayer(topBorder)
        self.accept.layer.addSublayer(leftBorder)
        
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
        
        accept.setAttributedTitle(NSAttributedString(AttributedString(NSLocalizedString("Continuar", comment: "Texto de continuar"))), for: .normal)
        noAccept.setAttributedTitle(NSAttributedString(AttributedString(NSLocalizedString("Rechazar", comment: "Texto de rechazar"))), for: .normal)
        
        noAccept.titleLabel!.adjustsFontSizeToFitWidth = true
        noAccept.titleLabel!.minimumScaleFactor = 0.2
        noAccept.titleLabel!.numberOfLines = 0
        
        accept.titleLabel!.adjustsFontSizeToFitWidth = true
        accept.titleLabel!.minimumScaleFactor = 0.2
        accept.titleLabel!.numberOfLines = 0
        
        instructions.adjustsFontSizeToFitWidth = true
        instructions.minimumScaleFactor = 0.2
        instructions.numberOfLines = 0
        
        self.instructions.labelStyle(bgcolor: "", textcolor: "bodyTextColor")
        
        // TODO: Evaluate permissions from user
        
        SCSRequests().setTracker(id: 7, orgid: 1, typeid: 7){
            s in print("RESPUESTA EN TRACKER PANTALLA 7 ####### \(s)")
        }
    }
    
    
    @IBAction func noAcceptPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func acceptPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "sparkySegue1", sender: nil)
    }
}
