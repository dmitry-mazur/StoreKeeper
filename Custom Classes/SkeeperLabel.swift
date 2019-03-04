//
//  SkeeperLabel.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 15/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class SkeeperLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.text = "SKEEPER"
        self.textAlignment = .center
        self.textColor = UIColor(named: "Accent")
        self.font = UIFont(name: "HelveticaNeue-Bold", size: self.frame.height*0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
