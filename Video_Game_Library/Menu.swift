//
//  Menu.swift
//  Video_Game_Library
//
//  Created by Emily Baker-King on 8/30/18.
//  Copyright © 2018 Emily Baker-King. All rights reserved.
//

import Foundation

class Menu {
        
    var shouldQuit = false
    let library = Library()
    
    func go() {
        help()
        
        repeat {
            
            var input = getInput()
            
            while validateInput(input) == false {
                print("Invalid input")
                input = getInput()
            }
            
            handleInput(input)
            
            
        } while !shouldQuit
    }
    
    func help() {
        print("""
            Menu
            1 Add Game
            2 Remove Game
            3 List Available Games
            4 Check Out Game
            5 Check In Game
            6 List Checked Out Games
            7 Help
            8 Quit

            """)
    }
    
    func handleInput(_ input: String) {
        switch input {
        case "1":
            library.addGame()
            help()
        case "2":
            library.removeGame()
            help()
        case "3":
            library.listAvailableGames()
            //library.saveGames()
            help()
        case "4":
            library.checkGameOut()
            help()
        case "5":
            library.checkGameIn()
            help()
        case "6":
            library.listUnavailableGames()
            help()
        case "7":
            help()
        case "8":
            quit()
        default:
            break
        }
    }
    
    func quit() {
        shouldQuit = true
        print("Thanks for using the video game library")
    }
    
    func validateInput (_ input: String) -> Bool {
        let menuOptions = Array(1...8)
        
        guard let number = Int(input) else { return false }
        
        return menuOptions.contains(number)
    }
    
    func getInput () -> String {
        var input: String? = nil
        repeat {
            let line = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if line != "" {
                input = line
            } else {
                print("Invalid input")
            }
        } while input == nil
        
        return input!
    }
}
















