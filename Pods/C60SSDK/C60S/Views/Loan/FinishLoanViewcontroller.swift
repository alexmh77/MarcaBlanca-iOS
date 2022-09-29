//
//  FinishLoanViewcontroller.swift
//  C60S
//
//  Created by Felipe Mendoza on 24/02/22.
//

import Foundation
import UIKit

class FinishLoanViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var icon: UIImageView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
                
        self.finishButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        self.thanksLabel.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        self.icon.downloaded(asset: "loanGraciasImage", bgcolor: "", contentMode: .scaleAspectFit)
        
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        overrideUserInterfaceStyle = .light
        let thanx = NSLocalizedString("Gracias por confiar en", comment: "confiar en")
        thanksLabel.text = "\(thanx) \(SurveyData.shared.getListBank())"
        SCSRequests().setTracker(id: 16, orgid: 1, typeid: 16){
            s in print("RESPUESTA EN TRACKER PANTALLA 16 ####### \(s)")
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        return cell
    }
    
    @IBAction func finishPressed(_ sender: Any) {
        
        print("finishing...")
        //        SurveyData.shared.setIsComplete(complete: true)
        //        SurveyData.shared.ssetErrorDescription(error: "Success")
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "auth") as! AuthenticationViewController
        //        self.present(balanceViewController, animated: true)
                SurveyData.shared.setIsComplete(complete: true)
                SurveyData.shared.ssetErrorDescription(error: "Success")
                C60SSDK_START().finish(SurveyData.shared.getOriginViewController())
        
    }
}
