//
//  FinishLoanViewcontroller.swift
//  C60S
//
//  Created by Felipe Mendoza on 24/02/22.
//

import Foundation
import UIKit

class FinishLoanViewController: UIViewController{
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        thanksLabel.text = "Gracias por confiar en \(SurveyData.shared.getListBank())"
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        print("finishing...")
        SurveyData.shared.setIsComplete(complete: true)
        SurveyData.shared.ssetErrorDescription(error: "Success")
        C60SSDK_START().finish(SurveyData.shared.getOriginViewController())
    }
}
