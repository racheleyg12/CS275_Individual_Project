//
//  ItemsViewController.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit

class Item: NSObject {
    var name: String
    var type: String
    var number: Int
    var generation: Int
    var gender: String?
    var weight: Double
    var height: Double
    let dateCreated: Date
    
    init(name: String, type: String, number:Int, generation: Int, gender: String?, weight: Double, height: Double) {
        self.name = name
        self.type = type
        self.number = number
        self.generation = generation
        self.gender = gender
        self.weight = weight
        self.height = height
        self.dateCreated = Date()
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let names = ["Jigglypuff", "Caterpie", "Crobat", "Oddish", "Mudkip", "Espeon"]
            let types = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy"]
            
            var idx = arc4random_uniform(UInt32(names.count))
            let randomName = names[Int(idx)]
            
            idx = arc4random_uniform(UInt32(types.count))
            let randomType = types[Int(idx)]
            
            let randomNumber = Int(arc4random_uniform(100))
            let randomGen = Int(arc4random_uniform(8))
            
            self.init(name: randomName, type: randomType, number: randomNumber, generation: randomGen, gender: "none", weight: 0.5, height: 0.5)
        } else {
            self.init(name: "", type: "", number: 0, generation: 1, gender: "none", weight: 0.5, height: 0.5) }
        }

}

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic) }
    }
    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
        if isEditing {
            // Change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            // Turn off editing mode
            setEditing(false, animated: true)
        
        } else {
            // Change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            // Enter editing mode
            setEditing(true, animated: true)
        }
    }
    
    //Override the init(coder:) method to set the left bar button item - EDIT BUTTON
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }


//    func numberOfSectionsInTableView(_ tableView: UITableView) -> Int {
//        return 2
//    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
//        return "0"
//
//    }
    
    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
        //return 2
        
    }
    
    //Reusing Cells
    //Specifying a Row for the UITableView aka UITableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let item = itemStore.allItems[indexPath.row]
        //Use PokemonCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell",
        for: indexPath) as! PokemonCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // What will appear in on the tableview
        cell.nameLabel?.text = item.name
        cell.numberLabel?.text = "\(item.number)"
        cell.typeLabel?.text = item.type
        
        //Color of the Type
        switch item.type {
        case "Grass":
            cell.typeLabel?.textColor = UIColor.green
        case "Water":
            cell.typeLabel?.textColor = UIColor.blue
        case "Fire":
            cell.typeLabel?.textColor = UIColor.red
        case "Normal":
            cell.typeLabel?.textColor = UIColor.gray
        case "Poison":
            cell.typeLabel?.textColor = UIColor.purple
        case "Rock":
            cell.typeLabel?.textColor = UIColor.brown
        case "Electric":
            //Visible Yellow
             cell.typeLabel?.textColor = UIColor.init(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)

        default:
            cell.typeLabel?.textColor = UIColor.black
        }
       
        //cell.typeLabel?.textColor = UIColor.init(named: "yellow")
        
        //
        return cell
        
    }
    
    //In order to delete rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            //Ask the user to confirm or cancel the deletion of an item.
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            //Makes message
            let ac = UIAlertController(title: title, message: message,
            preferredStyle: .actionSheet)
            
            //Actions that the user can choose from
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive,
                                             handler: { (action) -> Void in
                // Remove the item from the store
                self.itemStore.removeItem(item)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
        
    
    //In order to move rows
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //SEGUE TO DETAILVIEW - CONNECTING TO DETAIL VIEW
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showPokemonDetails"?:
        // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
        }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    //RELOAD UITableView so the user can immediately see the changes FROM DETAIL VEIW
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //LAST MINUTE THINGS TO APPLY TO THE VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }

}


//override func viewDidLoad() {
//    super.viewDidLoad()
//    // Do any additional setup after loading the view.
//}
