//
//  AccountManager.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 11/03/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import Foundation
import Alamofire

class AccountManager {
    var parentViewController: UIViewController?
    
    func login(api: String, params: Parameters){
        Alamofire.request(api, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    print(response)
                    let json = response.result.value as! NSDictionary
                    print(json)
                    print(json["email"]!)
                    UserDefaults.standard.set(json["auth_token"], forKey: "authToken")
                    print(UserDefaults.standard.object(forKey: "authToken")!)
                    UserDefaults.standard.set(json["email"], forKey: "email")
                    print(UserDefaults.standard.object(forKey: "email")!)
                    UserDefaults.standard.set(params["password"], forKey: "password")
                    print(UserDefaults.standard.object(forKey: "password")!)
                    
                    if json["is_keeper"] as! Bool {
                        self.parentViewController?.performSegue(withIdentifier: "adminAccountSegue", sender: nil)
                    } else {
                        self.parentViewController?.performSegue(withIdentifier: "userAccountSegue", sender: nil)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
