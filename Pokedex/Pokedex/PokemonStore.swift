//
//  ItemStore.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit
class PokemonStore {
    //Where all the Pokemon are stored
    var allPokemon = [Pokemon]()
    //PokemonStore needs to construct a URL to this file, to save to it
    let itemArchiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        print("Loaded URL")
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    //Saves every single Pokemon in allPokemon to the itemArchiveURL
//    func saveChanges() -> Bool {
//        print("Saving items to: \(itemArchiveURL.path)")
//        return NSKeyedArchiver.archiveRootObject(allPokemon, toFile: itemArchiveURL.path)
//    }
    func saveChanges() -> Bool {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: allPokemon, requiringSecureCoding: false)
                try data.write(to: itemArchiveURL)
                print("Saved files")
                return true
            } catch {
                print("Did NOT Saved files")
                return false
        }
    }
    //Load files. To load instances of Item when the application launches, you will use the class NSKeyedUnarchiver when the ItemStore is created.
//    init() {
//        if let archivedItems =
//            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Pokemon] {
//                allPokemon = archivedItems
//        }
//    }
    init() {
        do {
            let data = try Data(contentsOf: itemArchiveURL)
            if let archivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Pokemon] {
                    allPokemon = archivedData
                }
            print("Loaded files")
        } catch {
            allPokemon = []
            print("Did NOT loaded files")
        }
    }

    
    func removePokemon(_ pokemon: Pokemon) {
        if let index = allPokemon.firstIndex(of: pokemon) {
            allPokemon.remove(at: index)
        }
    }
    
    func movePokemon(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can reinsert it
        let movedPokemon = allPokemon[fromIndex]
        // Remove item from array
        allPokemon.remove(at: fromIndex)
        // Insert item in array at new location
        allPokemon.insert(movedPokemon, at: toIndex)
    }
    
    //CREATE POKEMON
    @discardableResult func createPokemon() -> Pokemon {
        //CHANGE TO NO PARAMS IF NEED BE
        let newPokemon = Pokemon(random: true)
        allPokemon.append(newPokemon)
        return newPokemon
    }
    
    func printPokemon(){
        for Pokemon in allPokemon{
            print(Pokemon.name)
        }
    }
}
