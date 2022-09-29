//
//  CustomSelfieInstructionsViewController.swift
//  FADModuleManagerPod_Example
//
//  Created by Juan Carlos Pérez on 4/9/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
#if canImport(FADModuleSelfiePod)
import FADModuleSelfiePod
#endif

class CustomSelfieInstructionsViewController: UIViewController {
    
 @IBOutlet var btnContinue : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
#if canImport(FADModuleSelfiePod)
extension CustomSelfieInstructionsViewController : SelfieInstructionsDataSource{
    
    func getContinueButton() -> UIButton {
        return self.btnContinue
    }
    
}
#endif
