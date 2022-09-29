//
//  RegisterInstructionViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 26/01/22.
//

import UIKit

class RegisterInstructionViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var Registrate: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var HeaderTableView: UITableView!
    
    @IBOutlet weak var logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        // header
        //self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        
        self.logo.downloaded(asset: "bannerImage", bgcolor: "" , contentMode: .scaleAspectFit)
        
        // Do any additional setup after loading the view.
        self.background.downloaded(asset: "screenBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .scaleAspectFill)
        
        self.Registrate.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        SCSRequests().setTracker(id: 14, orgid: 1, typeid: 14){
            s in print("RESPUESTA EN TRACKER PANTALLA 14 ####### \(s)")
        }
    }
    
    //func header
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        /*cell.imageCell.image = UIImage(named: exercisesList[indexPath.row])*/
        return cell
    }
    
    //func header
    
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
