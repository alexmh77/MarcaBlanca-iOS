//
//  AuthenticationViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
//import Amplify
//import AmplifyPlugins

import Foundation
import Alamofire


class AuthenticationViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()     
        print("siempre entro aqui al principio")
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
        
        

        SCSRequests().setTracker(id: 19, orgid: 1, typeid: 19){
            s in print("RESPUESTA EN TRACKER PANTALLA 19 ####### \(s)")
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        }

        SurveyData.shared.setOriginViewController(originVC: self)
        // Do any additional setup after loading the view.
        
        // Force crash
        //let numbers = [0]
        //let _ = numbers[1]
        
        //fetchCurrentAuthSession()
        
                             
        //self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        /*UIApplication
        .shared
        .connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }*/
    }
    
    
    func fetchCurrentAuthSession() {
//        _ = Amplify.Auth.fetchAuthSession { result in
//            switch result {
//                case .success(let session):
//                    print("Is user signed in - \(session.isSignedIn)")
//                
//                    if (session.isSignedIn) {
//                        SCSRequests().saveLogin()
//                        print("Home")
//                        DispatchQueue.main.sync {
//                            self.performSegue(withIdentifier: "homeSegue", sender: nil)
//                        }
//                    } else {
//                        
//                        DispatchQueue.main.sync {
//                            //self.performSegue(withIdentifier: "homeSegue", sender: nil)
//                           self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
//                        }
//                    }
//                case .failure(let error):
//                    print("Fetch session failed with error \(error)")
//                    self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
//            }
//        }
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


extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
