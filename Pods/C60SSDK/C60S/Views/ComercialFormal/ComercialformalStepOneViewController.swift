//
//  ComercialformalStepOneViewController.swift
//  C60S
//
//  Created by Bruno Trindade on 08/02/22.
//

import UIKit

class ComercialformalStepOneViewController: UIViewController, AmountCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productamounts: [AmountModel] = []
    var widthCell = 250
    var heightCell = 70
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
        
        // Do any additional setup after loading the view.
        if let data = SurveyData.shared.getCreditTypeConfigurations().productamounts?.enumerated() {
            for (i, need) in data {
                productamounts.append(AmountModel(id: need.id ?? 0, name: need.name, description: need.description, value: need.value, categoryid: need.categoryid, status: false, index: i))
            }
        }
        
        layout.itemSize = CGSize(width: widthCell, height: heightCell)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 30
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
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        print("Amount ID: \(amountId)")
        self.performSegue(withIdentifier: "paraQueLoNecesitesSegue", sender: nil)
    }
    
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
        collectionView.reloadData()
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

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: heightCell)
    }
}
