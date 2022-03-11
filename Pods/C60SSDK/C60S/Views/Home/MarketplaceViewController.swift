//
//  MarketplaceViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//
import UIKit
import Amplify
import AmplifyPlugins

protocol dismissScreenDelegate: AnyObject{
    func backToBeforeScreen()
}

var kIgnoringConstant = 100
class MarketplaceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MarketplaceCellDelegate {
    func cardPressed(model: Listing?) {
        
    }
    
    
    
    
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var isExpanded:Bool = false
    var bankData:Listing?
    var listBank:String = ""
    var indexSelected: Int = kIgnoringConstant
    var delegate: dismissScreenDelegate?
    var testData = ["https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Banco-Azteca.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Konfio.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Credijusto.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Credifiel.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Credicapital.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Fincomun.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Klar.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Te-creemos.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Alphacredit.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Bancodelbienestar.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Bancoppel.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/BX.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Came.png",
                    "https://cred-60s-configs.s3.us-west-2.amazonaws.com/bankLogos/Casa-Ley.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = true
        tableView.reloadData()
        
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.delegate?.backToBeforeScreen()
        self.dismiss(animated: true)
    }
    
    
    func cardPressed(model: MarketplaceModel?) {
        // Validate if user is registered:
        //self.loanSegue()
        
    }
    
    func expandedPressed(idPressed: Int, listBank: String) {
        
        if isExpanded {
            indexSelected = kIgnoringConstant
            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
            isExpanded = false
            
        }else{
            indexSelected = idPressed
            print("id: \(idPressed)")
            if indexSelected != kIgnoringConstant {
                //indexSelected = kIgnoringConstant
                UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
                isExpanded = true
                
                SurveyData.shared.setListingBank(name: listBank)
                SurveyData.shared.setListingId(listingId: indexSelected)
            }
        }
    }
    
    @IBAction func expandedPressed(_ sender: Any) {
        //        if indexSelected != kIgnoringConstant {
        //            indexSelected = kIgnoringConstant
        //            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        //        }
        
    }
    
    
    @IBAction func choicePressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loanSegue", sender: nil)
        }
    }
    
    func loanSegue() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "loanSegue", sender: nil)
        }
    }
    
    
    func registrationSegue() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "registerUserSegue", sender: nil)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let all:[All] = bankData!.all
        let top3:[All] = bankData!.top3
        return all.count + top3.count//testData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let all:[All] = bankData!.all
        let top3:[All] = bankData!.top3
        
        let allall = top3 + all
        
        let id = allall[indexPath.item].id
        if(id == indexSelected){
            return 350
        }else{
            return 100
        }
        //return isExpanded ? 300 : 100
        //        return isExpanded ? 300 : 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if(indexSelected == kIgnoringConstant){
//            indexSelected = indexPath.item
//            let all: [All] = bankData!.all
//            SurveyData.shared.setListingId(listingId: all[indexSelected].id!)
//        }else{
//            indexSelected = kIgnoringConstant
//
//        }
//        UIView.transition(with: tableView, duration: 0.5, options: indexSelected == kIgnoringConstant ? .transitionCrossDissolve : .curveEaseOut, animations: {self.tableView.reloadData()}, completion: nil)
//
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let all:[All] = bankData!.all
        let top3:[All] = bankData!.top3
        
        let allall = top3 + all
        let model = allall[indexPath.row].lenderCompanyicon
        let id = allall[indexPath.row].id
        let listBank = allall[indexPath.row].lenderName
        let cell = tableView.dequeueReusableCell(withIdentifier: "marketplaceCell") as! MarketplaceTableViewCell
        cell.setModel(urlBankIcon: model!,id: id!,isExapanded: (id == indexSelected) ? true : false, listBank: listBank!)
        cell.delegate = self
        
        return cell
    }
}


extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
