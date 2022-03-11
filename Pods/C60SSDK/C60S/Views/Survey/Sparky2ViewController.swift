//
//  Sparky2ViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//

import UIKit
import ProgressHUD

class Sparky2ViewController: UIViewController {

    let scsRequests = SCSRequests()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        ProgressHUD.show()
        let data = SurveyData.shared.getListingSearchData()
        print("Data: ", data)
        scsRequests.getListingSearch(data: data, completion: { response in
            print("Listing search: ", response)
            DispatchQueue.main.async() {
                // your code here
                ProgressHUD.dismiss()
                self.performSegue(withIdentifier: "marketplaceSegue", sender: nil)
            }
        })

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
