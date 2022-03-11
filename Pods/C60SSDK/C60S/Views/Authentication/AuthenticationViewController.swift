//
//  AuthenticationViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Amplify
import AmplifyPlugins

class AuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Force crash
        //let numbers = [0]
        //let _ = numbers[1]
        
        //fetchCurrentAuthSession()
        //self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
        UIApplication
        .shared
        .connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    }
    
    
    func fetchCurrentAuthSession() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
                case .success(let session):
                    print("Is user signed in - \(session.isSignedIn)")
                
                    if (session.isSignedIn) {
                        SCSRequests().saveLogin()
                        print("Home")
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "homeSegue", sender: nil)
                        }
                    } else {
                        DispatchQueue.main.sync {
                            self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
                        }
                    }
                case .failure(let error):
                    print("Fetch session failed with error \(error)")
                    self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
            }
        }
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
