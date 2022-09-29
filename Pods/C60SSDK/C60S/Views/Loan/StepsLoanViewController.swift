//
//  StepsLoanViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 09/01/22.
//

import UIKit
import Material

class StepsLoanViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var identityView: UIView!
    @IBOutlet weak var identityRadioButton: RadioButton!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var termsRadioButton: RadioButton!
    @IBOutlet weak var accountView: UIView!
    @IBOutlet weak var accountRadioButton: RadioButton!
    @IBOutlet weak var titlePresentationLabel: UILabel!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var Continuar: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    
    var kycStatus: Bool = false // TODO: Dynamic for each user
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let hola = NSLocalizedString("Hola", comment: "Hola")
        let en = NSLocalizedString("en", comment: "en")
        let queremos = NSLocalizedString("queremos conocerlo", comment: "conocerlo")
        titlePresentationLabel.text = "\(hola) \(SurveyData.shared.getName()), \(en)  \(SurveyData.shared.getListBank()) \(queremos)"
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Aqui entre al loan view controller")
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        self.Continuar.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        self.titlePresentationLabel.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        self.instructionsLabel.labelStyle(bgcolor: "", textcolor: "bodyTextColor")
        
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        dismissButton.setTitle("", for: .normal)
        identityRadioButton.setTitle("", for: .normal)
        setShadowInView(view: identityView)
        setShadowInView(view: termsView)
        setShadowInView(view: accountView)
        
        termsRadioButton.setTitle("", for: .normal)
        accountRadioButton.setTitle("", for: .normal)
        if kycStatus ?? false {
            identityView.isHidden = false
        } else {
            identityView.isHidden = true
        }
        
        SCSRequests().setTracker(id: 10, orgid: 1, typeid: 10){
            s in print("RESPUESTA EN TRACKER PANTALLA 10 ####### \(s)")
        }
    }
    
    //func header
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
       // cell.backgroundColor = UIColor.black
        return cell
    }
    
    //func header
    
    
    func setShadowInView(view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 5.0
        view.layer.borderWidth = 0.0
    }
    

    @IBAction func dismissPressed(_ sender: UIButton) {
        print("entro a regresar")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
//        if kycStatus ?? false {
//            self.performSegue(withIdentifier: "kycSegue", sender: nil)
//        } else {
//            self.performSegue(withIdentifier: "termsandconditionswithoutKYC", sender: nil)
//        }
        self.performSegue(withIdentifier: "termsandconditionswithoutKYC", sender: nil)
    }
    
}
