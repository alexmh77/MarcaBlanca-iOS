//
//  ComercialformalStepTwoViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit

class ComercialformalStepTwoViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, NeedsCellDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var bigTitle: UILabel!
    
    var productPurposes: [NeedsModel] = []
    var needsId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("3")
        print(SurveyData.shared.productamounts)
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        SCSRequests().setTracker(id: 26, orgid: 26, typeid: 26){
            s in print("RESPUESTA EN TRACKER PANTALLA 26 ####### \(s)")
        }
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productpurposes?.enumerated() {
            for (i, need) in data {
                print("este es mi need")
                print(need)
                print(need.icon as Any)
                productPurposes.append(NeedsModel(id: need.id ?? 0, name: need.name, icon: need.icon ?? "", description: need.description, categoryid: need.categoryid ?? 0, status: false, index: i))
            }
        }
        
        dismissButton.setTitle("", for: .normal)
        
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        

        
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
        /*print("Needs ID: \(needsId)")
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
            print("table view")
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
