//
//  ViewController.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 13/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class LoginViewController: UIViewController {
    
    var loginTextField = LoginTextField()
    var passwordTextField = LoginTextField()
    var loginButton = UIButton()
    var registerLabel = UILabel()
    let accountManager = AccountManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor(named: "Background")
        configureLoginFields()
        configureLoginButton()
        configureRegisterLabel()
        accountManager.parentViewController = self
        let email = UserDefaults.standard.object(forKey: "email") ?? ""
        print("1 \(email)")
        let password = UserDefaults.standard.object(forKey: "password") ?? ""
        print("2 \(password)")
        loginTextField.text = email as! String
        passwordTextField.text = password as! String
    }
    
    func configureLoginFields(){
        let skeeperLabel = SkeeperLabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height*0.2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.15))
        self.view.addSubview(skeeperLabel)
        
        loginTextField = LoginTextField(frame: CGRect(x: 24, y: skeeperLabel.frame.origin.y + skeeperLabel.frame.height + 16, width: UIScreen.main.bounds.width - 48, height: UIScreen.main.bounds.height*0.08))
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        self.view.addSubview(loginTextField)
        
        passwordTextField = LoginTextField(frame: CGRect(x: 24, y: loginTextField.frame.origin.y + loginTextField.frame.height + 16, width: loginTextField.frame.width, height: loginTextField.frame.height))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        self.view.addSubview(passwordTextField)
    }
    
    func configureLoginButton(){
        loginButton.frame.size = CGSize(width: passwordTextField.frame.width, height: UIScreen.main.bounds.width*0.12)
        loginButton.frame.origin = CGPoint(x: 24, y: passwordTextField.frame.origin.y + passwordTextField.frame.height + 36)
        loginButton.backgroundColor = UIColor(named: "Accent")
        loginButton.layer.cornerRadius = loginButton.frame.height*0.5
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(UIColor(named: "Background"), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: Global.Fonts.fontHN_Bold, size: loginButton.titleLabel!.font.pointSize)
        loginButton.addTarget(self, action: #selector(loginRequest), for: .touchUpInside)
        self.view.addSubview(loginButton)
    }
    
    @objc func loginRequest(){
        guard let email = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (email == "" || password == "") {
            self.view.makeToast("Fill in the required fields", duration: 3.0, position: .bottom)
        }
        
        let params : Parameters = ["email" : email,
                                   "password" : password
        ]
        
        accountManager.login(api: "\(Global.AppUrl.url)/users/login", params: params)
        
    }
    
    func configureRegisterLabel(){
        registerLabel.frame = CGRect(x: 24, y: loginButton.frame.origin.y + loginButton.frame.height + 8, width: loginButton.frame.width, height: 20)
        registerLabel.text = "Register now"
        registerLabel.textColor = UIColor(named: "Primary")
        registerLabel.textAlignment = .center
        registerLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(registerTap(sender:)))
        registerLabel.addGestureRecognizer(tapGesture)
        self.view.addSubview(registerLabel)
    }
    
    @objc func registerTap(sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "registerSegue", sender: self)
    }
}
