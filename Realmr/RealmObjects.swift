//
//  RealmObjects.swift
//  Realmr
//
//  Created by Tiago Santos on 12/01/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var name: String? = nil
    var age = RealmOptional<Int>()
    
}

extension User {
    func writeToRealm() {
        try! uiRealm.write {
            uiRealm.add(self)
        }
    }
}
