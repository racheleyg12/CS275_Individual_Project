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
    
    //Initializer to add five random items.
    init() {
    for _ in 0..<5 {
            createItem()
        }
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



