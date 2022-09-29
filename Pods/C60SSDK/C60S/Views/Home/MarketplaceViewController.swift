//
//  MarketplaceViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 08/01/22.
//
import UIKit
//import Amplify
//import AmplifyPlugins

protocol dismissScreenDelegate: AnyObject{
    func backToBeforeScreen()
}

var kIgnoringConstant = 100
class MarketplaceViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MarketplaceCellDelegate {
    func cardPressed(model: Listing?) {
        
    }
    
    
    var counter = 0
    var timer = Timer()
    var isUtm:Bool = false
    var utmUrl:String = ""
    var kycStatus:Bool = false
    
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var TitleBig: UILabel!
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
        self.TitleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        // header
        //self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        
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
            print("finish expanded#######")
            timer.invalidate()
            SCSRequests().setListingView(listingId: indexSelected, duration: counter, productId: "1"){
                s in
                print("RESPUESTA LISTING VIEW ######## \(s) ")
            }
            isExpanded = false
            if indexSelected != idPressed{
                initAction(idPressed:idPressed)
            }else{
                indexSelected = kIgnoringConstant
                timer.invalidate()
            }
            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        }else{
            initAction(idPressed:idPressed)
        }
    }
    
    func initAction(idPressed:Int){
        print("init expanded#######")
        timer.invalidate() // just in case this button is tapped multiple times
        self.counter = 0
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        
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
    // called every time interval from the timer
    @objc func timerAction() {
            counter += 1
            
        }
    
    @IBAction func expandedPressed(_ sender: Any) {
        //        if indexSelected != kIgnoringConstant {
        //            indexSelected = kIgnoringConstant
        //            UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.tableView.reloadData()}, completion: nil)
        //        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "utm" {
                if let destinationVC = segue.destination as? UTMViewController {
                    destinationVC.url = utmUrl
                }
            }
        
            if segue.identifier == "loanSegue" {
                if let destinationVC = segue.destination as? StepsLoanViewController {
                    destinationVC.kycStatus = kycStatus
                }
            }
    }
    
    @IBAction func choicePressed(_ sender: Any) {
       
        
        Task {
            // Delay the task by 1 second:
            try await Task.sleep(nanoseconds: 1_000_000_000)
            print("survey name ::: \(SurveyData.shared.getName())")
            if (SurveyData.shared.getName() == ""){
                loanSegue()
                //registrationSegue()
            } else{
                if isUtm {
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "utm", sender: sender)
                            }
                }else{
                    loanSegue()
                }
                
            }
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
        var count:Int?
        if tableView == self.tableView {
            let all:[All] = bankData!.all
            let top3:[All] = bankData!.top3
            count =  all.count + top3.count//testData.count
        }else if tableView == HeaderTableView{
            count = 1
        }
        return  count!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let all:[All] = bankData!.all
        let top3:[All] = bankData!.top3
        
        let allall = top3 + all
        
        let id = allall[indexPath.item].id
        
        if(id == indexSelected){
                        /*print("item grande")
                        print("utm: \(allall[indexPath.item].utmFlag) :::: utmUrl \(allall[indexPath.item].utmUrl)" )
                        isUtm = allall[indexPath.item].utmFlag ?? false
                        utmUrl = allall[indexPath.item].utmUrl ?? ""*/
                        print("my url ::\(utmUrl)")
            
            if allall[indexPath.item].leadconfigid != nil {
                DispatchQueue.main.async {
                    SCSRequests().setLeadDelivery(leadConfigId: allall[indexPath.item].leadconfigid!){
                        s in
                                            
                        print("RESPUESTA leadDelivery ######## \(s?.url) ")
                        if s?.url != "string" {

                        self.isUtm = true
                            self.utmUrl = (s?.url)!
                        }
                    
                    }
                }

            }
            
                        
                    
                        kycStatus = allall[indexPath.item].lenderKycflag ?? false
            return 330
        }else{
            return 130
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
        if tableView == self.tableView{
            let all:[All] = bankData!.all
            let top3:[All] = bankData!.top3
            
            let allall = top3 + all
            print("indexPath")
            print(indexPath)
            let model = allall[indexPath.row].lenderCompanyicon
            let id = allall[indexPath.row].id
            let listBank = allall[indexPath.row].lenderName
            let interest = allall[indexPath.row].productInterestrate ?? "0.0"
            let cell = tableView.dequeueReusableCell(withIdentifier: "marketplaceCell") as! MarketplaceTableViewCell

            cell.setModel(urlBankIcon: model!,id: id!,isExapanded: (id == indexSelected) ? true : false, listBank: listBank!, interest: Double(interest) ?? 0.0)
            cell.delegate = self
            
            return cell
        }else if tableView == HeaderTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
            /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
            return cell
        }
        return UITableViewCell()
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



