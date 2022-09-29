//
//  CustomInstructions.swift
//  SDKExample (iOS)
//
//  Created by iacosta on 13/04/21.
//

import UIKit
#if canImport(FADModuleIdPod)
import FADModuleIdPod
#endif

class CustomInstructionsView: UIViewController {
    
    @IBOutlet weak var btnContinue: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
#if canImport(FADModuleIdPod)
extension CustomInstructionsView: IdInstructionsDataSource{
    
    func getContinueButton() -> UIButton {
        return self.btnContinue
    }
    
}
#endif

