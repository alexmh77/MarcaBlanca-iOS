//
//  CustomHeaderView.swift
//  FADModuleManagerPod_Example
//
//  Created by Juan Carlos Pérez on 4/16/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

//import FADModuleManagerPod

class CustomHeaderView: UIView {
    
    @IBOutlet weak var btnContinue : UIButton!
    @IBOutlet weak var view: UIView!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    class func getScreen() -> CustomHeaderView {
        let xib = Bundle.main.loadNibNamed(String(describing :self), owner: self, options: nil)
        let me = xib![0] as! CustomHeaderView
        return me
    }
    
    
    @IBAction func goBack(_ sender : UIButton){
//        FADModuleManager.goBack()
    }
    
    @IBAction func showMenu(_ sender : UIButton) {
//        let popupConfigSelfieModuleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConfigSelfieModuleViewControllerId") as? ConfigSelfieModuleViewController
//        FADModuleManager.presenteView(popupConfigSelfieModuleViewController!)
    }
}
