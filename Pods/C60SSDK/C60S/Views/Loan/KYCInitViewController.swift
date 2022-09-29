//
//  KYCInitViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit


class KYCInitViewController: BaseViewController {

    @IBOutlet weak var dismissButton: UIButton!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Continuar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
                
        self.Continuar.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        self.dismissButton.setTitle("", for: .normal)
        SCSRequests().setTracker(id: 11, orgid: 1, typeid: 11){
            s in print("RESPUESTA EN TRACKER PANTALLA 11 ####### \(s)")
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("Appeared!!!")
        let kycStatus = SurveyData.shared.getKYCStatus()
        if kycStatus {
            self.performSegue(withIdentifier: "kycConfirmationSegue", sender: nil)
        }
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "startKYCProcessSegue", sender: nil)
    }
}
