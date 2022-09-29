//
//  FinishComercioFlow.swift
//  C60S
//
//  Created by Felipe Mendoza on 25/04/22.
//

import Foundation
import UIKit


class FinishFlowComercio: BaseViewController,  UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var SALIR: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var HeaderTableView: UITableView!
    override func viewDidLoad() {
        
        print("entre a finish flow")
        
        self.SALIR.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")

        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
        
        // header
        //self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        SCSRequests().setTracker(id: 17, orgid: 1, typeid: 17){
            s in print("RESPUESTA EN TRACKER PANTALLA 17 ####### \(s)")
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
    
    @IBAction func outPressed(_ sender: UIButton) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "auth") as! AuthenticationViewController
        self.present(balanceViewController, animated: true)
    }
    
    
}
