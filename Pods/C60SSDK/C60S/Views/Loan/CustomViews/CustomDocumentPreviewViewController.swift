//
//  CustomDocumentPreviewViewController.swift
//  FADModuleManagerPod_Example
//
//  Created by Juan Carlos Pérez on 5/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
#if canImport(FADModuleOtherDocumentsPod)
import FADModuleOtherDocumentsPod
#endif

class CustomDocumentPreviewViewController: UIViewController {
    
    @IBOutlet var btnContinue : UIButton!
    @IBOutlet var btnTakeAgain : UIButton!
    @IBOutlet var imvPreview : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
#if canImport(FADModuleOtherDocumentsPod)
extension CustomDocumentPreviewViewController : DocumentsPrevieDataSource{
    
    func getTakeOtherButton() -> UIButton? {
        return nil
    }
    
    func getTakeAgainButton() -> UIButton {
        return self.btnTakeAgain
    }
    
    func getContinueButton() -> UIButton {
        return self.btnContinue
    }
    
    func getPreviewImageView() -> UIImageView {
        return self.imvPreview
    }
}
#endif
