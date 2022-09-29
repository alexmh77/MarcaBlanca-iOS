//
//  KYCViewController.swift
//  C60S
//
//  Created by Oscar Inowe on 13/01/22.
//

import UIKit
//import FADModuleManagerPod
//import FADModuleIdPod
 
class KYCViewController: UIViewController {
    
    var navController : UINavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        self.navController = self.navigationController

        print("Creating FAD...")
        // Do any additional setup after loading the view.
        
//        FADModuleManager.initProccess(navigation: navController, constants: invokeBiometris(), onSuccess: { (processId) in
//            print(processId)
//            let validationId = FADModuleManager.getValidationId(processId: processId) ?? ""
//            let dataOCR = FADModuleManager.getCredentialOCRCaptured(by: processId)
//            print("esto si se llamo")
//            print("ValidationId: \(validationId)")
//            
//            
//            
//            print("OCR data \(dataOCR)")
//            SurveyData.shared.setKYCStatus(status: true)
//            print("MY NAME#############----####### \(dataOCR?["data_VIZFullName"] ?? "name not found")")
////
////            switch self.defaults.string(forKey: "kycmodule") ?? "" {
////            case "selfie":
////                self.performSegue(withIdentifier: "topersonal", sender: nil)
////                break
////
////            case "kycid":
////                self.performSegue(withIdentifier: "toselfie", sender: nil)
////                break
////
////            case "kycaddress":
////                self.dismiss(animated: true)
////                break
////
////            case "":
////                self.performSegue(withIdentifier: "toselfie", sender: nil)
////                break
////
////            default:
////                self.dismiss(animated: true)
////                break
////            }
//
//            //self.performSegue(withIdentifier: "topersonal", sender: nil)
//
//            //self.performSegue(withIdentifier: "termsandconditionswithoutKYC", sender: nil)
//        }, onCancel: { (processId) in
//            print(processId)
//            print("se cancelo")
//
//            self.dismiss(animated: true)
//        }) { (fail, error) in
//            print("dio error \(error)")
//            print(fail)
//
//            self.dismiss(animated: true)
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if SurveyData.shared.kycStatus {
            self.performSegue(withIdentifier: "toverified", sender: nil)
        }
    }
    
    
    
    /*
    func invokeID() -> FADIdConstants {
        let k = FADIdConstants()
        k.is_show_confirm = false
        k.is_show_ocr = false
        k.is_show_ocr_address = false
        k.enable_passport = false
        k.enable_ine = true
        k.enable_other = false
        k.isAcuantFlowEnabled = true
        
        //Acuant Credentials
        k.acUserName = "Acuant_Admin@BdC.com"
        k.acPassword = "J6Jqt2XbQ6^)GefD"
        k.acSubscription = "ce8066aa-1196-4071-a4c3-ededff1c3f17"
        k.acFrmEndpoint = "https://frm.acuant.net"
        k.acPassiveLivenessEndpoint = "https://passlive.acuant.net"
        k.acHealthInsuranceEndpoint = "https://medicscan.acuant.net"
        k.acIdEndpoint = "https://services.assureid.net"
        k.acAcasEndpoint = "https://acas.acuant.net"
        k.acOzoneEndpoint = "https://ozone.acuant.net"
        
        /*constants.acUserName = "acuantEUUser@naat.com"
        constants.acPassword = "Q^59zWJzZ^jZrw^q"
        constants.acSubscription = "c681321c-2728-4e8a-a3df-a85ba8a11748"
        constants.acFrmEndpoint = "https://eu.frm.acuant.net"
        constants.acPassiveLivenessEndpoint = "https://eu.passlive.acuant.net"
        constants.acHealthInsuranceEndpoint = "https://medicscan.acuant.net"
        constants.acIdEndpoint = "https://services.assureid.net"
        constants.acAcasEndpoint = "https://acas.acuant.net"
        constants.acOzoneEndpoint = "https://ozone.acuant.net"*/
        
        
        
        return k
    }
    
    func invokeBiometris() -> FADManagerConstants {
        #if canImport(FADModuleManagerPod)
        //MARK: FAD Bio Configuration
        
        let constants = FADManagerConstants()
       
        
    
        
        //constants.orientationDelegate = UIApplication.shared.delegate as? AppDelegate
        constants.supportedOrientations = .portrait
        
        constants.availableModules = [.identity,.selfie,.results]
        // Custom Views
        
        let customIdInstructionsDataSource:UIViewController = UIStoryboard(name: "CustomInstructions", bundle: .main).instantiateViewController(withIdentifier: "CustomInstructionsViewControllerId")
        constants.idInstructionsDataSource = customIdInstructionsDataSource
        constants.showProgressView = false
        
        
        let acuantDataSource = UIStoryboard(name: "IdPreviewStoryboard", bundle: .main).instantiateViewController(withIdentifier: "camaraid")
        
        //constants.acuantCaptureDataSource = acuantDataSource as? AcuantCaptureDataSource
        //constants.idCaptureSource = acuantDataSource
        
        
        let idPreviewDataSource = UIStoryboard(name: "CustomSelfiePreview", bundle: .main).instantiateViewController(withIdentifier: "CustomSelfiePreviewViewId")
        constants.idPreviewDataSource = idPreviewDataSource
        
        constants.idModuleOrientation = .portrait
        // Custom Views DOCUMENTS
        var documentsInstructionsDataSource = UIViewController()
        if #available(iOS 13.0, *) {
            print("load documents custom")
            documentsInstructionsDataSource = UIStoryboard(name: "CustomDocumentViews", bundle: .main).instantiateViewController(identifier: "CustomDocumentsInstructionsViewControllerId")
//                selfiePreviewCustom = UIStoryboard(name: "CustomSelfiePreview", bundle: .main) .instantiateViewController(identifier: "CustomSelfiePreviewViewId")
        } else {
            documentsInstructionsDataSource = UIStoryboard(name: "CustomDocumentViews", bundle: .main).instantiateViewController(withIdentifier: "CustomDocumentsInstructionsViewControllerId")
//                selfiePreviewCustom = UIStoryboard(name: "CustomSelfiePreview", bundle: .main) .instantiateViewController(withIdentifier: "CustomSelfiePreviewViewId")
        }
        constants.documentsInstructionsDataSource = documentsInstructionsDataSource
//            let customIdOCRDataSource = UIStoryboard(name: "CustomOCR", bundle: .main).instantiateViewController(withIdentifier: "OCRViewControllerId")
//            constants.idOCRDataSource = customIdOCRDataSource
        
        // Custom Views SELFIE
        
        var customSelfieInstructions = UIViewController()
        var selfiePreviewCustom = UIViewController()

        if #available(iOS 13.0, *) {
            print("load selfie custom")
            customSelfieInstructions = UIStoryboard(name: "CustomSelfieInstructions", bundle: .main).instantiateViewController(identifier: "CustomSelfieInstructionsViewControllerId")
//                selfiePreviewCustom = UIStoryboard(name: "CustomSelfiePreview", bundle: .main) .instantiateViewController(identifier: "CustomSelfiePreviewViewId")
        } else {
            customSelfieInstructions = UIStoryboard(name: "CustomSelfieInstructions", bundle: .main).instantiateViewController(withIdentifier: "CustomSelfieInstructionsViewControllerId")
//                selfiePreviewCustom = UIStoryboard(name: "CustomSelfiePreview", bundle: .main) .instantiateViewController(withIdentifier: "CustomSelfiePreviewViewId")
        }
        
        
        

        constants.selfieInstructionsDataSource = customSelfieInstructions
//            constants.selfiePreviewDataSource = selfiePreviewCustom
        
        
        //constants.showProgressView = true
        constants.authUsername = "dnegreteic@prosperas.com"
        
        
        
        //Custom views
        let customView = CustomHeaderView.instanceFromNib()
        constants.genericHeaderView = customView
        
        //SHA-256 Password
        
        constants.authPassword = "8dacaf6d2069a49e3860ddb089764f26e3229e751d95622af481162d320d9a97"
        constants.endPoint = "https://uat.firmaautografa.com"
        constants.showResultOnSuccess = false

        
        //MARK: Config Id
        constants.enableINE = true
        constants.enablePassport = false
        constants.enableOther = false
        
                
        //constants.isAcuantFlowEnabled = true
        constants.isAcuantFlowEnabled = true
        //constants.isRegulaFlowEnabled = true
        constants.isShowOCRConfirm = false
        constants.showResultOnSuccess = false
        constants.isShowOCR = false
        constants.isShowPreviewSelfie = false
        constants.isShowUploadPreviewView = false
        //constants.acuantDataSource
        
        //Acuant Credentials
        //Acuant Credentials
        constants.acUserName = "acuantEUUser@naat.com"
        constants.acPassword = "Q^59zWJzZ^jZrw^q"
        constants.acSubscription = "c681321c-2728-4e8a-a3df-a85ba8a11748"
        constants.acFrmEndpoint = "https://eu.frm.acuant.net"
        constants.acPassiveLivenessEndpoint = "https://eu.passlive.acuant.net"
        constants.acHealthInsuranceEndpoint = "https://medicscan.acuant.net"
        constants.acIdEndpoint = "https://eu.assureid.acuant.net"
        constants.acAcasEndpoint = "https://eu.acas.acuant.net"
        constants.acOzoneEndpoint = "https://eu.ozone.acuant.net"
        
        //MARK: Selfie
        
        constants.isShowPreviewSelfie = true
        //FaceTec Credentials
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
                                              "expiryDate = 2022-11-10\n" +
                                              "key        = 003045022100c3645f633fac5d5dc8d8b9046c4a266c2454638cb7add27c7cd5624bfacf2fa7022053ec312a3aeec047ef5e3f88469e80a529f5838fdd73c979f6dcb7ff5ee48799"
        constants.selfieModuleOrientation = .portrait
        constants.documentsModuleOrientation = .portrait
        constants.idModuleOrientation = .portrait
        
        
                
        #endif
        return constants
    }*/
    
}

enum kycmodules{
    case kycselfie,kycid,kycaddress
}
