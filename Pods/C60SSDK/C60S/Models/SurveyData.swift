//
//  SurveyData.swift
//  C60S
//
//  Created by Oscar Inowe on 27/12/21.
//

import Foundation
import UIKit
import Amplify


class SurveyData {
    
    static let shared = SurveyData()
    
    let requests = SCSRequests()
    var data: [SurveyConfig] = []
    var colors: Colors?
    var creditTypeIndex: Int = 0
    var payperiods: Int = 0
    var productterms: Int = 0
    var productamounts: Int = 0
    var needs: Int = 0
    var workId: Int = 0
    var supportId: [Int] = []
    var incomeId: Int = 0
    var referenceNumber: String = ""
    var consumerid: Int = 0
    var signatureData: String = ""
    var listingid: Int = 0
    var listingBank: String = ""
    var depositacct: String = ""
    var productid: Int = 0
    var origin: UIViewController = C60SSDK_START()
    var originIdentifier: String = ""
    var originStroyboard: String = ""
    var kycStatus = false
    var name = ""
    var isComplete = false
    var errorDescription = "SDK no inicializado"
    
    private init() {}
    
    
    func setIsComplete(complete:Bool){
        self.isComplete = complete
    }
    
    func getIsComplete()->Bool{
        return self.isComplete
    }
    
    func ssetErrorDescription(error:String){
        self.errorDescription = error
    }
    
    func getErrorDescription()->String{
        return self.errorDescription
    }
    
    func setConfig(completion: @escaping () -> ()) {
        print("Querying survey configuration...")
        requests.getConfig(completion: { data, colors in
            print("Got config! \(data?.count)")
            self.data = data ?? []
            self.colors = colors
            completion()
        })
    }
    
    
    func getConfig() -> [SurveyConfig] {
        return data
    }
    
    
    func setCreditTypeIndex(index: Int) {
        self.creditTypeIndex = index
    }
    
    
    func getCreditTypeConfigurations() -> SurveyConfig {
        if let dataPoint = data.first(where: {$0.id == self.creditTypeIndex}) {
            return dataPoint
        } else {
            return data[0]
        }
    }
    
    func setOriginViewController(originVC: UIViewController){
        self.origin = originVC
    }
    
    func getOriginViewController()->UIViewController{
        return self.origin
    }
    
    func setOriginIdentifier(identifier: String){
        self.originIdentifier = identifier
    }
    
    func getOriginIdentifier()->String{
        return self.originIdentifier
    }
    
    
    func setOriginStoryboard(storyboard: String){
        self.originStroyboard = storyboard
    }
    
    func getOriginStoryboard()->String{
        return self.originStroyboard
    }
    
    func setName(customerName: String){
        self.name = customerName
    }
    
    func getName()->String{
        self.name
    }
    
    func setNeedsConfiguration(productamounts: Int) {
        self.productamounts = productamounts
    }
    
    
    func setNeedsSurvey(needs: Int) {
        self.needs = needs
    }
    
    
    func setWorkSurvey(workId: Int) {
        self.workId = workId
    }
    
    
    func setSupportSurvey(supportId: [Int]) {
        self.supportId = supportId
    }
    
    
    func setIncomeTypeSurvey(incomeId: Int) {
        self.incomeId = incomeId
    }
    
    
    func setReferenceNumber(referenceNumber: String) {
        self.referenceNumber = referenceNumber
    }
    
    
    func setKYCStatus(status: Bool) {
        self.kycStatus = status
    }
    
    
    func getKYCStatus() -> Bool {
        return kycStatus
    }
    
    func setConsumerId(consumerid: Int){
        self.consumerid = consumerid
    }
    
    func setListingId(listingId: Int){
        self.listingid = listingId
    }
    
    func setListingBank(name: String){
        self.listingBank = name
    }
    
    func getListBank()->String{
        return self.listingBank
    }
    func setSignatureData(sigatureDataValue: String){
        self.signatureData = sigatureDataValue
    }
    
    func setProductID(productID: Int){
        self.productid = productID
    }
    
    
    
    func getSigSaveRequestData() -> [String: Any]{
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        let dataReq:[String: Any] = [
            
            "consumerid": self.consumerid,
            "listingid": self.listingid,
            "signeddate": dateString,
            "signaturedata": self.signatureData,
            "signaturefilename": "\(self.consumerid)_image.png"
            
        ]
        
        return dataReq
    }
    
    
    func getAccountRequestData(depositAcct: String) -> [String: Any]{
        
        let dataReq:[String: Any] = [
            
            "consumerid": self.consumerid,
            "productid": self.productid,
            "listingid": self.listingid,
            "depositacct": depositAcct
            
        ]
        
        return dataReq
    }
    
    func getListingSearchData() -> [String: Any] {
        let data: [String: Any] = [
            "consumerid" : self.consumerid,
            "referencenumber" : self.referenceNumber,
            "amountid" : self.productamounts,
            "purposeid" : self.needs,
            "categoryid": self.creditTypeIndex,
            "incomeid": self.incomeId,
            "supporttypeid": self.supportId
//            "term": self.productterms,
//            "period": self.payperiods,
//            "score": 0,
        ]
        return data
    }
}
