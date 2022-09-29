//
//  ComercialformalStepFourViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit

class ComercialformalStepFourViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MonthlyIncomeDelegate  {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var TitleBig: UILabel!
    var incomeTypes: [MonthlyIncomeModel] = []
    var incomeId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SCSRequests().setTracker(id: 28, orgid: 1, typeid: 28){
            s in print("RESPUESTA EN TRACKER PANTALLA 28 ####### \(s)")
        }
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        self.TitleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        //header
        
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
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
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // TODO: WRITE in singleton element
        /*
        print("1")
        print(SurveyData.shared.incomeId)
        
        SurveyData.shared.setIncomeTypeSurvey(incomeId: incomeId)
        print("incomeId: \(incomeId)")
        
        print("2")
        print(SurveyData.shared.incomeId)
        
        let viewController:UIViewController = UIStoryboard(name: "SurveyFlow", bundle: nil).instantiateViewController(withIdentifier: "registeridentifier") as UIViewController
        self.present(viewController, animated: true, completion: nil)*/
        
        
    }
    
    func monthlyPressed(model: MonthlyIncomeModel) {
        self.continueButton.isEnabled = true
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
        print("incomeId: \(incomeId)")
        
        print("2")
        print(SurveyData.shared.incomeId)
//        
//        let viewController:UIViewController = UIStoryboard(name: "SurveyFlow", bundle: nil).instantiateViewController(withIdentifier: "registeridentifier") as UIViewController
//        self.present(viewController, animated: true, completion: nil)
//        
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            if let identifier = aBundle.bundleIdentifier {
                return identifier.contains("org.cocoapods.C60SSDK")
            } else {
                return false
            }
        }
        if !matches.isEmpty {
            print("encontramos el bundle del sdk")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "SurveyFlow", bundle: matches.last!)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "registeridentifier") as! UIViewController
            self.present(balanceViewController, animated: true)
            //self.performSegue(withIdentifier: "seguestart", sender: nil)
            //return balanceViewController
        }else{
            print("no encontramos el bundle del sdk")
            let storyBoard: UIStoryboard = UIStoryboard(name: "SurveyFlow", bundle: nil)
            let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "registeridentifier") as! UIViewController
            self.present(balanceViewController, animated: true)
            //return balanceViewController
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return incomeTypes.count
         var count:Int?
         if tableView == self.tableView {
             count = incomeTypes.count
         }else if tableView == HeaderTableView {
             //print("entre contador header")
             count = 1
         }
         return count!
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
        let model = incomeTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyIncomeCell") as! MonthlyIncomeTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell
        }else if tableView == self.HeaderTableView {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
                    return cell
        }
                return UITableViewCell()
    }

}
