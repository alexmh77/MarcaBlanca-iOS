//
//  NeedsSurveyViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import UIKit

class NeedsSurveyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, NeedsCellDelegate {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
 
    @IBOutlet weak var titleBig: UILabel!
    
    @IBOutlet weak var HeaderTableView: UITableView!
    
   
    @IBOutlet weak var backgroud: UIImageView!
    
    //@IBOutlet weak var needTitle: UILabel!
    
    
    var productPurposes: [NeedsModel] = []
    var needsId: Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        print("3")
        print(SurveyData.shared.productamounts)

        self.titleBig.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        //UIApplication.shared.statusBarView?.backgroundColor = .red
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productpurposes?.enumerated() {
            for (i, need) in data {
                print("este es mi need")
                print(need)
                print(need.icon as Any)
                productPurposes.append(NeedsModel(id: need.id ?? 0, name: need.name, icon: need.icon ?? "", description: need.description, categoryid: need.categoryid ?? 0, status: false, index: i))
            }
        }
         
        self.backgroud.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        //self.needTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")

        
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
    
        dismissButton.setTitle("", for: .normal)
        
        continueButton.setTitle(NSLocalizedString("Continuar", comment: "Texto de continuar"), for: .normal)
        continueButton.frame = CGRect(x: self.view.bounds.width/2,
                                      y: self.view.bounds.height,
                                      width: 100,
                                      height: 54)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
       /* tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 226.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0).isActive = true
        tableView.backgroundColor = UIColor.clear
        /*
        tableView.frame = CGRect(x: 0, y: 0, width: 180, height: 400)
        tableView.backgroundColor = UIColor.yellow
        */*/
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        SCSRequests().setTracker(id: 3, orgid: 1, typeid: 3){
            s in print("RESPUESTA EN TRACKER PANTALLA 3 ####### \(s)")
        }
    }
    

    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // TODO: WRITE in singleton element
        
      /*  print("1")
        print(SurveyData.shared.needs)
        print("Needs ID: \(needsId)")
        SurveyData.shared.setNeedsSurvey(needs: needsId)
        
        print("2")
        print(SurveyData.shared.needs)
        self.performSegue(withIdentifier: "workSurveySegue", sender: nil)
       */
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
        print("1")
         print(SurveyData.shared.needs)
         print("Needs ID: \(needsId)")
         SurveyData.shared.setNeedsSurvey(needs: needsId)
         
         print("2")
         print(SurveyData.shared.needs)
         self.performSegue(withIdentifier: "workSurveySegue", sender: nil)
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
