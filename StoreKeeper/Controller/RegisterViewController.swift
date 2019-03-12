//
//  RegisterViewController.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 13/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class RegisterViewController: UIViewController {
    
    var loginTextField = LoginTextField()
    var usernameTextField = LoginTextField()
    var passwordTextField = LoginTextField()
    var adminCheck = UISwitch()
    var registerButton = UIButton()
    var loginLabel = UILabel()
    let api = "https://stark-hamlet-26364.herokuapp.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        self.view.backgroundColor = UIColor(named: "Background")
        configureRegisterFields()
        configureSwitch()
        configureRegisterButton()
        configureLoginLabel()
    }
    
    func configureRegisterFields(){
        let skeeperLabel = SkeeperLabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height*0.15, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.15))
        self.view.addSubview(skeeperLabel)
        
        loginTextField = LoginTextField(frame: CGRect(x: 24, y: skeeperLabel.frame.origin.y + skeeperLabel.frame.height + 16, width: UIScreen.main.bounds.width - 48, height: UIScreen.main.bounds.height*0.08))
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        self.view.addSubview(loginTextField)
        
        usernameTextField = LoginTextField(frame: CGRect(x: 24, y: loginTextField.frame.origin.y + loginTextField.frame.height + 16, width: loginTextField.frame.width, height: loginTextField.frame.height))
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        self.view.addSubview(usernameTextField)
        
        passwordTextField = LoginTextField(frame: CGRect(x: 24, y: usernameTextField.frame.origin.y + usernameTextField.frame.height + 16, width: usernameTextField.frame.width, height: usernameTextField.frame.height))
        passwordTextField.isSecureTextEntry = true
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "Primary")!])
        self.view.addSubview(passwordTextField)
    }
    
    func configureSwitch(){
        adminCheck.frame.origin = CGPoint(x: 24, y: passwordTextField.frame.origin.y + passwordTextField.frame.height + 24)
        adminCheck.frame.size = CGSize(width: UIScreen.main.bounds.width*0.1, height: UIScreen.main.bounds.width*0.2)
        adminCheck.tintColor = UIColor(named: "Primary")
        adminCheck.onTintColor = #colorLiteral(red: 0.840606153, green: 0.5760239363, blue: 0.1733036637, alpha: 1)
        adminCheck.thumbTintColor = UIColor(named: "Accent")
        let questionLabel = UILabel(frame: CGRect(x: adminCheck.frame.origin.x + adminCheck.frame.width + 16, y: adminCheck.frame.origin.y, width: UIScreen.main.bounds.width, height: adminCheck.frame.height))
        questionLabel.text = "I'M SKEEPER"
        questionLabel.font = UIFont(name: "HelveticaNeue", size: questionLabel.frame.height*0.6)
        questionLabel.textColor = UIColor(named: "Primary")
        self.view.addSubview(adminCheck)
        self.view.addSubview(questionLabel)
    }
    
    func configureRegisterButton(){
        registerButton.frame.size = CGSize(width: passwordTextField.frame.width, height: UIScreen.main.bounds.width*0.12)
        registerButton.frame.origin = CGPoint(x: 24, y: adminCheck.frame.origin.y + adminCheck.frame.height + 16)
        registerButton.backgroundColor = UIColor(named: "Accent")
        registerButton.layer.cornerRadius = registerButton.frame.height*0.5
        registerButton.setTitle("LOGIN", for: .normal)
        registerButton.setTitleColor(UIColor(named: "Background"), for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: registerButton.titleLabel!.font.pointSize)
        registerButton.addTarget(self, action: #selector(registerRequest), for: .touchUpInside)
        self.view.addSubview(registerButton)
    }
    
    @objc func registerRequest(){
        guard let email = loginTextField.text else { return }
        guard let name = usernameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if (email == "" || name == "" || password == "") {
            self.view.makeToast("Fill in the required fields", duration: 3.0, position: .bottom)
            return
        }
        
        let params : Parameters = ["email" : email,
                                   "name" : name,
                                   "password" : password,
                                   "is_keeper" : adminCheck.isOn
        ]
        
        Alamofire.request("\(Global.AppUrl.url)/users/sign_up", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else { return }
                if statusCode == 200 {
                    print(response)
                    print(statusCode)
                } else {
                    print(statusCode)
                    self.view.makeToast("A user with this email already exists", duration: 3.0, position: .bottom)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureLoginLabel(){
        loginLabel.frame = CGRect(x: 24, y: registerButton.frame.origin.y + registerButton.frame.height + 8, width: registerButton.frame.width, height: 20)
        loginLabel.text = "Back to login"
        loginLabel.textColor = UIColor(named: "Primary")
        loginLabel.textAlignment = .center
        loginLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backToLogin(_:)))
        loginLabel.addGestureRecognizer(tapGesture)
        self.view.addSubview(loginLabel)
    }
    
    @objc func backToLogin(_ sender: UITapGestureRecognizer){
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
}
