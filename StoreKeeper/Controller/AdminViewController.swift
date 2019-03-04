//
//  AdminViewController.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 13/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class AdminViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let stepper = CustomStepper()
        stepper.frame.size = CGSize(width: 120, height: 40)
        stepper.frame.origin = CGPoint(x: 100, y: 100)
        self.view.addSubview(stepper)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
