//
//  C60SSDK_START.swift
//  C60S
//
//  Created by Felipe Mendoza on 22/02/22.
//

import Foundation
import UIKit
import Alamofire
public protocol DataEnteredDelegate: AnyObject {
    
    func userDidEnterInformation(response: [Any])
}

public class C60SSDK_START: UIViewController {
    var start:Bool? = true
    public var delegate: DataEnteredDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    public func finish(_ vc: UIViewController){
        
        self.ALV(vc)
    }
    
    
    
    public func ALV (_ vc: UIViewController) {
        
        let navCtrl = UINavigationController(rootViewController: vc)
        
        guard
            let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
            let rootViewController = window.rootViewController
                
        else {
            return
        }
        
        navCtrl.view.frame = rootViewController.view.frame
        navCtrl.view.layoutIfNeeded()
        //self.delegate = navCtrl.self as! DataEnteredDelegate
        print("call delegate::::::::")
        delegate?.userDidEnterInformation(response: [true,"success !"])
        window.rootViewController = navCtrl
//        UIView.transition(with: window, duration: 0.3, options: .transitionCurlDown, animations: {
//                        window.rootViewController = navCtrl
//        }){ finished in
//
//
//
//        }
    }
    
    public func getHistory(sessionId:String ,completion: @escaping (String?) -> ()){
        var responseHistory:String = ""
        let params = ["sessionid":sessionId]
        SCSRequests().ListingsBySession(data: params){
            s,t  in
            print("completion")
            //print(t)
            responseHistory = "\(String(describing: s!))"
             completion(responseHistory)
        }
        
    }
    
    public func SDKstatus()->[Any]{
        return [SurveyData.shared.getIsComplete(),SurveyData.shared.errorDescription]
    }
    
    public func start(sessionID: String, _ vc: UIViewController){
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let documentsDirectory = paths[0]
            return documentsDirectory
        }
        let dir = getDocumentsDirectory()
        //let baseURL = "http://10.135.1.100:8077/v1/"
        let baseURL = "https://mp.securecreditsystems.com/v1/"
        let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
        let locale = SCSRequests().getLocale()
       // let path = "Config"
        let path = "Config/044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5/\(locale)"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                do {
                    let resJSON = JSON(response.value)
                    let jsonData = try JSONEncoder().encode(resJSON)
                    let jsonString = String(data: jsonData, encoding: .utf8)!
                    if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                        in: .userDomainMask).first {
                        let pathWithFilename = documentDirectory.appendingPathComponent("config.json")
                        do {
                            try jsonString.write(to: pathWithFilename,
                                                 atomically: true,
                                                 encoding: .utf8)
                        } catch {
                        }
                    }
                   } catch {
                       print("JSONSerialization error:", error)
                   }
            case .failure(let error):
                print(error)
            }
        })
        SurveyData.shared.setOriginViewController(originVC: vc)
        SurveyData.shared.ssetErrorDescription(error: "SDK inicializado pero sin finalizar")
        if(start!){
            print("entramos al llamado del sdk")
            let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
                if let identifier = aBundle.bundleIdentifier {
                    return identifier.contains("org.cocoapods.C60SSDK")
                } else {
                    return false
                }
            }
            if !matches.isEmpty {
                print("encontramos el bundle del sdk")
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "SurveyFlow", bundle: matches.last!)
                let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "CreditTypeTableIdentifier") as! CreditTypeTableViewController
                balanceViewController.sessionID = sessionID
                vc.present(balanceViewController, animated: true)
                //self.performSegue(withIdentifier: "seguestart", sender: nil)
                //return balanceViewController
            }else{
                print("no encontramos el bundle del sdk")
                let storyBoard: UIStoryboard = UIStoryboard(name: "SurveyFlow", bundle: nil)
                let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "CreditTypeTableIdentifier") as! CreditTypeTableViewController
                balanceViewController.sessionID = sessionID
                vc.present(balanceViewController, animated: true)
                //return balanceViewController
            }
        }else{
            
        }
        
        
    }
    
}
