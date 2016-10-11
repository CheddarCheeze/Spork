//
//  RecipeModel.swift
//  Spork
//
//  Created by Adrian Ordorica on 9/27/16.
//  Copyright © 2016 Adrian Ordorica. All rights reserved.
//

import Foundation

class RecipeModel: NSObject {
    
    //properties
    
    var id: String?
    var user_id: String?
    var title: String?
    var picture: String?
    var prep_time: String?
    var cook_time: String?
    var notes: String?
    
    
    //empty constructor
    
    override init()
    {
        
    }
    
    //construct with @id, @name, @username, and @email parameters
    
    init(id: String, user_id: String, title: String, picture: String, prep_time: String, cook_time: String, notes: String) {
        
        self.id = id
        self.user_id = user_id
        self.title = title
        self.picture = picture
        self.prep_time = prep_time
        self.cook_time = cook_time
        self.notes = notes
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ID: \(id), User_ID: \(user_id), Title: \(title), Picture: \(picture), Prep: \(prep_time), Cook: \(cook_time), Notes: \(notes)"
        
    }
    
    
}
