//
//  WorkSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 05/01/22.
//

import UIKit

class WorkSurveyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, WorkSurveyCellDelegate {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    var workNeeds: [WorkSurveyModel] = []
    var workId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        for (i, need) in SurveyData.shared.getCreditTypeConfigurations().employmenttypes.enumerated() {
            workNeeds.append(WorkSurveyModel(id: need.id ?? 0, name: need.name, categoryid: need.categoryid ?? 0, description: need.description, status: false, index: i))
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
        print("Work Survey ID: \(workId)")
        SurveyData.shared.setWorkSurvey(workId: workId)
        self.performSegue(withIdentifier: "supportSurveySegue", sender: nil)
    }
    
    
    func radioPressed(model: WorkSurveyModel) {
        print("Model work pressed: \(model.id)")
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
        tableView.reloadData()
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workNeeds.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = workNeeds[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "workSurveyCell") as! WorkSurveyTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell
    }
}
