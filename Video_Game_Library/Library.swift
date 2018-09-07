//
//  Library.swift
//  Video_Game_Library
//
//  Created by Emily Baker-King on 9/4/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import Foundation

//This class will handle storing our array of games. It will also handle all of the interactions with that array.
class Library {
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url?.appendingPathComponent("Data").path)!
    }
    
    init() {
        if let games = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Game] {
            self.games = games
        }
    }
    
    //An array of Game objects
    private var games: [Game] = []
    
    
    
    //MARK:- Functions
    
    func addGame() {
        //When we make a game we need a title for the game.
        //We need to be able to get user input for the title.
        //We need to create a new game object using that title.
        //We need to add the new game to out gameArray.
        print("Password:")
        var input: String? = nil
        repeat {
            let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if line == "password" {
                input = line
            } else {
                print("Invalid password")
            }
        } while input == nil
        
        
        var gameTitle: String? = nil
        print("Please enter the game you want to add:")
        repeat {
            let line = readLine()!
            
            if line != "" {
                gameTitle = line
            } else {
                print("Invalid input")
            }
        } while gameTitle == nil
        
        var gameRating: String? = nil
        print("Please enter the rating of the game you added: E, T, or M")
        repeat {
            let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if line == "E" || line == "T" || line == "M" {
                gameRating = line
            } else {
                print("Invalid input")
                input = nil
            }
        } while gameRating == nil
        
        games.append(Game(title: gameTitle!, rating: gameRating!))
        NSKeyedArchiver.archiveRootObject(games, toFile: filePath)
        print("\n")
        print("The new library is:")
        for game in games {
            print("\(game.title) : \(game.rating)")
        }
    }
    
    
    func getAge() -> Int? {
        print("How old are you?")
        if let age = Int(readLine()!) {
            return age
        }
        else{
            return nil
        }
    }
    
    
    
    
    func removeGame() {
        for index in 0..<games.count {
            print("\(index). \(games[index].title)")
        }
        print("Please enter the index of the game you wish to remove:")
        var userInput = Int(readLine()!)
        while userInput == nil {
            print("Invalid input. Please enter a usable index")
            userInput = Int(readLine()!)
        }

        
        print("\n")
        games.remove(at: userInput!)
        NSKeyedArchiver.archiveRootObject(games, toFile: filePath)
        print("\n")
    }
    
    func listAvailableGames() {
        print("The availble games are:")
        for game in getAvailableGames() {
            print("\(game.title) : \(game.rating)")
        }
    }
    
    func listUnavailableGames() {
        print("The following games are unavailable:")
        for game in getUnavailableGames() {
            print("\(game.title) : \(game.rating)")
        }
        print("\n")
    }
    
    
    func getAvailableGames() -> [Game] {
        var availableGames = [Game]()
        
        for game in games {
            if game.checkedIn {
                availableGames.append(game)
            }
        }
        return availableGames
    }
    
    func checkGameOut() {
        let availableGames = getAvailableGames()
        
        // New array for games in rating.
        var gamesInRating = [Game]()
        
        //////
        
        guard let age = getAge() else {
            print("You didn't put in an age.")
            return
        }
        
        for game in availableGames {
            if age >= 18 {
                gamesInRating.append(game)
            } else if age >= 13 {
                if game.rating != "M" {
                    gamesInRating.append(game)
                }
            } else {
                if game.rating != "T" && game.rating != "M" {
                    gamesInRating.append(game)
                }
            }
        }
        
        for (n, game) in gamesInRating.enumerated() {
            print("\(n). \(game.title)")
        }
        
        //////
        print("What game do you want to check out?")
        
        print("Please enter the number of the game you wish to check out:")
        
        var index: Int? = nil
        
        repeat {
            var userInput = Int(readLine()!)
            
            while userInput == nil {
                print("Invalid input. Please enter a valid number on the list.")
                userInput = Int(readLine()!)
            }
            
            if userInput! >= 0 && userInput! < gamesInRating.count {
                index = userInput!
            } else {
                print("Invalid input, please type a number on the list.")
            }
        } while index == nil
        
        let game = gamesInRating[index!]
        
        game.checkedIn = false
        
        NSKeyedArchiver.archiveRootObject(games, toFile: filePath)
        print("\n You checked out: \(game.title)\n")
        
        let currentCalendar = Calendar.current
        let dueDate = currentCalendar.date(byAdding: .day, value: 14, to: Date())
        
        game.dueDate = dueDate
        
        if let dueDate = dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy hh:mma"
            print("The game is due by \(dateFormatter.string(from: dueDate)) \n")
        }
    }
    
    func getUnavailableGames() -> [Game] {
        var unavailableGames = [Game]()
        
        for game in games {
            if !game.checkedIn {
                unavailableGames.append(game)
            }
        }
        return unavailableGames
    }
    
    func checkGameIn() {
        let unavailableGames = getUnavailableGames()
        
        print("Which game would you like to check in?")
        
        for index in 0..<unavailableGames.count {
            
            print("\(index). \(unavailableGames[index].title)")
        }
        
        print("Please enter the number of the game you wish to check in:")
        
        var index: Int? = nil
        
        repeat {
            var userInput = Int(readLine()!)
            
            while userInput == nil {
                print("Invalid input. Please enter a number on the list.")
                userInput = Int(readLine()!)
            }
            
            if userInput! >= 0 && userInput! < unavailableGames.count {
                index = userInput!
            } else {
                print("Invalid input, please type a number on the list.")
            }
        } while index == nil
        
        unavailableGames[index!].checkedIn = true
        NSKeyedArchiver.archiveRootObject(games, toFile: filePath)
        unavailableGames[index!].dueDate = nil
        print("Thank you for checking in \(unavailableGames[index!].title) \n")
    }
}












