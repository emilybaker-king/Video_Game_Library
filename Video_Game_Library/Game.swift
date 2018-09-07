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
    
    var rating: String
   
    
    
    //Since checkedIn is a default value, and dueDate is an optional, the only value we have to initialize is the title.
    init(title: String, rating: String) {
        self.title = title
        self.rating = rating
    }
    
    init(title: String, checkedIn: Bool, dueDate: Date?, rating: String) {
        self.title = title
        self.checkedIn = checkedIn
        self.dueDate = dueDate
        self.rating = rating
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(checkedIn, forKey: "checkedIn")
        aCoder.encode(dueDate, forKey: "dueDate")
        aCoder.encode(rating, forKey: "rating")
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        
        guard let title = aDecoder.decodeObject(forKey: "title") as? String
        else {
            return nil
        }
        
        let checkedIn = aDecoder.decodeBool(forKey: "checkedIn")
        
        guard let rating = aDecoder.decodeObject(forKey: "rating") as? String
            else {
                return nil
        }
        
        if let dueDate = aDecoder.decodeObject(forKey: "dueDate") as? Date {
            self.init(title: title, checkedIn: checkedIn, dueDate: dueDate, rating: rating)
        } else {
            self.init(title: title, checkedIn: checkedIn, dueDate: nil, rating: rating)
        }
    }
}










