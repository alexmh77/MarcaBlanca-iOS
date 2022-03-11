import UIKit
import Material
import Alamofire

public class CreditTypeTableViewController: UIViewController, CreditTypeDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var creditTypeTableView: UICollectionView!
    
    var data: [SurveyConfig] = []
    let layout = UICollectionViewFlowLayout()
    var heightCell = 257
    var widthCell = 184
    var sessionID:String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        SCSRequests().lookUpOrRegister(sessionID: sessionID ?? "d/fvIRnSFf2gQslGnCVm/pz7u8K5JTkEFY5w7KJ1rSawvF0tFj68wuL+Zuy2DrEkr8I/dqUj27iW0fg4RyMaU+jsqimIAsTVZnJjjYWpymAwyFRXa7rZyk8nz0jL1DWG"){
            s in print("claro360id \(String(describing: s?.id))")
            if(s?.id != nil){
                SurveyData.shared.setConsumerId(consumerid: (s?.id)!)
                SurveyData.shared.setName(customerName: (s?.name)!)
                
            }
            
        }
        
        
        /*SCSRequests().getListingSearch(data: SurveyData.shared.getListingSearchData()){
            s in
            
            let top3:All = (s?.top3[0])!
            
            print("URL :::::::::::::::::")
            print(top3.lenderCompanyicon)
            
            //SurveyData.shared.setCon
            
        }*/
        // Do any additional setup after loading the view.
        
        SurveyData.shared.setConfig {
            self.data = SurveyData.shared.getConfig()
            self.layout.itemSize = CGSize(width: self.widthCell, height: self.heightCell)
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 30
            self.creditTypeTableView.collectionViewLayout = self.layout
            self.creditTypeTableView.register(CreditTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: "CreditTypeCollectionViewCell")
            self.creditTypeTableView.delegate = self
            self.creditTypeTableView.dataSource = self
            self.creditTypeTableView.reloadData()
        }
        
        dismissButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        SurveyData.shared.ssetErrorDescription(error: "SDK Cancelado")
        self.dismiss(animated: true)
    }
    
    
     func selectRequestType(model: CreditTypeModel) {
        SurveyData.shared.setCreditTypeIndex(index: model.id)
        
        if model.id == 1 { // Personal
            self.performSegue(withIdentifier: "amountSegue", sender: nil)
        } else if model.id == 2 {
            
            let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
                if let identifier = aBundle.bundleIdentifier {
                    return identifier.contains("org.cocoapods.C60SSDK")
                } else {
                    return false
                }
            }
            if !matches.isEmpty {
                print("encontramos el bundle del sdk")
                
                let viewController:UIViewController = UIStoryboard(name: "ComercialFlow", bundle: matches.last!).instantiateViewController(withIdentifier: "ComercialFlow") as UIViewController
                self.present(viewController, animated: true, completion: nil)
                
            }else{
                print("no encontramos el bundle del sdk")
                let viewController:UIViewController = UIStoryboard(name: "ComercialFlow", bundle: nil).instantiateViewController(withIdentifier: "ComercialFlow") as UIViewController
                self.present(viewController, animated: true, completion: nil)
               
            }
            
            

        } else {

            let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
                if let identifier = aBundle.bundleIdentifier {
                    return identifier.contains("org.cocoapods.C60SSDK")
                } else {
                    return false
                }
            }
            if !matches.isEmpty {
                let viewController:UIViewController = UIStoryboard(name: "ComercialFormalFlow", bundle: matches.last!).instantiateViewController(withIdentifier: "ComercialFormalFlow") as UIViewController
                self.present(viewController, animated: true, completion: nil)
            }else{
                let viewController:UIViewController = UIStoryboard(name: "ComercialFormalFlow", bundle: nil).instantiateViewController(withIdentifier: "ComercialFormalFlow") as UIViewController
                self.present(viewController, animated: true, completion: nil)
                //return balanceViewController
            }
            
        }
        
    }
}


extension CreditTypeTableViewController: UICollectionViewDelegate {
    
}


extension CreditTypeTableViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dataPoint = data[indexPath.row]
        
        let dataModel = CreditTypeModel(id: dataPoint.id, icon: dataPoint.name, mainLabel: dataPoint.name, subLabel: dataPoint.description ?? "", buttonLabel: "Solicitar")
        let cell = self.creditTypeTableView.dequeueReusableCell(withReuseIdentifier: "CreditTypeCollectionViewCell", for: indexPath) as! CreditTypeCollectionViewCell

        cell.setModel(model: dataModel)
        cell.delegate = self
        
        return cell
    }
    
    
}


extension CreditTypeTableViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        
        let totalSpace = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: heightCell)
    }
}
