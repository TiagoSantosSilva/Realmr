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
    
    override func viewDidLoad() {
        grabDataFromFirebase()
    }
    
    func grabDataFromFirebase() {
        let databaseReference = Database.database().reference()
        databaseReference.child("users").observe(.value) {
            snapshot in
            
            for snap in snapshot.children.allObjects as! [DataSnapshot] {
                guard let dictionary = snap.value as? [String: AnyObject] else { return }
                
                let name = dictionary["Name"] as? String
                let age = dictionary["Age"] as? Int
                
                let userToAdd = User()
                userToAdd.name = name
                userToAdd.age.value = age
                userToAdd.writeToRealm()
            }
        }
    }
}

