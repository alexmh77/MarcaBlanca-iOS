//
//  OTPViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 25/11/21.
//

import UIKit
import Amplify
import Material
import ProgressHUD

class OTPViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var otpCode: TextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backButton.setTitle("", for: .normal)
    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmPressed(_ sender: UIButton) {
        confirmSignIn()
    }
    
    
    func confirmSignIn() {
        Amplify.Auth.confirmSignIn(challengeResponse: otpCode.text!) { result in
            switch result {
            case .success(let signInResult):
                print("Confirm sign in succeeded. Next step: \(signInResult.nextStep)")
                DispatchQueue.main.sync {
                    self.performSegue(withIdentifier: "homeSegue", sender: nil)
                }
            case .failure(let error):
                print("Confirm sign in failed \(error)")
                DispatchQueue.main.sync {
                    ProgressHUD.showError("Error en inicio de sesion")
                }
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
