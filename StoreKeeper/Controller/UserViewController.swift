//
//  UserViewController.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 13/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    let roomNumbersTable = UITableView()
    let roomNumbers = ["303", "410", "409", "408"]
    let itemsTable = UITableView()
    let items = ["1", "1", "1", "1", "1", "1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Background")
        
        configureRoomNumbersTable()
        configureItemsTable()
        let line = UIView(frame: CGRect(x: roomNumbersTable.frame.width, y: UIApplication.shared.statusBarFrame.height, width: 0.5, height: UIScreen.main.bounds.height))
        line.backgroundColor = UIColor(named: "Accent")
        self.view.addSubview(line)
    }
    
    func configureRoomNumbersTable() {
        roomNumbersTable.delegate = self
        roomNumbersTable.dataSource = self
        roomNumbersTable.backgroundColor = UIColor(named: "Background")
        roomNumbersTable.separatorColor = UIColor(named: "Accent")
        roomNumbersTable.showsVerticalScrollIndicator = false
        roomNumbersTable.allowsSelection = false
        roomNumbersTable.register(RoomNumberCell.self, forCellReuseIdentifier: "roomNumberCell")
        roomNumbersTable.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height)
        roomNumbersTable.tableFooterView = UIView()
        self.view.addSubview(roomNumbersTable)
    }
    
    func configureItemsTable() {
        itemsTable.delegate = self
        itemsTable.dataSource = self
        itemsTable.backgroundColor = UIColor(named: "Background")
        itemsTable.separatorColor = UIColor(named: "Accent")
        itemsTable.showsVerticalScrollIndicator = false
        itemsTable.allowsSelection = false
        itemsTable.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
        itemsTable.frame = CGRect(x: roomNumbersTable.frame.width, y: roomNumbersTable.frame.origin.y, width: UIScreen.main.bounds.width - roomNumbersTable.frame.width, height: roomNumbersTable.frame.height)
        itemsTable.tableFooterView = UIView()
        self.view.addSubview(itemsTable)
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == roomNumbersTable {
            return roomNumbers.count
        }
        
        if tableView == itemsTable {
            return items.count
        }
        
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == roomNumbersTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "roomNumberCell") as! RoomNumberCell
            cell.numberLabel.text = roomNumbers[indexPath.row]
            cell.backgroundColor = UIColor(named: "Background")
            return cell
        }
        
        if tableView == itemsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemCell
            cell.itemImage.image = UIImage(named: "cookies")
            cell.backgroundColor = UIColor(named: "Background")
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width*0.3
    }
}

extension UserViewController: UITableViewDelegate { }
