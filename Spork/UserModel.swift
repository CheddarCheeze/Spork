//
//  UserModel.swift
//  Spork
//
//  Created by Adrian Ordorica on 9/26/16.
//  Copyright © 2016 Adrian Ordorica. All rights reserved.
//

import Foundation

class UserModel: NSObject {
    
    //properties
    
    var id: String?
    var name: String?
    var username: String?
    var email: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @id, @name, @username, and @email parameters
    
    init(id: String, name: String, username: String, email: String) {
        
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(id), Name: \(name), Username: \(username), Email: \(email)"
        
    }
    
    
}
