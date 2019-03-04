//
//  LoginTextField.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 15/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.underlinedLogin(color: UIColor(named: "Primary")!)
        self.textColor = UIColor(named: "Primary")
        self.font = UIFont(name: "HelveticaNeue", size: self.frame.height*0.4)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
