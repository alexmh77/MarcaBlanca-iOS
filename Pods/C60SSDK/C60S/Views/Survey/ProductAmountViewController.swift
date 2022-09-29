//
//  ProductAmountViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import UIKit

class ProductAmountViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, AmountCellDelegate {
    


    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!

    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var HeaderTableView: UITableView!
    
    var productamounts: [AmountModel] = []
    var widthCell = 185
    var heightCell = 100
    let layout = UICollectionViewFlowLayout()
    var amountId = 0
    
    override func viewDidLoad() {
        print("entro a este archivo")
        
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
        
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productamounts?.enumerated() {
            for (i, need) in data {
                productamounts.append(AmountModel(id: need.id ?? 0, name: need.name, description: need.description, value: need.value, categoryid: need.categoryid, status: false, index: i))
            }
        }
       

        //layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        collectionView.register(AmountCollectionViewCell.nib(), forCellWithReuseIdentifier: "AmountCollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.layer.cornerRadius = 30.0
        continueButton.isEnabled = false
        
        SCSRequests().setTracker(id: 2, orgid: 1, typeid: 2){
            s in print("RESPUESTA EN TRACKER PANTALLA 2 ####### \(s)")
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
    
    
    func amountSelected(model: AmountModel) {
        print("soy amountSelect")
        self.continueButton.isEnabled = true
        amountId = model.id
        for (i, _) in productamounts.enumerated() {
            if i == model.index {
                productamounts[i].status = true
            } else {
                productamounts[i].status = false
            }
        }
        
        print("1")
        print(SurveyData.shared.productamounts)
        
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        
        print("2")
        print(SurveyData.shared.productamounts)
        
        
        print("Amount ID: \(amountId)")
        collectionView.reloadData()
        self.performSegue(withIdentifier: "needsSurveySegue", sender: nil)
        
        // Deactivate all cards except other and save in singleton
        
    }
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        
        /*print("1")
        print(SurveyData.shared.productamounts)
        
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        
        print("2")
        print(SurveyData.shared.productamounts)
        
        
        print("Amount ID: \(amountId)")
        self.performSegue(withIdentifier: "needsSurveySegue", sender: nil)*/
         
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}




extension ProductAmountViewController: UICollectionViewDelegate {
    
}


extension ProductAmountViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productamounts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("entro aca 💀")
        let model = productamounts[indexPath.row]
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "AmountCollectionViewCell", for: indexPath) as! AmountCollectionViewCell
        cell.setModel(model: model)
        cell.delegate = self
        return cell
    }

    
    
}


extension ProductAmountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        
        let totalSpace = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let totalSpace2 = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(3))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        let alto = Int((collectionView.bounds.height / 4) + totalSpace2)
        return CGSize(width: size, height: alto)
    }
    

    
    
}

