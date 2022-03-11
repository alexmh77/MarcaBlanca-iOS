//
//  HomeViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Amplify

class HomeViewController: UIViewController {
    
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        // Do any additional setup after loading the view.
        settingsButton.setTitle("", for: .normal)
    }
    

    @IBAction func settingsPressed(_ sender: UIButton) {
        signOutLocally()
    }
    
    
    func signOutLocally() {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
                DispatchQueue.main.sync {
                    self.performSegue(withIdentifier: "welcomeSegue", sender: nil)
                }
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
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
    

}
