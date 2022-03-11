//
//  IncomeTypesSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 07/01/22.
//

import UIKit

class IncomeTypesSurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MonthlyIncomeDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var incomeTypes: [MonthlyIncomeModel] = []
    var incomeId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
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
    }
    

    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
        tableView.reloadData()
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
       // let id = self.incomeTypes[self.incomeTypesPicker.selectedRow(inComponent: 0)].id
        //print("IncomeType id: \(id)")
        SurveyData.shared.setIncomeTypeSurvey(incomeId: incomeId)
        self.performSegue(withIdentifier: "popUpSCSSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomeTypes.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = incomeTypes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyIncomeCell") as! MonthlyIncomeTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell
    }
}
