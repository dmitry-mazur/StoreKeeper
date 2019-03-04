//
//  Extensions.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 14/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField{
    func underlinedLogin(color: UIColor){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension LoginTextField: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textColor = UIColor(named: "Accent")
        textField.underlinedLogin(color: UIColor(named: "Accent")!)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textColor = UIColor(named: "Primary")
        textField.underlinedLogin(color: UIColor(named: "Primary")!)
    }
}
