//
//  ItemApi.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 27/03/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ItemApi {
    private init() {}
    
    static func getAllItemsType() {
        let url = "\(Global.AppUrl.url)/ledgers"
        
        let headers: HTTPHeaders = [
            "access_token": "\(UserDefaults.standard.object(forKey: "authToken")!)",
            "user_id": "\(UserDefaults.standard.object(forKey: "userID")!)"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            let json = response.result.value as! NSDictionary
            print(json)
            
        }
    }
    
    
    static func getRoomItems(id: Int, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let url = "\(Global.AppUrl.url)/rooms/\(id)"
        let headers: HTTPHeaders = [
            "access_token": "\(UserDefaults.standard.object(forKey: "authToken")!)",
            "user_id": "\(UserDefaults.standard.object(forKey: "userID")!)"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                completionHandler((value as! NSDictionary), nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    static func getItemImage(url: String) -> UIImage? {
        var image: UIImage?
        
        let headers: HTTPHeaders = [
            "access_token": "\(UserDefaults.standard.object(forKey: "authToken")!)",
            "user_id": "\(UserDefaults.standard.object(forKey: "userID")!)"
        ]
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseImage(completionHandler: { response in
            image = response.result.value
        })
        
        return image
    }
}
