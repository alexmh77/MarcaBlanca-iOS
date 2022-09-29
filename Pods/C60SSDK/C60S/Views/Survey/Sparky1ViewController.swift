//
//  Sparky1ViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import UIKit
import SCSSDKiOS
import ProgressHUD

class Sparky1ViewController: BaseViewController,dismissScreenDelegate {
    
    @IBOutlet weak var background: UIImageView!
    
   
    
    func backToBeforeScreen() {
        print("estoy en delegate")
        self.dismiss(animated: true)
    }
    
    
    let scsRequests = SCSRequests()
    @IBOutlet weak var progressCustom: UIActivityIndicatorView!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var dog: UIImageView!
    override func viewDidLoad() {
        
        print("entre a sparky 1")
        
        self.background.downloaded(asset: "screenBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .scaleAspectFill)
        
        self.logo.downloaded(asset: "bannerImage", bgcolor: "" , contentMode: .scaleAspectFit)
        
        self.dog.downloaded(asset: "loadingImage", bgcolor: "" , contentMode: .scaleAspectFit)
        
    
        SCSRequests().setTracker(id: 8, orgid: 1, typeid: 8){
            s in print("RESPUESTA EN TRACKER PANTALLA 8 ####### \(s)")
        }
        
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
                            
                            if (bankList.top3.isEmpty){
                                DispatchQueue.main.async() {
                                    // your code here
                                    self.progressCustom.stopAnimating()
                                    //ProgressHUD.dismiss()
                                    self.performSegue(withIdentifier: "sincreditosegue", sender: nil)
                                }
                                
                            }else{
                                DispatchQueue.main.async() {
                                    // your code here
                                    self.progressCustom.stopAnimating()
                                    //ProgressHUD.dismiss()
                                    self.performSegue(withIdentifier: "marketplaceSegue", sender: bankList)
                                }
                            }
                            
                        }else{
                            //ProgressHUD.showError("No se pudo obtener información")
                            self.performSegue(withIdentifier: "sincreditosegue", sender: nil)
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
