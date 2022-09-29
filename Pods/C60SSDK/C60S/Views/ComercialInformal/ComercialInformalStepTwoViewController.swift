//
//  ComercialInformalStepTwoViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 02/02/22.
//

import UIKit

class ComercialInformalStepTwoViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, NeedsCellDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    var productPurposes: [NeedsModel] = []
    var needsId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("3")
        print(SurveyData.shared.productamounts)
        
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        SCSRequests().setTracker(id: 30, orgid: 1, typeid: 30){
            s in print("RESPUESTA EN TRACKER PANTALLA 31 ####### \(s)")
        }
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productpurposes?.enumerated() {
            for (i, need) in data {
                productPurposes.append(NeedsModel(id: need.id ?? 0, name: need.name, icon: need.icon ?? "", description: need.description, categoryid: need.categoryid ?? 0, status: false, index: i))
            }
        }
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        dismissButton.setTitle("", for: .normal)
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        tableView.backgroundColor = UIColor.clear
        //tableView.backgroundColor = UIColor.yellow
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
       /* print("Needs ID: \(needsId)")
        
        print("1")
        print(SurveyData.shared.needs)
        
        SurveyData.shared.setNeedsSurvey(needs: needsId)
        
        print("2")
        print(SurveyData.shared.needs)
        
        self.performSegue(withIdentifier: "aHoraIngressaSegue", sender: nil)*/
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
        //tableView.reloadData()
        
        print("Needs ID: \(needsId)")
         
         print("1")
         print(SurveyData.shared.needs)
         
         SurveyData.shared.setNeedsSurvey(needs: needsId)
         
         print("2")
         print(SurveyData.shared.needs)
         
         self.performSegue(withIdentifier: "aHoraIngressaSegue", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        if tableView == self.tableView {
            count = productPurposes.count
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
            let model = productPurposes[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "needsCell") as! NeedsTableViewCell
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
