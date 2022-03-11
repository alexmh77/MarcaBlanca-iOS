//
//  WelcomeViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 17/01/22.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var startSurveyButton: UIButton!
    let visualAssets = VisualAssets()
    
    /*let yourAttributes: [NSAttributedString.Key: Any] = [
          .underlineStyle: NSUnderlineStyle.single.rawValue
    ]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        /*let attributeString = NSMutableAttributedString(
            string: self.loginButton.titleLabel?.text ?? "",
            attributes: yourAttributes
         )*/
        //loginButton.titleLabel?.font = UIFont(name: visualAssets.fontLabel, size: visualAssets.fontSize)
        //loginButton.setAttributedTitle(attributeString, for: .normal)
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
