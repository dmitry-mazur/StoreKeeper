//
//  CellClasses.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 25/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class RoomNumberCell: UITableViewCell {
    
    let backView = UIView()
    let numberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backView.frame.origin = CGPoint(x: 4, y: 4)
        backView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.831372549, alpha: 1)
        backView.layer.cornerRadius = 8
        self.addSubview(backView)
        
        numberLabel.font = UIFont(name: "HelveticaNeue", size: 35)
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.25
        numberLabel.textColor = UIColor(named: "Background")
        numberLabel.textAlignment = .center
        backView.addSubview(numberLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.frame.size = CGSize(width: self.frame.size.width - 8, height: self.frame.size.height - 8)
        backView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 1), cornerRadius: 8)
        numberLabel.frame = CGRect(x: 16, y: 16, width: backView.frame.width - 32, height: backView.frame.height - 32)
        numberLabel.baselineAdjustment = .alignCenters
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ItemCell: UITableViewCell {
    
    let itemImage = UIImageView()
    let stepper = CustomStepper()
    let backView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9529411765, blue: 0.831372549, alpha: 1)
        backView.layer.cornerRadius = 8
        self.addSubview(backView)
        backView.addSubview(itemImage)
        backView.addSubview(stepper)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.frame = CGRect(x: 4, y: 4, width: self.frame.width - 8, height: self.frame.height - 8)
        backView.dropShadow(color: .black, offSet: CGSize(width: 0, height: 1), cornerRadius: 8)
        itemImage.frame = CGRect(x: 8, y: 8, width: backView.frame.height - 16, height: backView.frame.height - 16)
        stepper.frame.size = CGSize(width: backView.frame.width * 0.5, height: backView.frame.height * 0.5)
        stepper.frame.origin = CGPoint(x: backView.frame.width - stepper.frame.width - 8, y: (backView.frame.height - stepper.frame.height)/2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
