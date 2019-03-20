//
//  Room.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 20/03/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import Foundation

class Room {
    var id = Int()
    var number = String()
    
    init(id: Int, number: String) {
        self.id = id
        self.number = number
    }
}
