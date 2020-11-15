//
//  ItemStore.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit
class PokemonStore {
    var allPokemon = [Pokemon]()
    
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
    
    
    @discardableResult func createPokemon() -> Pokemon {
        let newPokemon = Pokemon(random: true)
        allPokemon.append(newPokemon)
        return newPokemon
    }
}
