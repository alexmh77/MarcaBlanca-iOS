//
//  KYCViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 13/01/22.
//

import UIKit
//import FADModuleManagerPod
 
class KYCViewController: UIViewController {
    
    var navController : UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navController = self.navigationController

        print("Creating FAD...")
        // Do any additional setup after loading the view.
        /*FADModuleManager.initProccess(navigation: navController, constants: invokeBiometris(), onSuccess: { (processId) in
            print(processId)
            let validationId = FADModuleManager.getValidationId(processId: processId) ?? ""
            //print("esto si se llamo")
            //print("ValidationId: \(validationId)")
            
            SurveyData.shared.setKYCStatus(status: true)
            self.dismiss(animated: true)
        }, onCancel: { (processId) in
            print(processId)
            print("se cancelo")
            SurveyData.shared.setKYCStatus(status: false)
            self.dismiss(animated: true)
        }) { (fail, error) in
            print("dio error \(error)")
            print(fail)
            SurveyData.shared.setKYCStatus(status: false)
            self.dismiss(animated: true)
        }*/
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    /*
    func invokeBiometris() -> FADManagerConstants {
        #if canImport(FADModuleManagerPod)
        //MARK: FAD Bio Configuration
        let constants = FADManagerConstants()
        constants.orientationDelegate = UIApplication.shared.delegate as? AppDelegate
        constants.supportedOrientations = .portrait
        constants.availableModules = [.identity,.selfie,.results]
        constants.showProgressView = true
        constants.authUsername = "oscar.orozco@mobilecardcorp.com"
        //SHA-256 Password
        constants.authPassword = "8dacaf6d2069a49e3860ddb089764f26e3229e751d95622af481162d320d9a97"
        constants.endPoint = "https://uat.firmaautografa.com"
        constants.showResultOnSuccess = false

        //MARK: Config Id
        constants.enableINE = true
        constants.enablePassport = false
        constants.enableOther = false
                
                
        constants.isAcuantFlowEnabled = true

        //Acuant Credentials
        constants.acUserName = "Acuant_Admin@BdC.com"
        constants.acPassword = "J6Jqt2XbQ6^)GefD"
        constants.acSubscription = "ce8066aa-1196-4071-a4c3-ededff1c3f17"
        constants.acFrmEndpoint = "https://frm.acuant.net"
        constants.acPassiveLivenessEndpoint = "https://passlive.acuant.net"
        constants.acHealthInsuranceEndpoint = "https://medicscan.acuant.net"
        constants.acIdEndpoint = "https://services.assureid.net"
        constants.acAcasEndpoint = "https://acas.acuant.net"
        constants.acOzoneEndpoint = "https://ozone.acuant.net"
        
        /*constants.acUserName = "acuantEUUser@naat.com"
        constants.acPassword = "Q^59zWJzZ^jZrw^q"
        constants.acSubscription = "c681321c-2728-4e8a-a3df-a85ba8a11748"
        constants.acFrmEndpoint = "https://eu.frm.acuant.net"
        constants.acPassiveLivenessEndpoint = "https://eu.passlive.acuant.net"
        constants.acHealthInsuranceEndpoint = "https://medicscan.acuant.net"
        constants.acIdEndpoint = "https://services.assureid.net"
        constants.acAcasEndpoint = "https://acas.acuant.net"
        constants.acOzoneEndpoint = "https://ozone.acuant.net"*/
        constants.zoomPublicKey = "-----BEGIN PUBLIC KEY-----\n" +
            "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5PxZ3DLj+zP6T6HFgzzk\n" +
            "M77LdzP3fojBoLasw7EfzvLMnJNUlyRb5m8e5QyyJxI+wRjsALHvFgLzGwxM8ehz\n" +
            "DqqBZed+f4w33GgQXFZOS4AOvyPbALgCYoLehigLAbbCNTkeY5RDcmmSI/sbp+s6\n" +
            "mAiAKKvCdIqe17bltZ/rfEoL3gPKEfLXeN549LTj3XBp0hvG4loQ6eC1E1tRzSkf\n" +
            "GJD4GIVvR+j12gXAaftj3ahfYxioBH7F7HQxzmWkwDyn3bqU54eaiB7f0ftsPpWM\n" +
            "ceUaqkL2DZUvgN0efEJjnWy5y1/Gkq5GGWCROI9XG/SwXJ30BbVUehTbVcD70+ZF\n" +
            "8QIDAQAB\n" +
            "-----END PUBLIC KEY-----"
        constants.zoomLicenceKey = "dAaa7DjCJH7f4zuLwJFFlSjgAXL6k8q2"
        constants.zoomServerBaseURL = "https://facetec-preprod.firmaautografa.com"
        constants.zoomProductionKeyText = "# FaceTec Mobile SDK license\n" +
                                              "appId      = *\n" +
                                              "expiryDate = 2022-05-10\n" +
                                              "key        = 00304502207f0e12c6818c639fac463425e0d149fdfc766f44d65e4d435e9484466514baf002210089fe5e308e0c74f11907c47c8f5e25f10a2040f620c2668e5821a8e5833e2a66"
        constants.selfieModuleOrientation = .portrait
        //constants.documentsModuleOrientation = .portrait
        constants.idModuleOrientation = .portrait
        #endif
        return constants
    }*/
    
}
