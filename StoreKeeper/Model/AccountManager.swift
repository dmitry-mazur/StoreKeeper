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
    
    func login(params: Parameters){
        let progressView = UIActivityIndicatorView()
        progressView.center = (self.parentViewController?.view.center)!
        progressView.color = UIColor(named: "Accent")
        self.parentViewController?.view.addSubview(progressView)
        self.parentViewController?.view.bringSubviewToFront(progressView)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        progressView.transform = CGAffineTransform(scaleX: 1, y: 1)
        progressView.startAnimating()
        
        let api = "\(Global.AppUrl.url)/users/login"
        Alamofire.request(api, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    
                    
                    let json = response.result.value as! NSDictionary
                    UserDefaults.standard.set(json["auth_token"], forKey: "authToken")
                    UserDefaults.standard.set(json["user_id"], forKey: "userID")
                    UserDefaults.standard.set(json["email"], forKey: "email")
                    UserDefaults.standard.set(params["password"], forKey: "password")

                    /*
                    if json["is_keeper"] as! Bool {
                        self.parentViewController?.performSegue(withIdentifier: "adminAccountSegue", sender: nil)
                    } else {
                        self.parentViewController?.performSegue(withIdentifier: "userAccountSegue", sender: nil)
                    }
                    */
                    progressView.stopAnimating()
                    self.parentViewController?.performSegue(withIdentifier: "userAccountSegue", sender: nil)
                } else {
                    progressView.stopAnimating()
                    self.parentViewController?.view.makeToast("Wrong e-mail or password", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func register(params: Parameters){
        let api = "\(Global.AppUrl.url)/users/sign_up"
        Alamofire.request(api, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    let json = response.result.value as! NSDictionary
                    self.login(params: ["email": json["email"]!, "password": json["password"]!])
                } else {
                    self.parentViewController?.view.makeToast("A user with this email already exists", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout(){
        let api = "\(Global.AppUrl.url)/users/logout"
        let headers: HTTPHeaders = [
            "access_token": UserDefaults.standard.object(forKey: "authToken")! as! String,
            "user_id": "\(UserDefaults.standard.object(forKey: "userID")!)"
        ]

        Alamofire.request(api, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).response { _ in
            UserDefaults.standard.set(nil, forKey: "email")
            UserDefaults.standard.set(nil, forKey: "password")
            UserDefaults.standard.set(nil, forKey: "authToken")
            UserDefaults.standard.set(nil, forKey: "userID")
            let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "loginView") as! LoginViewController
            self.parentViewController?.present(loginVC, animated: true, completion: nil)
        }
    }
}
