//
//  WelcomeViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 17/01/22.
//

import UIKit

class WelcomeViewController: BaseViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var startSurveyButton: UIButton!
   // @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var HeaderImg: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let visualAssets = VisualAssets()
    
    
    /*let yourAttributes: [NSAttributedString.Key: Any] = [
          .underlineStyle: NSUnderlineStyle.single.rawValue
    ]*/
   // super.viewDidLoad()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        SCSRequests().setTracker(id: 18, orgid: 1, typeid: 18){
            s in print("RESPUESTA EN TRACKER PANTALLA 18 ####### \(s)")
        }
        self.loginButton.buttonStyle(bgcolor: "", textcolor: "clearButtonTextColor", bordercolor: "clearButtonBorderColor")
        
        self.startSurveyButton.buttonStyle(bgcolor: "lightButtonBackgroundColor", textcolor: "lightButtonTextColor", bordercolor: "lightButtonBackgroundColor")
        
        self.img1.downloaded(asset: "splashImage", bgcolor: "", contentMode: .scaleToFill)
        /*self.img4.downloaded(asset: "splashImage1", bgcolor: "", contentMode: .scaleAspectFill)
        self.img2.downloaded(asset: "splashImage2", bgcolor: "", contentMode: .scaleAspectFill)
        self.img3.downloaded(asset: "splashImage3", bgcolor: "", contentMode: .scaleAspectFill)*/
        self.HeaderImg.downloaded(asset: "headerImage", bgcolor: "", contentMode: .scaleAspectFit)
        // Do any additional setup after loading the view.
       /* _ = NSMutableAttributedString(
            string: self.loginButton.titleLabel?.text ?? "hola"
         )*/
        //loginButton.titleLabel?.font = UIFont(name: visualAssets.fontLabel, size: visualAssets.fontSize)
        //loginButton.setAttributedTitle(attributeString, for: .normal)
        self.versionLabel.text = GlobalConstants.version
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
