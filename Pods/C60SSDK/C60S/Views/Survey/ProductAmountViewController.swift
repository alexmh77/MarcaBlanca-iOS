//
//  ProductAmountViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 28/12/21.
//

import UIKit

class ProductAmountViewController: UIViewController, AmountCellDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var continueButton: UIButton!
    
    var productamounts: [AmountModel] = []
    var widthCell = 250
    var heightCell = 70
    let layout = UICollectionViewFlowLayout()
    var amountId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
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
    
    
    @IBAction func continuePressed(_ sender: UIButton) {
        SurveyData.shared.setNeedsConfiguration(productamounts: amountId)
        print("Amount ID: \(amountId)")
        self.performSegue(withIdentifier: "needsSurveySegue", sender: nil)
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

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: heightCell)
    }
}
