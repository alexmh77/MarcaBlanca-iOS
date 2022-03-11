//
//  SupportSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 07/01/22.
//

import UIKit
import Material

class SupportSurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SupportSurveyCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var supportNeeds: [SupportSurveyModel] = []
    var supportId: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        // Do any additional setup after loading the view.
        for (i, need) in SurveyData.shared.getCreditTypeConfigurations().supporttypes.enumerated() {
            supportNeeds.append(SupportSurveyModel(id: need.id ?? 0, name: need.name, categoryid: need.categoryid ?? 0, description: need.description, status: false, index: i))
        }
        
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    

    @IBAction func continuePressed(_ sender: UIButton) {
        for value in supportNeeds {
            if value.status {
                self.supportId.append(value.id ?? 0)
            }
        }
        print("Support array: \(self.supportId)")
        SurveyData.shared.setSupportSurvey(supportId: self.supportId)
        
        self.performSegue(withIdentifier: "incomeSurveySegue", sender: nil)
    }
    
    
    func radioPressed(model: SupportSurveyModel) {
        
        print("Index: \(model.index)")
        supportNeeds[model.index ?? 0].status = model.status
        
        for value in supportNeeds {
            if value.status {
                self.continueButton.isEnabled = true
                break
            } else {
                self.continueButton.isEnabled = false
            }
        }
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supportNeeds.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = supportNeeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "supportViewCell") as! SupportSurveyTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell
    }
}
