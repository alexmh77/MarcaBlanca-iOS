//
//  SCSRequests.swift
//  C60S
//
//  Created by Oscar Inowe on 22/12/21.
//

import Foundation
import Alamofire
//import Amplify

struct SCSRequests {
    
    //let baseURL = "http://10.135.1.100:8077/v1/"
    let baseURL = "https://mp.securecreditsystems.com/v1/"
    //let baseURL = "http://104.215.91.52:8077/v1/" //Madhouse
    let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
    //let apiKey = "dev"
    
    
    func setLeadDelivery(leadConfigId:Int,completion: @escaping (UTMModel?)-> ()){
        let consumerID:String = PersistanceData().getConsumerId()
        let path = "leaddelivery/verify/\(leadConfigId)/"+consumerID
        print("path :::: \(path)")
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: UTMModel.self) { (response) in
           
            completion(response.value)
        }
    }
    
    func lookUpOrRegister(sessionID: String,completion: @escaping (LookUp?) -> ()){
        
        let path = "consumer/lookuporregister"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey,"Content-Type":"application/json"]
        let dataParamas:[String:Any] = ["sessionid":sessionID]
        
        AF.request("\(baseURL)\(path)", method:.post, parameters: dataParamas,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: LookUp.self) { (response) in
            print(response)
            completion(response.value)
            
        }
    }
    func getConfig(completion: @escaping ([SurveyConfig]?, Colors?) -> ()) {
        let locale = self.getLocale()
       // let path = "Config"
        let path = "Config/044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5/\(locale)"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: Survey.self) { (response) in
            
            print("estoy dentro de getconfig de scr request")
            print(response)
            
            guard let config = response.value?.survey else { return }
            
            guard let colors = response.value?.colors else { return }
            completion(config, colors)
        }
    }
    
    
    func getCountries(completion: @escaping ([Country]?) -> ())  {
        let path = "country"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: [Country].self) { (response) in
            guard let countries = response.value else { return }
            completion(countries)
        }
    }
    
    func getListingHistory(listingid:String,completion: @escaping (ListingHistory?) -> ())  {
        let path = "/listing/"+listingid
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        
        request.responseDecodable(of: ListingHistory.self) { (response) in
            guard let lis = response.value else { return }
            print("status code listing \(response.response?.statusCode)")
            completion(lis)
        }
    }
    
    func getLenderHistory(lenderid:String,completion: @escaping (LenderHistory?) -> ())  {
        let path = "/lender/"+lenderid
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: LenderHistory.self) { (response) in
            guard let lis = response.value else { return }
            print("status code lender \(response.response?.statusCode)")
            completion(lis)
        }
    }
    
    func getStates(countryId: Int, completion: @escaping ([States]?) -> ())  {
        let path = "state/country/\(countryId)"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: [States].self) { (response) in
            guard let states = response.value else { return }
            completion(states)
        }
    }
    
    func getConsumerEmptyUser(completion: @escaping (ConsumerUser?)-> Void){
        
        let path = "consumer/new"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        
        AF.request("\(baseURL)\(path)", method:.post, parameters: nil,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: ConsumerUser.self) { (response) in
            
            completion(response.value)
            
        }
        
    }
    
    func setFirebaseAndConsumer(consumerid:String,completion: @escaping (String)-> Void){
        
        let path = "notify/consumer"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        let params:[String:Any] = ["consumeruuid": consumerid,
                                   "firebasetoken": SurveyData.shared.getFirebaseToken()]
        
        print("DATA TO SEND FIREBASE######### \(params as Any)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: params,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: String.self) { (response) in
            
            //completion(response.value ?? "")
            
            response.response?.statusCode == 200 ? completion("success") : completion("error")
            
        }
        
    }
    
    func setBusiness(nameBusiness:String,description: String,adress: String,seniority:Int,rfc:String,completion: @escaping (String)-> Void){
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let path = "/business"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        let params:[String:Any] = ["id":0,
                                   "consumerid": PersistanceData().getConsumerId() ,
                                   "name": nameBusiness,
                                   "description":description,
                                   "phone":"",
                                   "address1":adress,
                                   "address2":"",
                                   "postalcode":"",
                                   "stateid":0,
                                   "countryid":0,
                                   "seniority":seniority,
                                   "taxid":rfc,
                                   "created":dateString,
                                   "modified":dateString,
                                   "deleted":dateString]
        print("se manda esto \(params)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: params,encoding: JSONEncoding.default,headers: headersdata).responseJSON(completionHandler: { response in
            response.response?.statusCode == 200 ? completion("success") : completion("error")
        })
    }
    
    func setListingView(listingId:Int,duration: Int,productId: String,completion: @escaping (String)-> Void){
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let path = "/listing/view"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        let params:[String:Any] = ["consumerid": SurveyData.shared.getConsumerId(),
                                   "listingid": listingId,
                                   "productid": productId,
                                   "displayed": dateString,
                                   "duration": duration]
        
        print("DATA TO SEND LISTING VIEW######### \(params as Any)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: params,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: String.self) { (response) in
            
            //completion(response.value ?? "")
            
            response.response?.statusCode == 200 ? completion("success") : completion("error")
            
        }
        
    }
    
    func setTracker(id:Int,orgid: Int,typeid: Int,completion: @escaping (String)-> Void){
        
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        
        let path = "/tracker"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        let params:[String:Any] = ["id": id,
                                   "orgid": orgid,
                                   "consumerid": SurveyData.shared.getConsumerId(),
                                   "typeid": typeid,
                                   "insertdate": dateString]
        
        print("DATA TO SEND TRACKER######### \(params as Any)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: params,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: String.self) { (response) in
            
            //completion(response.value ?? "")
            
            //print("ERROR en tracker##### \(response.error.debugDescription)")
            response.response?.statusCode == 200 ? completion("success") : completion("error")
            
        }
        
    }
    
    
    func updateConsumerUser(data: [String:Any],completion: @escaping (ConsumerUser?)-> Void){
        
        let path = "consumer"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        
        AF.request("\(baseURL)\(path)", method: .put, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: ConsumerUser.self) { (response) in
            
            completion(response.value)
            
        }
        
    }
    
    
    
    func getListingSearch(data: [String: Any], completion: @escaping (Listing?) -> ())  {
        let path = "listing/search"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: Listing.self) { (response) in
            
            completion(response.value)
            
        }
        
    }
    
    func saveBusiness(data: [String: Any], completion: @escaping (Business?) -> ())  {
        let path = "business"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: Business.self) { (response) in
            
            completion(response.value)
            
        }
        
    }
    
    func sigSave(data: [String: Any], completion: @escaping (SigSave?) -> ()){
        let path = "listing/select/sigsave"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        print("data \(data)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: SigSave.self) { (response) in
            print(response.result)
            completion(response.value)
            
        }
    }
    
    func AccountSave(data: [String: Any], completion: @escaping (Account?) -> ()){
        let path = "account"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        print("data \(data)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: Account.self) { (response) in
            print(response.result)
            completion(response.value)
            
        }
    }
    
    func ListingsBySession(data: [String: Any], completion: @escaping (ListingsCodable?,String) -> ()){
        let path = "consumer/listings/sessionid"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        print("data \(data)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: ListingsCodable.self) { (response) in
            //print(response.result)
            completion(response.value, response.debugDescription)
            
        }
    }
    
    func ConsumerByID(data: [String: Any], completion: @escaping (Consumer?,String) -> ()){
        let path = "consumer/listings/consumerid"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        print("data \(data)")
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: Consumer.self) { (response) in
            print(response.result)
            completion(response.value, response.debugDescription)
            
        }
    }
    
    func getTermsAndConditions(id: String, completion: @escaping (TermsAndConditions?) -> ()) {
        let path = "termsandconditions/\(id)"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        
        request.responseDecodable(of: TermsAndConditions.self) { (response) in
            guard let terms = response.value else { return }
            completion(terms)
        }
    }
    
    
    func saveLogin() {
//        Amplify.Auth.fetchUserAttributes() { result in
//            switch result {
//            case .success(let attributes):
//                
//                for i in attributes {
//                    if (i.key == AuthUserAttributeKey.unknown("sub")) {
//                        print(i.value)
//                        break
//                    }
//                }
//            case .failure(let error):
//                print("Fetching user attributes failed with error \(error)")
//            }
//        }
    }
    func getLocale()-> String{
        var paisSend = "es-rMX"
        switch Locale.preferredLanguages[0]{
        case "es-MX":
            paisSend = "es-rMX"
            break
        case "es-CO":
            paisSend = "es-rCO"
            break
            
        case "es-PE":
            paisSend = "es-rPE"
            break
            
        case "en-US":
            paisSend = "en-rUS"
            break
            
        default:
            paisSend = "es-rMX"
            break
        }
        return paisSend
    }
}



// **********************
// Codables

struct ListingHistory: Codable {
    let id, productid, lenderid: Int
    let name, listingHistoryDescription, unitcost: String
    let currencyid: Int?
    let tandcid, countryid, stateid, lowscore: Int
    let highscore: Int
    let modifydate: String?
    let createdate: String
    let deleted: String?

    enum CodingKeys: String, CodingKey {
        case id, productid, lenderid, name
        case listingHistoryDescription = "description"
        case unitcost, currencyid, tandcid, countryid, stateid, lowscore, highscore, modifydate, createdate, deleted
    }
}

struct LenderHistory: Codable {
    let id: Int
    let name: String
    let email, phone, website, lenderHistoryDescription: String?
    let countryid: Int
    let lowscorethreshold, campaigncostlimit, dailycostlimit, stateid: Int
    let password, lenderuuid: String?
    let kycflag: Bool
    let companyicon: String
    let s3Bucket: String?
    let createdate: String
    let modifydate: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, website
        case lenderHistoryDescription = "description"
        case countryid, lowscorethreshold, campaigncostlimit, dailycostlimit, stateid, password, lenderuuid, kycflag, companyicon
        case s3Bucket = "s3bucket"
        case createdate, modifydate
    }
}

struct ConsumerUser: Codable {
    let created: String?
    let modified, deleted: String?
    let id: Int?
    let name, email, phone, stateid: String?
    let countryid, password, consumeruuid, firebasetoken: String?
    let fathersname, mothersname, firstname, secondname: String?
    let claro360ID: String?

    enum CodingKeys: String, CodingKey {
        case created, modified, deleted, id, name, email, phone, stateid, countryid, password, consumeruuid, firebasetoken, fathersname, mothersname, firstname, secondname
        case claro360ID = "claro360id"
    }
}


struct ConsumerElement: Codable {
    let id, consumerid, listingid, productid: Int?
    let unitcost: String?
    let tandc, tandcsig: String?
    let tandcsigdate, selected: String?
    let signatureuri: String?
    let rejectdate, status: String?
}

typealias Consumer = [ConsumerElement]

struct Business: Codable {
    let id, consumerid: Int
    let name, businessDescription, phone, address1: String
    let address2, postalcode: String
    let stateid, countryid: Int
    let created, modified, deleted: String

    enum CodingKeys: String, CodingKey {
        case id, consumerid, name
        case businessDescription = "description"
        case phone, address1, address2, postalcode, stateid, countryid, created, modified, deleted
    }
}

struct ListingsCodableElement: Codable {
    let id, consumerid, listingid, productid: Int?
    let unitcost: String?
    let tandc, tandcsig: String?
    let tandcsigdate, selected: String?
    let signatureuri: String?
    let rejectdate, status: String?
}

typealias ListingsCodable = [ListingsCodableElement]

struct Account: Codable {
    let id, consumerid, productid: Int?
    let depositacct, collecteddate: String?
    let name, denied, listingid: String?
}

struct SigSave: Codable {
    let id, listingid, consumerid, productid: Int?
    let unitcost: String?
    let tandc: String?
    let tandcsigdate, selected: String?
    let signatureuri: String?
    let tandcsig, rejectdate, status: String?
}

struct UTMModel: Codable {
    let createdate: String?
    let id, leadconfigid: Int?
    let url: String?
    let consumerid: Int?
    let modifydate: String?
}

struct Listing: Codable {
    let top3, all: [All]
}


struct All: Codable {
        let id, productid, lenderid: Int? ,leadconfigid:Int?
        let name, allDescription, unitcost: String?
        let tandcid, countryid, stateid: Int?
        let modifydate: String?
        let createdate: String?
        let currencyid: Int?
        let lowscore, highscore: Int?
        let deleted: String?
        let lenderID: Int?
        let lenderCompanyicon: String?
        let lenderName: String?
        let lenderKycflag: Bool?
        let productInterestrate: String?
        let productID, productLowamount, productHighamount, productMinincome: Int?
        let productMaxincome, productLowscore, productHighscore: Int?
    
    

        enum CodingKeys: String, CodingKey {
            case id, productid, lenderid, name,leadconfigid
            case allDescription = "description"
            case unitcost, tandcid, countryid, stateid, modifydate, createdate, currencyid, lowscore, highscore, deleted
            case lenderID = "lender.id"
            case lenderCompanyicon = "lender.companyicon"
            case lenderName = "lender.name"
            case lenderKycflag = "lender.kycflag"
            case productInterestrate = "product.interestrate"
            case productID = "product.id"
            case productLowamount = "product.lowamount"
            case productHighamount = "product.highamount"
            case productMinincome = "product.minincome"
            case productMaxincome = "product.maxincome"
            case productLowscore = "product.lowscore"
            case productHighscore = "product.highscore"
        }
}

struct LookUp: Codable {
    let id: Int?
    let name: String?
    let firstname: String?
    let secondname: String?
    let fathersname: String?
    let mothersname: String?
    let claro360id: String?
    let email: String?
    let phone: String?
    let stateid: String?
    let countryid: String?
    let password: String?
    let consumeruuid: String?
    let firebasetoken: String?
    let created: String?
    let modified: String?
    let deleted: String?
}

struct Survey: Codable {
    let colors: Colors?
    let survey: [SurveyConfig]?
}

struct Colors: Codable {
    let cardEnableColor: String?
    let activeLabelColor: String?
    let cardDisableColor: String?
    let activeButtonColor: String?
    let disableLabelColor: String?
    let disableButtonColor: String?
}


struct SurveyConfig: Codable {
    let id: Int
    let name: String
    let description: String?
    let icon: String?
    let lowamount: Int
    let highamount: Int
    let productpurposes: [ProductPurposes]?
    let payperiods: [PayPeriods]?
    let productterms: [ProductTerms]?
    let productamounts: [ProductAmounts]?
    let supporttypes: [SupportTypes]
    let employmenttypes: [EmploymentTypes]
    let incometypes: [IncomeTypes]?
}

struct ProductPurposes: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let categoryid: Int?
    let description: String?
}

struct PayPeriods: Codable {
    let id: Int?
    let name: String?
    let categoryid: Int?
    let description: Int?
}

struct ProductTerms: Codable {
    let id: Int?
    let name: String?
    let categoryid: Int?
    let description: Int?
}

struct ProductAmounts: Codable {
    let id: Int?
    let name: String?
    let categoryid: Int?
    let value: Int?
    let description: String?
}

struct SupportTypes: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let categoryid: Int?
    let description: String?
}

struct IncomeTypes: Codable {
    let id: Int?
    let name: String?
    let categoryid: Int?
    let value: Int?
    let description: String?
}

struct EmploymentTypes: Codable {
    let id: Int?
    let icon: String?
    let name: String?
    let categoryid: Int?
    let description: String?
}

// *******************



struct Country: Codable {
    let id: Int
    let name: String
}

struct States: Codable {
    let id: Int
    let countryid: Int
    let name: String
}


struct TermsAndConditions: Codable {
    let id: Int?
    let lenderid: Int?
    let name: String?
    let description: String?
    let link: String?
}


//struct ListingArray: Codable {
//    let listing: [Listing?]
//}
//
//struct Listing: Codable {
//    let id: Int?
//    let productid: Int?
//    let lenderid: Int?
//    let name: String?
//    let description: String?
//    let unitcost: Float?
//    let currencyid: String?
//    let tandcid: Int?
//    let countryid: Int?
//    let stateid: Int?
//    let highscore: Int?
//    let lowscore: Int?
//    let createdate: String?
//    let modifydate: String?
//    let deleted: String?
//}
