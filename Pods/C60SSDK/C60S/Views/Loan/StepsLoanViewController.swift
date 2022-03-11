//
//  StepsLoanViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit
import Material

class StepsLoanViewController: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var identityView: UIView!
    @IBOutlet weak var identityRadioButton: RadioButton!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsRadioButton: RadioButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountRadioButton: RadioButton!
    @IBOutlet weak var titlePresentationLabel: UILabel!
    
    var kycStatus: Bool = false // TODO: Dynamic for each user
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        titlePresentationLabel.text = "Hola \(SurveyData.shared.getName()), en  \(SurveyData.shared.getListBank()) queremos conocerte"
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        identityRadioButton.setTitle("", for: .normal)
        setShadowInView(view: identityView)
        setShadowInView(view: termsView)
        setShadowInView(view: accountView)
        
        termsRadioButton.setTitle("", for: .normal)
        accountRadioButton.setTitle("", for: .normal)
        if kycStatus ?? false {
            identityView.isHidden = false
        } else {
            identityView.isHidden = true
        }
    }
    
    
    func setShadowInView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5.0
        view.layer.borderWidth = 0.0
    }
    

    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        if kycStatus ?? false {
            self.performSegue(withIdentifier: "kycSegue", sender: nil)
        } else {
            self.performSegue(withIdentifier: "termsandconditionswithoutKYC", sender: nil)
        }
        
    }
}
