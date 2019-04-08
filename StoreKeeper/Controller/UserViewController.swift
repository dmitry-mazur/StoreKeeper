//
//  UserViewController.swift
//  StoreKeeper
//
//  Created by Dmitry Mazur on 13/02/2019.
//  Copyright © 2019 Dmitry Mazur. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController {
    
    let roomNumbersTable = UITableView()
    var rooms = [Room]()
    let itemsTable = UITableView()
    let items = ["1", "1", "1", "1", "1", "1"]
    let accountManager = AccountManager()
    var itemsImages = [String: UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Background")

        accountManager.parentViewController = self
        configureRoomNumbersTable()
        configureItemsTable()
        
        getRooms()
        test()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nav = self.navigationController?.navigationBar
        
        nav?.barStyle = .blackOpaque
        nav?.backgroundColor = UIColor(named: "Background")
        nav?.tintColor = UIColor(named: "Accent")
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "Accent")!]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(logout))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "refresh"), style: .done, target: self, action: #selector(refresh))
    }
    
    @objc func logout() {
        accountManager.logout()
    }
    
    @objc func refresh() {
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        getRooms()
    }
    
    func test(){
        var json: NSDictionary?
        
        ItemApi.getRoomItems(id: 3, completionHandler: { responseObject, error in
            if responseObject != nil {
                json = responseObject
                print(json)
            } else {
                print(error)
            }
            return
        })
    }
    
    func getRooms() {
        rooms = []
        let api = "\(Global.AppUrl.url)/rooms"
        let headers: HTTPHeaders = [
            "access_token": "\(UserDefaults.standard.object(forKey: "authToken")!)",
            "user_id": "\(UserDefaults.standard.object(forKey: "userID")!)"
        ]
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            let json = response.result.value as! NSDictionary
            for (_, value) in json {
                let room = value as! NSDictionary
                self.rooms.append(Room(id: room["room_id"] as! Int, number: room["number"] as! String))
            }
            self.roomNumbersTable.reloadData()
            self.navigationItem.leftBarButtonItem?.isEnabled = true
        }
    }
    
    func configureRoomNumbersTable() {
        roomNumbersTable.delegate = self
        roomNumbersTable.dataSource = self
        roomNumbersTable.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9294117647, blue: 0.7568627451, alpha: 1)
        roomNumbersTable.separatorStyle = .none
        roomNumbersTable.showsVerticalScrollIndicator = false
        roomNumbersTable.allowsSelection = false
        roomNumbersTable.register(RoomNumberCell.self, forCellReuseIdentifier: "roomNumberCell")
        roomNumbersTable.frame = CGRect(x: 8, y: 8 + UIApplication.shared.statusBarFrame.height + navigationController!.navigationBar.frame.height, width: UIScreen.main.bounds.width*0.3 - 16, height: UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height - navigationController!.navigationBar.frame.height - 16)
        roomNumbersTable.tableFooterView = UIView()
        roomNumbersTable.layer.cornerRadius = 8
        self.view.addSubview(roomNumbersTable)
    }
    
    func configureItemsTable() {
        itemsTable.delegate = self
        itemsTable.dataSource = self
        itemsTable.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9294117647, blue: 0.7568627451, alpha: 1)
        itemsTable.separatorStyle = .none
        itemsTable.showsVerticalScrollIndicator = false
        itemsTable.allowsSelection = false
        itemsTable.register(ItemCell.self, forCellReuseIdentifier: "itemCell")
        itemsTable.frame = CGRect(x: roomNumbersTable.frame.origin.x + roomNumbersTable.frame.width + 8, y: roomNumbersTable.frame.origin.y, width: UIScreen.main.bounds.width - roomNumbersTable.frame.width - roomNumbersTable.frame.origin.x - 16, height: roomNumbersTable.frame.height)
        itemsTable.tableFooterView = UIView()
        itemsTable.layer.cornerRadius = 8
        self.view.addSubview(itemsTable)
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == roomNumbersTable {
            return rooms.count
        }
        
        if tableView == itemsTable {
            return items.count
        }
        
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == roomNumbersTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "roomNumberCell") as! RoomNumberCell
            cell.numberLabel.text = rooms[indexPath.row].number
            cell.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9294117647, blue: 0.7568627451, alpha: 1)
            return cell
        }
        
        if tableView == itemsTable {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell") as! ItemCell
            cell.itemImage.image = UIImage(named: "cookies")
            cell.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9294117647, blue: 0.7568627451, alpha: 1)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (UIScreen.main.bounds.width*0.3 - 16)
    }
}

extension UserViewController: UITableViewDelegate { }
