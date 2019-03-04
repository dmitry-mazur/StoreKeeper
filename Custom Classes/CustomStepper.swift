//
//  CustomStepper.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 25/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class CustomStepper: UIView {
    
    let stepButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "Primary")
    }
    
    func configureStepButton(){
        stepButton.frame.size = CGSize(width: self.frame.height, height: self.frame.height)
        stepButton.frame.origin = CGPoint(x: (self.frame.width - stepButton.frame.width)/2.0, y: 0)
        stepButton.backgroundColor = UIColor(named: "Accent")
        stepButton.layer.cornerRadius = stepButton.frame.height/2.0
        stepButton.setTitle("20", for: .normal)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = .left
        stepButton.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        rightSwipe.direction = .right
        stepButton.addGestureRecognizer(rightSwipe)
        
        self.addSubview(stepButton)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = self.frame.height/2.0
        
        let minusButton = UIButton(frame: CGRect(x: 0, y: -self.frame.height*0.05, width: self.frame.height, height: self.frame.height))
        minusButton.setTitle("-", for: .normal)
        minusButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: minusButton.frame.height)
        minusButton.addTarget(self, action: #selector(leftAnimation), for: .touchUpInside)
        self.addSubview(minusButton)
        
        let plusButton = UIButton(frame: CGRect(x: self.frame.width - self.frame.height, y: -self.frame.height*0.1, width: self.frame.height, height: self.frame.height))
        plusButton.setTitle("+", for: .normal)
        plusButton.titleLabel?.font = UIFont(name: "HelveticaNeue", size: plusButton.frame.height)
        plusButton.addTarget(self, action: #selector(rightAnimate), for: .touchUpInside)
        self.addSubview(plusButton)
        
        configureStepButton()
    }
    
    @objc func leftAnimation(){
        self.stepButton.setTitle(String(Int((stepButton.titleLabel?.text)!)!-1), for: .normal)
        UIView.animate(withDuration: 0.1, animations: {
            self.stepButton.frame.origin.x -= 16
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, animations: {
                self.stepButton.frame.origin.x += 16
            })
        })
    }
    
    @objc func rightAnimate(){
        self.stepButton.setTitle(String(Int((stepButton.titleLabel?.text)!)!+1), for: .normal)
        UIView.animate(withDuration: 0.1, animations: {
            self.stepButton.frame.origin.x += 16
        }, completion: {_ in
            UIView.animate(withDuration: 0.1, animations: {
                self.stepButton.frame.origin.x -= 16
            })
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomStepper {
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case .left:
            leftAnimation()
        case .right:
            rightAnimate()
        default:
            return
        }
    }
}
