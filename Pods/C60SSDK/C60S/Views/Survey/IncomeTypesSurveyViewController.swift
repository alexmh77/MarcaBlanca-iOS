//
//  IncomeTypesSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 07/01/22.
//

import UIKit

class IncomeTypesSurveyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MonthlyIncomeDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var TitleBig: UILabel!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    var incomeTypes: [MonthlyIncomeModel] = []
    var incomeId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        print("😊")
        print(SurveyData.shared.supportId)
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().incometypes?.enumerated() {
            for (i, need) in data {
                incomeTypes.append(MonthlyIncomeModel(id: need.id ?? 0, name: need.name, description: need.description, value: need.value, categoryid: need.categoryid, status: false, index: i))
            }
        }
        dismissButton.setTitle("", for: .normal)
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        self.continueButton.isEnabled = false
        
        // header
        //self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        
        self.TitleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        SCSRequests().setTracker(id: 6, orgid: 1, typeid: 6){
            s in print("RESPUESTA EN TRACKER PANTALLA 6 ####### \(s)")
        }
    }
    

    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func monthlyPressed(model: MonthlyIncomeModel) {
        self.continueButton.isEnabled = true
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        incomeId = model.id
        
        if let data = SurveyData.shared.getCreditTypeConfigurations().incometypes {
            for (i, _) in data.enumerated() {
                if i == model.index {
                    incomeTypes[i].status = true
                } else {
                    incomeTypes[i].status = false
                }
            }
        }
        
        // Deactivate all cards except other and save in singleton
        //tableView.reloadData()
        
         print("1")
         print(SurveyData.shared.incomeId)
         
         SurveyData.shared.setIncomeTypeSurvey(incomeId: incomeId)
         
         print("2")
         print(SurveyData.shared.incomeId)
         self.performSegue(withIdentifier: "popUpSCSSegue", sender: nil)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
       // let id = self.incomeTypes[self.incomeTypesPicker.selectedRow(inComponent: 0)].id
        //print("IncomeType id: \(id)")
       /* print("1")
        print(SurveyData.shared.incomeId)
        
        SurveyData.shared.setIncomeTypeSurvey(incomeId: incomeId)
        
        print("2")
        print(SurveyData.shared.incomeId)
        self.performSegue(withIdentifier: "popUpSCSSegue", sender: nil)*/
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //print("entre contador tabla")
        var count:Int?
        
        if tableView == self.tableView {
            count =  incomeTypes.count
        }else if tableView == HeaderTableView{
            count = 1
        }
        return  count!
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView{
            let model = incomeTypes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyIncomeCell") as! MonthlyIncomeTableViewCell
            cell.setModel(model: model)
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
