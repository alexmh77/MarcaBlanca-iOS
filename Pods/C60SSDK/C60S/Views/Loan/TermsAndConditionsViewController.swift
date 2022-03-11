//
//  TermsAndConditionsViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit
import SwiftUI
import ProgressHUD

class TermsAndConditionsViewController: UIViewController {
    
    @IBOutlet weak var termsTextView: UITextView!
    @IBOutlet weak var sendToEmail: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    var signatureImage : UIImage?
    @IBOutlet weak var signatureButton: UIButton!
    let scsRequests = SCSRequests()
    @IBOutlet var viewSignature: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        print("viewDidLoadTerms")
        if signatureImage != nil {
            SurveyData.shared.setSignatureData(sigatureDataValue: convertImageToBase64String(img: signatureImage!))
            
            print("pintando....")
            let imageToShow = UIImageView(image: signatureImage)
            //imageToShow.center = viewSignature.center
            //viewSignature.frame = imageToShow.frame
            imageToShow.contentMode = .scaleAspectFit
            viewSignature.addSubview(imageToShow) //= UIImageView(image: signatureImage)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        scsRequests.getTermsAndConditions(id: "1") { data in
            self.termsTextView.text = data?.description
        }
        // Do any additional setup after loading the view.
        self.dismissButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        if signatureImage != nil {
            
            SCSRequests().sigSave(data: SurveyData.shared.getSigSaveRequestData()){
                s in print(s?.signatureuri as Any)
                SurveyData.shared.productid = (s?.productid)!
                print(self.convertImageToBase64String(img: self.signatureImage!))
                self.performSegue(withIdentifier: "accountSettingSegue", sender: nil)
            }
            
        }else{
            ProgressHUD.showError("Es necesario firma antes de continuar ")
        }
        
        
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }
    
    
    @IBAction func signaturePressed(_ sender: UIButton) {
        
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
        }
        if !matches.isEmpty {
            print(matches.last!)
            
            let popOverVC = UIStoryboard(name: "LoanRequest", bundle: matches.last!).instantiateViewController(withIdentifier: "popidentifier") as! PopUpSignatureViewController
            self.addChild(popOverVC)
            
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
        } else {
            let popOverVC = UIStoryboard(name: "LoanRequest", bundle: nil).instantiateViewController(withIdentifier: "popidentifier") as! PopUpSignatureViewController
            self.addChild(popOverVC)
            
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
        }
        
        
        
        
        
    }
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
