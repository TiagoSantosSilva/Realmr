//
//  TableViewController.swift
//  Realmr
//
//  Created by Tiago Santos on 12/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import UIKit
import FirebaseDatabase
import RealmSwift

class TableViewController: UITableViewController {
    
    var users: Results<User>!
    
    override func viewDidLoad() {
        grabDataFromFirebase()
    }
    
    func grabDataFromFirebase() {
        let databaseReference = Database.database().reference()
        databaseReference.child("users").observe(.value) {
            snapshot in
            
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else { return }
                print(snap)
                let name = dictionary["Name"] as? String
                let age = dictionary["Age"] as? Int
                
                let userToAdd = User()
                userToAdd.name = name
                userToAdd.age.value = age
                userToAdd.writeToRealm()
            }
            
            self.reloadData()
        }
    }
    
    func reloadData() {
        let ageMinimum = 20
        users = uiRealm.objects(User.self).sorted(byKeyPath: "age", ascending: true).filter("age > %@", ageMinimum)
        self.tableView.reloadData()
    }
}

extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users != nil {
            return users.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "mainCell")
        
        guard let userAge = users[indexPath.row].age.value else { return UITableViewCell() }
        
        cell.textLabel?.text = users[indexPath.row].name
        cell.detailTextLabel?.text = String(describing: userAge)
        return cell
    }
}

