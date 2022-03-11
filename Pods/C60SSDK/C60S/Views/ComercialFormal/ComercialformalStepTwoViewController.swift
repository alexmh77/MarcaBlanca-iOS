//
//  ComercialformalStepTwoViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit

class ComercialformalStepTwoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NeedsCellDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    var productPurposes: [NeedsModel] = []
    var needsId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productpurposes?.enumerated() {
            for (i, need) in data {
                productPurposes.append(NeedsModel(id: need.id ?? 0, name: need.name, description: need.description, categoryid: need.categoryid ?? 0, status: false, index: i))
            }
        }
        
        dismissButton.setTitle("", for: .normal)
        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // TODO: WRITE in singleton element
        print("Needs ID: \(needsId)")
        SurveyData.shared.setNeedsSurvey(needs: needsId)
        self.performSegue(withIdentifier: "aHoraIngressaSegue", sender: nil)
    }
    func radioPressed(model: NeedsModel) {
        print("Model needs pressed: \(model.id)")
        self.continueButton.isEnabled = true
        needsId = model.id
        if let data = SurveyData.shared.getCreditTypeConfigurations().productpurposes?.enumerated() {
            for (i, _) in data {
                if i == model.index {
                    productPurposes[i].status = true
                } else {
                    productPurposes[i].status = false
                }
            }
        }
        
        // Deactivate all cards except other and save in singleton
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productPurposes.count
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = productPurposes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "needsCell") as! NeedsTableViewCell
        cell.setModel(model: model)
        cell.delegate = self
        
        return cell
    }

}
