//
//  CamaraViewController.swift
//  MobileCard-MX-iOS
//
//  Created by Felipe Mendoza on 11/05/22.
//

import UIKit
/*
import FADModuleIdPod
import AcuantiOSSDKV11

class CamaraViewController: UIViewController {
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var camaraView: UIView!
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

}

extension CamaraViewController: AcuantCaptureDataSource{
    
    
    
    
    func setState(state: CameraState) {
        print("STATE#### \(state)")
        
        
    }


    func getBackButton() -> UIButton {
        self.backButton
    }





    func getCameraView() -> UIView {
        self.camaraView
    }

}
*/
