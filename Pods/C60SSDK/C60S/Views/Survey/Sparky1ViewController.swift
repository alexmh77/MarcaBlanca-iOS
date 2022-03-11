//
//  Sparky1ViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import UIKit
import SCSSDKiOS
import ProgressHUD

class Sparky1ViewController: UIViewController,dismissScreenDelegate {
    func backToBeforeScreen() {
        print("estoy en delegate")
        self.dismiss(animated: true)
    }
    
    
    let scsRequests = SCSRequests()
    @IBOutlet weak var progressCustom: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        progressCustom.startAnimating()
        //ProgressHUD.show()
        // Do any additional setup after loading the view.
        
        if #available(iOS 15.0, *) {
            Task {
                do {
                    print("Loading score ref...")
                    let scsSDK = try await SCSSDKiOS.scoreRefOnly(scsapikey: SCSRequests().apiKey, scsurl: "")
                    SurveyData.shared.setReferenceNumber(referenceNumber: scsSDK)
                    print(scsSDK)
                    print("Finished!")
                    
                    let data = SurveyData.shared.getListingSearchData()
                    print("Data: ", data)
                    scsRequests.getListingSearch(data: data, completion: { response in
                        print("Listing search: ", response as Any)
                        if(response != nil){
                            let bankList: Listing = response!
                            DispatchQueue.main.async() {
                                // your code here
                                self.progressCustom.stopAnimating()
                                //ProgressHUD.dismiss()
                                self.performSegue(withIdentifier: "marketplaceSegue", sender: bankList)
                            }
                        }else{
                            ProgressHUD.showError("No se pudo obtener información")
                        }
                        
                    })
                } catch {
                    print(error)
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
        //loadSCSSDK()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare banks")
       if (segue.identifier == "marketplaceSegue") {
          let marketplacevc = segue.destination as! MarketplaceViewController
           marketplacevc.bankData = sender as? Listing
           marketplacevc.delegate = self
       }
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
