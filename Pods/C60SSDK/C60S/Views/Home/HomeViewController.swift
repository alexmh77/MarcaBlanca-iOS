//
//  HomeViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
//import Amplify

class requestModel{
    
    var image: String?
    var amount: String?
    var status: String?
    
    init(image:String,amount:String,status:String){
        self.image = image
        self.amount = amount
        self.status = status
    }
}

class HomeViewController: BaseViewController,UICollectionViewDataSource, UICollectionViewDelegate,UISearchBarDelegate,UITableViewDataSource {
    
    //@IBOutlet weak var settingsButton: UIButton!
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var HeaderTableView: UITableView!
    @IBOutlet weak var NuevaSolicitud: UIButton!
    @IBOutlet weak var background: UIImageView!
    
    var requestData: [requestModel] = []
    var historyData: [requestModel] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logoCell", for: indexPath) as! HeaderTableViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return requestData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        
        if let urlIcon = URL(string: requestData[indexPath.row].image ?? "") {
            cell.productImage.pin_updateWithProgress = true
            cell.productImage.pin_setImage(from: urlIcon)
        }
        cell.amountLabel.text = "\(requestData[indexPath.row].amount ?? "")"
        cell.statusLabel.text = requestData[indexPath.row].status
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns = 3
        let width = Int(UIScreen.main.bounds.width)
        let side = width / columns
        let rem = width % columns
        let addOne = indexPath.row % columns < rem
        let ceilWidth = addOne ? side + 1 : side
        return CGSize(width: ceilWidth, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(requestData[indexPath.row]) selected")
        //performSegue(withIdentifier: "companyidentifier", sender: nil)
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //get name user
        
        
        SCSRequests().setTracker(id: 20, orgid: 1, typeid: 20){
            s in print("RESPUESTA EN TRACKER PANTALLA 20 ####### \(s)")
        }
        
        
        
        var consumeridforreq = SurveyData.shared.getConsumerId()
        
        print("#### CONSUMER #### \(consumeridforreq)")
        self.nameLabel.text = SurveyData.shared.getName()
        
//            Amplify.Auth.fetchUserAttributes() { result in
//                switch result {
//                case .success(let attributes):
//
//                    print("atrributes##### \(attributes)")
//                    for i in attributes {
//                        print("validando atributos guardados#########")
//
//                        print("KEYS####################### \(i.key)")
//                        if (i.key == AuthUserAttributeKey.custom("consumerId")) {
//                            print("se encontró consumer id en cuenta##############")
//                            print(i)
//                            consumeridforreq = Int(i.value) ?? 0
//                            PersistanceData().saveConsumerId(consumer: i.value)
//                            break
//                        }
//
//                        if (i.key == AuthUserAttributeKey.name) {
//                            print("NAME#####"+i.value)
//
//
//
//                            DispatchQueue.main.async {
//                                SurveyData.shared.setName(customerName: i.value)
//                                self.nameLabel.text = SurveyData.shared.getName()
//                            }
//
//                            break
//                        }
//                    }
//                case .failure(let error):
//                    print("Fetching user attributes failed with error \(error)")
//                }
//            }
        
        
        print("consumerID###### \(consumeridforreq)")
        let params = ["consumerid": Int(PersistanceData().getConsumerId()) ?? consumeridforreq ]
        print("mis params###### \(params)")
        let scr = SCSRequests()
        
        scr.ConsumerByID(data: params){
            s,arg in
            
            print("S########### \(s)")
            
            if s != nil {
                
                for i in (0 ..< s!.count).reversed() {
                    print("MAKE FOR#########")
                    
                    scr.getListingHistory(listingid: "\(s?[i].listingid ?? 0)" ){
                        s2 in
                        
                        
                        scr.getLenderHistory(lenderid: "\(s2?.lenderid ?? 0)"){
                            s3 in
                            print("MAKE APPEND#########")
                            self.requestData.append(requestModel(image: s3?.companyicon ?? "", amount: s3?.name ?? "", status: s?[i].status ?? "Pendiente"))
                            
                            
                            if i == 0 {
                                
                                let layoutMenu: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                                layoutMenu.sectionInset = UIEdgeInsets(top: 0, left: self.screenSize.width * 0.05, bottom: 0, right: self.screenSize.width * 0.05)
                                layoutMenu.itemSize = CGSize(width: self.screenSize.width * 1, height: 75)
                                layoutMenu.scrollDirection = .vertical
                                layoutMenu.collectionView?.backgroundColor = .clear
                                
                                let myCollectionViewMenu:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutMenu)
                                myCollectionViewMenu.dataSource = self
                                myCollectionViewMenu.delegate = self
                                
                                myCollectionViewMenu.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
                                myCollectionViewMenu.backgroundColor = .white
                                myCollectionViewMenu.tag = 2
                                myCollectionViewMenu.backgroundView?.backgroundColor = .clear
                                myCollectionViewMenu.backgroundColor = .clear
                                
                                self.view.addSubview(myCollectionViewMenu)
                                self.setContrains(setView: myCollectionViewMenu, horizontal: 0, vertical: 0, width: self.screenSize.width , height: self.screenSize.height * 0.2)
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    
                }
            }
            
            
            
            
            
            let layoutMenu: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layoutMenu.sectionInset = UIEdgeInsets(top: 10, left: self.screenSize.width * 0.05, bottom: 0, right: self.screenSize.width * 0.05)
            layoutMenu.itemSize = CGSize(width: self.screenSize.width * 1, height: 80)
            layoutMenu.scrollDirection = .vertical
            layoutMenu.collectionView?.backgroundColor = .clear
            
            let myCollectionViewMenu:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layoutMenu)
            myCollectionViewMenu.dataSource = self
            myCollectionViewMenu.delegate = self
            
            myCollectionViewMenu.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "homeCell")
            myCollectionViewMenu.backgroundColor = .white
            myCollectionViewMenu.tag = 2
            myCollectionViewMenu.backgroundView?.backgroundColor = .clear
            myCollectionViewMenu.backgroundColor = .clear
            
            self.view.addSubview(myCollectionViewMenu)
            self.setContrains(setView: myCollectionViewMenu, horizontal: 0, vertical: 100, width: self.screenSize.width , height: self.screenSize.height * 0.32)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.background.downloaded(asset: "bodyBackgroundImage", bgcolor: "bodyBackgroundColor" , contentMode: .bottom)
                
        self.NuevaSolicitud.buttonStyle(bgcolor: "buttonBackgroundColor", textcolor: "buttonTextColor", bordercolor: "buttonBackgroundColor")
        
        // header
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.tableStyle(bgcolor: "headerBackgroundColor")
        self.HeaderTableView?.layer.cornerRadius = 30.0
        self.HeaderTableView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //header
        
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        settingsButton.setTitle("", for: .normal)
        
    }
    
    
    @IBAction func settingsPressed(_ sender: UIButton) {
        print("cerrar sesión")
        signOutLocally()
    }
    
    
    func signOutLocally() {
        SurveyData.shared.setName(customerName: "")
//        Amplify.Auth.signOut() { result in
//            switch result {
//            case .success:
//                print("Successfully signed out")
//                DispatchQueue.main.sync {
//                    self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
//                }
//            case .failure(let error):
//                print("Sign out failed with error \(error)")
//            }
//        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        /*if segue.identifier == "newSurvey" {
         SurveyData.shared.setConfig()
         }*/
    }
    
    func setContrains(setView: UIView,horizontal: Double, vertical: Double, width: Double, height: Double){
        setView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: setView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: CGFloat(horizontal))
        let verticalConstraint = NSLayoutConstraint(item: setView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: CGFloat(vertical))
        let widthConstraint = NSLayoutConstraint(item: setView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(width))
        let heightConstraint = NSLayoutConstraint(item: setView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: CGFloat(height))
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    
}
