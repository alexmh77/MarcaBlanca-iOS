//
//  KYCInitViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit


class KYCInitViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        self.dismissButton.setTitle("", for: .normal)
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
