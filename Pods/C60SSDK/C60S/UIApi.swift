//
//  UIApi.swift
//  C60S
//
//  Created by Sayab Perez on 17/05/22.
//

import UIKit
import Foundation
import Alamofire
//import Amplify

enum AppSections{
    case SupportSurvey
}

extension UIViewController{
    func bImage(){
       
 }
}
extension UIImageView {

        
    func downloaded(asset: String, bgcolor: String, contentMode mode: ContentMode = .scaleAspectFit) {
        
      /*  func callImage (element: String, bg: String, elementId: UIImageView,  completion: @escaping (( String, String ) -> Void) ) {
            
            print("llamada en imagen")
            
            let baseURL = "https://mp.securecreditsystems.com/v1/"
            let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
            
            let path = "Config"
            let headers : HTTPHeaders = ["x-API-KEY": apiKey]
            let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:
                    let resJSON = JSON(response.value)
                    let image = resJSON["resources"][element].stringValue
                    let bgcolor = resJSON["colors"][bg].stringValue
                    let bgcolor8 = bgcolor + "FF"
                    completion(image, bgcolor8)
                    
                case .failure(let error):
                    print(error)
                }
            })

        }*/
        
        func getjsons (element: String, bg: String, elementId: UIImageView,  completion: @escaping (( String, String ) -> Void) ) {
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                return documentsDirectory
            }
            let dir = getDocumentsDirectory()
            let dirUrl = dir.absoluteString
            let urlString = dirUrl + "config.json"
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let resJSON = JSON(parsedData)
                        let image = resJSON["resources"][element].stringValue
                        let bgcolor = resJSON["colors"][bg].stringValue
                        let bgcolor8 = bgcolor + "FF"
                        completion(image, bgcolor8)
                    } catch let error as NSError {
                    }
                }
            }.resume()
        }
        
        getjsons ( element:asset, bg:bgcolor, elementId: self,  completion: { image, bgcolor in
            
            DispatchQueue.main.async {
                let image2 = URL(string: image) as! URL
                self.contentMode = mode
                URLSession.shared.dataTask(with: image2) { data, response, error in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }

                    DispatchQueue.main.async() { [weak self] in
                        self?.image = image
                    }
                }.resume()
                let bgcolor_hex = UIColor(hex: bgcolor)
                self.backgroundColor = bgcolor_hex
            }
        })
    }
    
    func downloadedStringWithModel(asset: String, bgcolor: String, contentMode mode: ContentMode = .scaleAspectFit,model:Any,section:AppSections){
        print("este esmi asset");
        print(asset)
        if let image2 = URL(string: asset){
            self.contentMode = mode
            URLSession.shared.dataTask(with: image2) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                    switch  section{
                    case .SupportSurvey:
                        if let model = model as? SupportSurveyModel{
                            model.imagen = image
                        }
                        break
                    }
                    
                }
            }.resume()
        }
    }
    
    func downloadedString(asset: String, bgcolor: String, contentMode mode: ContentMode = .scaleAspectFit){
        
        print("este esmi asset");
        print(asset)
        if let image2 = URL(string: asset){
            self.contentMode = mode
            URLSession.shared.dataTask(with: image2) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    }
    
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension UIButton {
    
    func buttonStyle(bgcolor: String, textcolor: String, bordercolor: String) {
        
        func getjsons (bg: String, text: String, border: String, elementId: UIButton,  completion: @escaping (( String, String, String ) -> Void) ) {
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                return documentsDirectory
            }
            let dir = getDocumentsDirectory()
            let dirUrl = dir.absoluteString
            let urlString = dirUrl + "config.json"
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let resJSON = JSON(parsedData)
                        let bgcolor = resJSON["colors"][bg].stringValue
                        let textcolor = resJSON["colors"][text].stringValue
                        let bordercolor = resJSON["colors"][border].stringValue
                        let bgcolor8 = bgcolor + "FF"
                        let textcolor8 = textcolor + "FF"
                        let bordercolor8 = bordercolor + "FF"
                        completion(bgcolor8, textcolor8, bordercolor8)
                    } catch let error as NSError {
                    }
                }
            }.resume()
        }

        
     /*   func callColors (bg: String, text: String, border: String, elementId: UIButton,  completion: @escaping (( String, String, String ) -> Void) ) {
            
            print("llamada en boton")
            let baseURL = "https://mp.securecreditsystems.com/v1/"
            let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
            
            let path = "Config"
            let headers : HTTPHeaders = ["x-API-KEY": apiKey]
            let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:

                    let resJSON = JSON(response.value)
                    let bgcolor = resJSON["colors"][bg].stringValue
                    let textcolor = resJSON["colors"][text].stringValue
                    let bordercolor = resJSON["colors"][border].stringValue
                    let bgcolor8 = bgcolor + "FF"
                    let textcolor8 = textcolor + "FF"
                    let bordercolor8 = bordercolor + "FF"
                    completion(bgcolor8, textcolor8, bordercolor8)
                    
                case .failure(let error):
                    print(error)
                }
            })

        }*/
        
        getjsons ( bg:bgcolor, text:textcolor, border:bordercolor, elementId: self,  completion: { bgcolor, textcolor, bordercolor in

            DispatchQueue.main.async {
                let bgcolor_hex = UIColor(hex: bgcolor)
                let textcolor_hex = UIColor(hex: textcolor)
                let bordercolor_hex = UIColor(hex: bordercolor)
                self.backgroundColor = bgcolor_hex
                self.setTitleColor(textcolor_hex, for: UIControl.State.normal)
                self.layer.borderColor = bordercolor_hex?.cgColor
                self.layer.borderWidth = 2
                self.layer.cornerRadius = 20
            }
        })
    }
}


extension UITableView {
    

    func tableStyle(bgcolor: String) {

        /*func callColors (bg: String, elementId: UITableView,  completion: @escaping (( String ) -> Void) ) {
            
            print("llamada en tabla")
            let baseURL = "https://mp.securecreditsystems.com/v1/"
            let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
            
            let path = "Config"
            let headers : HTTPHeaders = ["x-API-KEY": apiKey]
            let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:

                    let resJSON = JSON(response.value)
                    let bgcolor = resJSON["colors"][bg].stringValue
                    let bgcolor8 = bgcolor + "FF"
                    completion(bgcolor8)
                    
                case .failure(let error):
                    print(error)
                }
            })

        }*/
        
        func getjsons (bg: String, elementId: UITableView,  completion: @escaping (( String ) -> Void) ) {
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                return documentsDirectory
            }
            let dir = getDocumentsDirectory()
            let dirUrl = dir.absoluteString
            let urlString = dirUrl + "config.json"
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let resJSON = JSON(parsedData)
                        let bgcolor = resJSON["colors"][bg].stringValue
                        let bgcolor8 = bgcolor + "FF"
                        completion(bgcolor8)
                    } catch let error as NSError {
                    }
                }
            }.resume()
        }

        getjsons ( bg:bgcolor, elementId: self,  completion: { bgcolor in
            DispatchQueue.main.async {
                let bgcolor_hex = UIColor(hex: bgcolor)
                self.backgroundColor = bgcolor_hex
            }
        })


    }
}

extension UILabel {
    

    func labelStyle(bgcolor: String, textcolor: String) {
        
        /*func callColors (bg: String, text: String, elementId: UILabel,  completion: @escaping (( String, String ) -> Void) ) {
            
            print("llamada en label")
            let baseURL = "https://mp.securecreditsystems.com/v1/"
            let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
            
            let path = "Config"
            let headers : HTTPHeaders = ["x-API-KEY": apiKey]
            let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:

                    let resJSON = JSON(response.value)
                    let bgcolor = resJSON["colors"][bg].stringValue
                    let textcolor = resJSON["colors"][text].stringValue
                    let bgcolor8 = bgcolor + "FF"
                    let textcolor8 = textcolor + "FF"
                    completion(bgcolor8, textcolor8)
                    
                case .failure(let error):
                    print(error)
                }
            })

        }*/
        
        func getjsons (bg: String, text: String, elementId: UILabel,  completion: @escaping (( String, String ) -> Void) ) {
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                return documentsDirectory
            }
            let dir = getDocumentsDirectory()
            let dirUrl = dir.absoluteString
            let urlString = dirUrl + "config.json"
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let resJSON = JSON(parsedData)
                        let bgcolor = resJSON["colors"][bg].stringValue
                        let textcolor = resJSON["colors"][text].stringValue
                        let bgcolor8 = bgcolor + "FF"
                        let textcolor8 = textcolor + "FF"
                        completion(bgcolor8, textcolor8)
                    } catch let error as NSError {
                    }
                }
            }.resume()
        }

        getjsons ( bg:bgcolor, text:textcolor, elementId: self,  completion: { bgcolor, textcolor in
            DispatchQueue.main.async {
                let bgcolor_hex = UIColor(hex: bgcolor)
                let textcolor_hex = UIColor(hex: textcolor)
                self.textColor = textcolor_hex
                self.backgroundColor = bgcolor_hex
            }
        })


    }
}

extension UIView {
    

    func viewStyle(bgcolor: String) {

       /* func callColors (bg: String, elementId: UIView, completion: @escaping (( String ) -> Void) ) {
            
            print("llamada en view")
            let baseURL = "https://mp.securecreditsystems.com/v1/"
            let apiKey = "044bbc6e-37e1-4e7a-bb64-ba8dc8696dd5"
            
            let path = "Config"
            let headers : HTTPHeaders = ["x-API-KEY": apiKey]
            let request = AF.request("\(baseURL)\(path)", method: .get, headers: headers).responseJSON(completionHandler: { response in
                
                switch response.result {
                case .success:

                    let resJSON = JSON(response.value)
                    let bgcolor = resJSON["colors"][bg].stringValue
                    let bgcolor8 = bgcolor + "FF"
                    completion(bgcolor8)
                    
                case .failure(let error):
                    print(error)
                }
            })

        }*/
        
        func getjsons (bg: String, elementId: UIView, completion: @escaping (( String ) -> Void) ) {
            func getDocumentsDirectory() -> URL {
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let documentsDirectory = paths[0]
                return documentsDirectory
            }
            let dir = getDocumentsDirectory()
            let dirUrl = dir.absoluteString
            let urlString = dirUrl + "config.json"
            let url = URL(string: urlString)
            URLSession.shared.dataTask(with:url!) { (data, response, error) in
                if error != nil {
                } else {
                    do {
                        let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                        let resJSON = JSON(parsedData)
                        let bgcolor = resJSON["colors"][bg].stringValue
                        let bgcolor8 = bgcolor + "FF"
                        completion(bgcolor8)
                    } catch let error as NSError {
                    }
                }
            }.resume()
        }

        getjsons ( bg:bgcolor, elementId: self,  completion: { bgcolor in
            DispatchQueue.main.async {
                let bgcolor_hex = UIColor(hex: bgcolor)
                self.backgroundColor = bgcolor_hex
            }
        })


    }
}
