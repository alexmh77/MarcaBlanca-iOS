//
//  ViewController.swift
//  MarcaBlanca
//
//  Created by Felipe Mendoza on 18/02/22.
//

import UIKit
import C60SSDK
//import RadioGroup
import Material

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    let sessionID:String = "d/fvIRnSFf2gQslGnCVm/pz7u8K5JTkEhja1rnr6rt2wvF0tFj68wuL+Zuy2DrEkSVvAtMilRZdleyVemc5gPL3wKnqiCgBZ0UpLzYyoLSIw09U5KAVmu1RWIapfCl4E"
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(
        C60SSDK_START().SDKstatus()
        )
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "fondo_inicio")!)

        //statusSDKLabel.text = C60SSDK_START().SDKstatus()[1] as! String
        button.layer.cornerRadius = button.frame.height / 2
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.0
        button.tintColor = .white
    }
    
    @IBAction func action(_ sender: Any) {
        
        C60SSDK_START().start(sessionID: sessionID,self)
        
    }
    
    
    @IBAction func historyAction(_ sender: Any) {
        
        C60SSDK_START().getHistory(sessionId: sessionID){
            s in print(s!)
        }
        
    }
    
}

