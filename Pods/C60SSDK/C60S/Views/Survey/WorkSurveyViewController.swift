//
//  WorkSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 05/01/22.
//

import UIKit

class WorkSurveyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, WorkSurveyCellDelegate {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var titleBig: UILabel!
    //@IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: UITableView!
    var workNeeds: [WorkSurveyModel] = []
    var workId: Int = 0
    
    override func viewDidLoad() {
        
        print("3")
         print(SurveyData.shared.needs)
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        self.titleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        // header
        //self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //self.img1.downloaded(asset: "360image")
        
        //header

        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        for (i, need) in SurveyData.shared.getCreditTypeConfigurations().employmenttypes.enumerated() {
            workNeeds.append(WorkSurveyModel(id: need.id ?? 0, name: need.name, icon: need.icon ?? "", categoryid: need.categoryid ?? 0, description: need.description, status: false, index: i))
        }
        
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        SCSRequests().setTracker(id: 4, orgid: 1, typeid: 4){
            s in print("RESPUESTA EN TRACKER PANTALLA 4 ####### \(s)")
        }
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
       /* print("Work Survey ID: \(workId)")
        print("1")
        print(SurveyData.shared.workId)
        SurveyData.shared.setWorkSurvey(workId: workId)
        print("2")
        print(SurveyData.shared.workId)
        self.performSegue(withIdentifier: "supportSurveySegue", sender: nil)*/
    }
    
    
    func radioPressed(model: WorkSurveyModel) {
        print("Model work pressed: \(String(describing: model.id))")
        self.continueButton.isEnabled = true
        workId = model.id ?? 0
        for (i, _) in SurveyData.shared.getCreditTypeConfigurations().employmenttypes.enumerated() {
            if i == model.index {
                workNeeds[i].status = true
            } else {
                workNeeds[i].status = false
            }
        }
        
        // Deactivate all cards except other and save in singleton
        //tableView.reloadData()
        print("Work Survey ID: \(workId)")
         print("1")
         print(SurveyData.shared.workId)
         SurveyData.shared.setWorkSurvey(workId: workId)
         print("2")
         print(SurveyData.shared.workId)
         self.performSegue(withIdentifier: "supportSurveySegue", sender: nil)
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        if tableView == self.tableView {
            count =   workNeeds.count
        }else if tableView == HeaderTableView {
            count = 1
        }
       return count!
        //return workNeeds.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == self.tableView {
            let model = workNeeds[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "workSurveyCell") as! WorkSurveyTableViewCell
            cell.setModel(model: model)
            cell.delegate = self
            
            return cell
        }else if tableView == self.HeaderTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
            /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
            return cell
        }
        return UITableViewCell()
        /*
        let model = workNeeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "workSurveyCell") as! WorkSurveyTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell*/
    }
}
