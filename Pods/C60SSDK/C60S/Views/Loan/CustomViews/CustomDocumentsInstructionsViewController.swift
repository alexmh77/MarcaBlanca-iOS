//
//  CustomDocumentsInstructionsViewController.swift
//  FADModuleManagerPod_Example
//
//  Created by Juan Carlos Pérez on 5/3/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
#if canImport(FADModuleOtherDocumentsPod)
import FADModuleOtherDocumentsPod
#endif

class CustomDocumentsInstructionsViewController: UIViewController {

    @IBOutlet var btnContinue : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func sendMessage(_ sender :UIButton){
        let alertView = UIAlertController(title: "¡Aviso!", message: "Mensage custom ALV.", preferredStyle: .alert);
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        present(alertView, animated: true, completion: nil)
    }
    
}
#if canImport(FADModuleOtherDocumentsPod)
extension CustomDocumentsInstructionsViewController : DocumentsInstructionsDataSource{
    func getContinueButton() -> UIButton {
        return self.btnContinue
    }

}
#endif
