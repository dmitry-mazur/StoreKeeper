//
//  CellClasses.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 25/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class RoomNumberCell: UITableViewCell {
    
    let numberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        numberLabel.frame.origin = CGPoint(x: 0, y: 0)
        numberLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.25
        numberLabel.textColor = UIColor(named: "Accent")
        numberLabel.textAlignment = .center
        self.addSubview(numberLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.frame.size = self.frame.size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ItemCell: UITableViewCell {
    
    let itemImage = UIImageView()
    let stepper = CustomStepper()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(itemImage)
        self.addSubview(stepper)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        itemImage.frame = CGRect(x: 16, y: 16, width: self.frame.height - 32, height: self.frame.height - 32)
        stepper.frame.size = CGSize(width: self.frame.width * 0.5, height: self.frame.height * 0.4)
        stepper.frame.origin = CGPoint(x: self.frame.width - stepper.frame.width - 8, y: (self.frame.height - stepper.frame.height)/2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
