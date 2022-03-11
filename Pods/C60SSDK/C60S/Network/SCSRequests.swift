//
//  SCSRequests.swift
//  C60S
//
//  Created by Oscar Inowe on 22/12/21.
//

import Foundation
import Alamofire
import Amplify

struct SCSRequests {
    let baseURL = "https://mp.securecreditsystems.com/v1/"
    let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
    
    
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
        let path = "Config"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: Survey.self) { (response) in
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
    
    
    func getStates(countryId: Int, completion: @escaping ([States]?) -> ())  {
        let path = "state/country/\(countryId)"
        let headers : HTTPHeaders = ["x-API-KEY": apiKey]
        let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers)
        
        request.responseDecodable(of: [States].self) { (response) in
            guard let states = response.value else { return }
            completion(states)
        }
    }
    
    
    func getListingSearch(data: [String: Any], completion: @escaping (Listing?) -> ())  {
        let path = "listing/search"
        let headersdata : HTTPHeaders = ["x-API-KEY": apiKey]
        
        
        AF.request("\(baseURL)\(path)", method:.post, parameters: data,encoding: JSONEncoding.default,headers: headersdata) .responseDecodable(of: Listing.self) { (response) in
            
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
        Amplify.Auth.fetchUserAttributes() { result in
            switch result {
            case .success(let attributes):
                
                for i in attributes {
                    if (i.key == AuthUserAttributeKey.unknown("sub")) {
                        print(i.value)
                        break
                    }
                }
            case .failure(let error):
                print("Fetching user attributes failed with error \(error)")
            }
        }
    }
}

// **********************
// Codables

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

struct Listing: Codable {
    let top3, all: [All]
}


struct All: Codable {
    let id, productid, lenderid: Int?
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
            case id, productid, lenderid, name
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
