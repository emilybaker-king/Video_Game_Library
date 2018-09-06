//
//  Game.swift
//  Video_Game_Library
//
//  Created by Emily Baker-King on 9/4/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import Foundation

//This is the beta model that represents our Games that will be stored in the library.
class Game: NSObject, NSCoding {
    
    //This will store the title of the game
    var title: String
    
    //We are going to set this true by default since whenever we create a new game, we're going to assume it's checked in.
    var checkedIn = true
    
    //This is optional because if a game isn't checked out, it shouldn't have a due date.
    var dueDate: Date?
    
    
    //Since checkedIn is a default value, and dueDate is an optional, the only value we have to initialize is the title.
    init(title: String) {
        self.title = title
    }
    
    init(title: String, checkedIn: Bool, dueDate: Date?) {
        self.title = title
        self.checkedIn = checkedIn
        self.dueDate = dueDate
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(checkedIn, forKey: "checkedIn")
        aCoder.encode(dueDate, forKey: "dueDate")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: "title") as? String
        else {
            return nil
        }
        
        let checkedIn = aDecoder.decodeBool(forKey: "checkedIn")
        
        if let dueDate = aDecoder.decodeObject(forKey: "dueDate") as? Date {
            self.init(title: title, checkedIn: checkedIn, dueDate: dueDate)
        } else {
            self.init(title: title, checkedIn: checkedIn, dueDate: nil)
        }
    }
}










