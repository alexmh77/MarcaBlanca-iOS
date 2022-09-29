import UIKit
import Material
import Alamofire

public class CreditTypeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreditTypeDelegate {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var creditTypeTableView: UICollectionView!
    
    @IBOutlet weak var background: UIImageView!
 
    @IBOutlet weak var bigTitle: UILabel!
    @IBOutlet weak var HeaderTableView: UITableView!
    //@IBOutlet weak var HeaderTableView: UITableView!
    
    var data: [SurveyConfig] = []
    let layout = UICollectionViewFlowLayout()
    var heightCell = 118
    var widthCell = 374
    var sessionID:String?
    
    public override var prefersStatusBarHidden: Bool {
        return true
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
                navigationItem.hidesBackButton = true
                navigationController?.setNavigationBarHidden(true, animated: false)
        //background
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor", contentMode: .bottom)
  
        self.bigTitle.labelStyle(bgcolor: "", textcolor: "titleTextColor")
        
        //self.background.position.y += 50.0
       /* self.background.contentMode = UIView.ContentMode.bottomLeft
        self.background2.clipsToBounds = true
        self.background2.contentMode = .bottom
        self.background2.contentMode = UIView.ContentMode.bottomLeft
        self.background2.contentMode = .redraw*/
       
        //background
        // header
        //self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView.layer.cornerRadius = 30.0
        self.HeaderTableView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      //  self.img1.downloaded(asset: "360image")
        
        //header
        
        overrideUserInterfaceStyle = .light
       /* navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)*/
        //splitViewController?.navigationController?.navigationBar.tintColor = UIColor.white

        
        
        if PersistanceData().getConsumerId() == "" {
            SCSRequests().getConsumerEmptyUser(){
                s in
                PersistanceData().saveConsumerId(consumer: "\((s?.id)!)")
                SurveyData.shared.setConsumerId(consumerid: (s?.id)!)
                
                SCSRequests().setFirebaseAndConsumer(consumerid:"\((s?.id)!)"){
                    s in print("RESPUESTA AL GUARDAR TOKEN######## "+s)
                }
                
                
                
            }
        }else{
            SurveyData.shared.setConsumerId(consumerid: Int(PersistanceData().getConsumerId()) ?? 0)
            SCSRequests().setTracker(id: 1, orgid: 1, typeid: 1){
                s in print("RESPUESTA EN TRACKER PANTALLA 1 ####### \(s)")
            }
            print("Consumer exist#####")
        }
        
        
        /*SCSRequests().lookUpOrRegister(sessionID: sessionID ?? "d/fvIRnSFf2gQslGnCVm/pz7u8K5JTkEFY5w7KJ1rSawvF0tFj68wuL+Zuy2DrEkr8I/dqUj27iW0fg4RyMaU+jsqimIAsTVZnJjjYWpymAwyFRXa7rZyk8nz0jL1DWG"){
            s in print("claro360id \(String(describing: s?.id))")
            if(s?.id != nil){
                SurveyData.shared.setConsumerId(consumerid: (s?.id)!)
                SurveyData.shared.setName(customerName: (s?.name)!)
                
            }
            
        }*/
        
        
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
            print("imprimo el data")
            print(self.data)
            self.layout.itemSize = CGSize(width: self.widthCell, height: self.heightCell)
            self.layout.minimumInteritemSpacing = 0
            self.layout.minimumLineSpacing = 20
            self.creditTypeTableView.collectionViewLayout = self.layout
            self.creditTypeTableView.register(CreditTypeCollectionViewCell.nib(), forCellWithReuseIdentifier: "CreditTypeCollectionViewCell")
            self.creditTypeTableView.delegate = self
            self.creditTypeTableView.dataSource = self
            self.creditTypeTableView.reloadData()
        }
        
        dismissButton.setTitle("", for: .normal)
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
    
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        SurveyData.shared.ssetErrorDescription(error: "SDK Cancelado")
        self.dismiss(animated: true)
    }
    
    
     func selectRequestType(model: CreditTypeModel) {
        SurveyData.shared.setCreditTypeIndex(index: model.id)
        
         if model.id == 1 || model.id == 4 { // Personal
            self.performSegue(withIdentifier: "amountSegue", sender: nil)
         } else if model.id == 2 || model.id == 5 {
            
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
        print("este es dotopoint")
        print(dataPoint)
        
        let dataModel = CreditTypeModel(id: dataPoint.id, icon: dataPoint.icon ?? "", mainLabel: dataPoint.name, subLabel: dataPoint.description ?? "", buttonLabel: NSLocalizedString("Solicitar", comment: "solicitar"))
        let cell = self.creditTypeTableView.dequeueReusableCell(withReuseIdentifier: "CreditTypeCollectionViewCell", for: indexPath) as! CreditTypeCollectionViewCell

        cell.setModel(model: dataModel)
        cell.delegate = self
        
        return cell
    }
    
    
}


extension CreditTypeTableViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 1
        
        let totalSpace = layout.sectionInset.left
                + layout.sectionInset.right
                + (layout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size, height: heightCell)
    }
}
