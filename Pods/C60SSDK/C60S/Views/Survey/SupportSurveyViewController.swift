//
//  SupportSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 07/01/22.
//

import UIKit
import Material

class SupportSurveyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, SupportSurveyCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    

    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var supportNeeds: [SupportSurveyModel] = []
    var supportId: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        print("3")
        print(SurveyData.shared.workId)
        
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")

        // Do any additional setup after loading the view.
        for (i, need) in SurveyData.shared.getCreditTypeConfigurations().supporttypes.enumerated() {
            print("este es mi need")
            print(need)
            print(need.icon)
            supportNeeds.append(SupportSurveyModel(id: need.id ?? 0, name: need.name, icon: need.icon ?? "", categoryid: need.categoryid ?? 0, description: need.description, status: false, index: i))
            
            print("este es mi support needs")
            print(supportNeeds)
        }
        
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        // header
        //self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //self.img1.downloaded(asset: "360image")
        
        //header
        
        SCSRequests().setTracker(id: 5, orgid: 1, typeid: 5){
            s in print("RESPUESTA EN TRACKER PANTALLA 5 ####### \(s)")
        }
    }
    

    @IBAction func continuePressed(_ sender: UIButton) {
        for value in supportNeeds {
            if value.status {
                self.supportId.append(value.id ?? 0)
            }
        }
        print("Support array: \(self.supportId)")
        
        print("1")
        print(SurveyData.shared.supportId)
        SurveyData.shared.setSupportSurvey(supportId: self.supportId)
        
        print("2")
        print(SurveyData.shared.supportId)
        
        self.performSegue(withIdentifier: "incomeSurveySegue", sender: nil)
    }
    
    
    func radioPressed(model: SupportSurveyModel) {
        print("Index: \(String(describing: model.index))")
        let index = model.index
        supportNeeds[model.index ?? 0].status = model.status
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        if index == 0 && model.status == true{
            self.continueButton.isEnabled = true
            
            for element in supportNeeds{
                if element.id != model.id{
                    element.status = false
                }
            }
        }else{
            if model.status == true{
                if self.supportNeeds.count > 0{
                    self.supportNeeds[0].status = false
                }
            }
            for value in supportNeeds {
                if value.status {
                    self.continueButton.isEnabled = true
                    break
                } else {
                    self.continueButton.isEnabled = false
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        print("entro a dissmis en recibes")
        self.dismiss(animated: true, completion: nil)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        if tableView == self.tableView {
            count =  supportNeeds.count
        }else if tableView == HeaderTableView {
            count = 1
        }
       return count!
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let model = supportNeeds[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "supportViewCell") as! SupportSurveyTableViewCell
            cell.setModel(model: model)
            cell.delegate = self
            
            return cell
        }else if tableView == self.HeaderTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
            /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
            return cell
        }
        return UITableViewCell()
    }
    
}
