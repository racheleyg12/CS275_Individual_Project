//
//  ItemStore.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit
class ItemStore {
    var allItems = [Item]()
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        // Remove item from array
        allItems.remove(at: fromIndex)
        // Insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    func filterItemsBy(_ price: Int = 50) -> [[Item]] {
        var filteredItems = [[Item](), [Item]()]
        for item in allItems {
            if item.valueInDollars > price {
                filteredItems[0].append(item)
            } else {
                filteredItems[1].append(item)
            }
        }
        return filteredItems
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
}



