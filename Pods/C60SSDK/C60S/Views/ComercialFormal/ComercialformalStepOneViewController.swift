//
//  ComercialformalStepOneViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit

class ComercialformalStepOneViewController: BaseViewController,  UITableViewDelegate, UITableViewDataSource, AmountCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var subTitle: UILabel!
    var productamounts: [AmountModel] = []
    var widthCell = 185
    var heightCell = 100
    let layout = UICollectionViewFlowLayout()
    var amountId = 0
    
    // MARK: - Variables
    let values = ["$ 100","$ 200","$ 300","$ 400"]
    
    // MARK: - Outlet
    @IBOutlet weak var backFormalUIButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    // MARK: - Live Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SCSRequests().setTracker(id: 25, orgid: 1, typeid: 25){
            s in print("RESPUESTA EN TRACKER PANTALLA 25 ####### \(s)")
        }
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
        
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        self.subTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        self.continueButton.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")

        // header
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.layer.cornerRadius = 30.0
        self.HeaderTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productamounts?.enumerated() {
            for (i, need) in data {
                productamounts.append(AmountModel(id: need.id ?? 0, name: need.name, description: need.description, value: need.value, categoryid: need.categoryid, status: false, index: i))
            }
        }
        
        //layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.layer.cornerRadius = 30.0
        collectionView.collectionViewLayout = layout
        collectionView.register(AmountCollectionViewCell.nib(), forCellWithReuseIdentifier: "AmountCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        continueButton.isEnabled = false
        
    }
    
    // MARK: - Action
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continuePressed(_ sender: UIButton) {
        // TODO: WRITE in singleton element
        
       /* print("1")
        print(SurveyData.shared.productamounts)
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        print("2")
        print(SurveyData.shared.productamounts)
        print("Amount ID: \(amountId)")
        self.performSegue(withIdentifier: "paraQueLoNecesitesSegue", sender: nil)*/
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
    
    // MARK: - Private Method
    func amountSelected(model: AmountModel) {
        self.continueButton.isEnabled = true
        amountId = model.id
        for (i, _) in productamounts.enumerated() {
            if i == model.index {
                productamounts[i].status = true
            } else {
                productamounts[i].status = false
            }
        }
        
        // Deactivate all cards except other and save in singleton
        //collectionView.reloadData()
        print("1")
        print(SurveyData.shared.productamounts)
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        print("2")
        print(SurveyData.shared.productamounts)
        print("Amount ID: \(amountId)")
        collectionView.reloadData()
        self.performSegue(withIdentifier: "paraQueLoNecesitesSegue", sender: nil)
    }
    
    // MARK: - Connection
    

}


extension ComercialformalStepOneViewController: UICollectionViewDelegate {
    
}


extension ComercialformalStepOneViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productamounts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = productamounts[indexPath.row]
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AmountCollectionViewCell", for: indexPath) as! AmountCollectionViewCell
        cell.setModel(model: model)
        cell.delegate = self
        return cell
    }
    
    
}


extension ComercialformalStepOneViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        
        let totalSpace = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let totalSpace2 = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(3))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        print("Ancho_F")
        print(size)
        
        let alto = Int((collectionView.bounds.height / 4) + totalSpace2)
        print("Alto_F")
        print(collectionView.bounds.height)
        print(alto)
        
        return CGSize(width: size, height: alto)
    }
}
