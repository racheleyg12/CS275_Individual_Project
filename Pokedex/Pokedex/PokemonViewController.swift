//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit

var loopThur = 0

class Pokemon: NSObject {
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
            let names = ["Zigzagoon", "Vulpix", "Poliwag", "Bulbasaur", "Rookidee",  "Timburr", "Nidoran", "Pachirisu", "Sandshrew", "Rockruff", "Espeon", "Snorunt", "Caterpie", "Misdreavus", "Meltan", "Axew", "Umbreon", "Togepi"]
            let types = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy"]
            let numbers = [263, 037, 060, 001, 821, 532, 032, 417, 027, 744, 196, 361, 010, 200, 808, 610, 197, 175]
            let generations = [3, 1, 1, 1, 8, 5, 1, 4, 1, 7, 2, 3, 1, 2, 7, 4, 2, 2]
            
            //let idx = arc4random_uniform(UInt32(names.count))
            
            if (loopThur == 18) {
                print("what?")
                loopThur = 0
            }
            let idx = loopThur
            let randomName = names[Int(idx)]
            let randomType = types[Int(idx)]
            let randomNumber = numbers[Int(idx)]
            let randomGen = generations[Int(idx)]
            
            loopThur += 1
            
            self.init(name: randomName, type: randomType, number: randomNumber, generation: randomGen, gender: "none", weight: 0.5, height: 0.5)
        } else {
            self.init(name: "", type: "", number: 0, generation: 1, gender: "none", weight: 0.5, height: 0.5) }
        }

}

class PokemonViewController: UITableViewController {
    
    var pokemonStore: PokemonStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        // Create a new item and add it to the store
        let newPokemon = pokemonStore.createPokemon()
        
        // Figure out where that item is in the array
        if let index = pokemonStore.allPokemon.firstIndex(of: newPokemon) {
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
    
    //Override the init(coder:) method to set the left bar button item - EDIT
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
        return pokemonStore.allPokemon.count
        //return 2
        
    }
    
    //Reusing Cells
    //Specifying a Row for the UITableView aka UITableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell
        let pokemon = pokemonStore.allPokemon[indexPath.row]
        //Use PokemonCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell",
        for: indexPath) as! PokemonCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // What will appear in on the tableview
        cell.nameLabel?.text = pokemon.name
        cell.numberLabel?.text = "\(pokemon.number)"
        cell.typeLabel?.text = pokemon.type
        
        //"Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy"
        //Color of the Type
        switch pokemon.type {
        case "Normal":
            //rgb(166,168,116)
            cell.typeLabel?.textColor = UIColor.init(red: 0.65, green: 0.6588, blue: 0.4549, alpha: 1.0)
        case "Fire":
            //rgb(249,88,10)
            cell.typeLabel?.textColor = UIColor.init(red: 0.9765, green: 0.345, blue: 0.0392, alpha: 1.0)
        case "Grass":
            //rgb(97,186,84)
            cell.typeLabel?.textColor = UIColor.init(red: 0.38, green: 0.8294, blue: 0.3294, alpha: 1.0)
        case "Water":
            //rgb(84,156,217)
            cell.typeLabel?.textColor = UIColor.init(red: 0.3294, green: 0.6118, blue: 0.85, alpha: 1.0)
        case "Flying":
            //rgb(143,168,221)
            cell.typeLabel?.textColor = UIColor.init(red: 0.56, green: 0.6588, blue: 0.8667, alpha: 1.0)
        case "Fighting":
            //rgb(206,64,105)
            cell.typeLabel?.textColor = UIColor.init(red: 0.8078, green: 0.25, blue: 0.4118, alpha: 1.0)
        case "Poison":
            cell.typeLabel?.textColor = UIColor.init(red: 0.647, green: 0.4, blue: 0.776, alpha: 1.0)
        case "Electric":
            //Visible Yellow
            cell.typeLabel?.textColor = UIColor.init(red: 1.0, green: 0.9, blue: 0.0, alpha: 1.0)
        case "Ground":
            //rgb(217,120,69)
            cell.typeLabel?.textColor = UIColor.init(red: 0.85, green: 0.47, blue: 0.27, alpha: 1.0)
        case "Rock":
            cell.typeLabel?.textColor = UIColor.brown
        case "Psychic":
            //rgb(249,111,117)
            cell.typeLabel?.textColor = UIColor.init(red: 0.9765, green: 0.4353, blue: 0.4588, alpha: 1.0)
        case "Ice":
            //rgb(116,206,192)
            cell.typeLabel?.textColor = UIColor.init(red: 0.4549, green: 0.8078, blue: 0.7529, alpha: 1.0)
        case "Bug":
            //rgb(149,196,46)
            cell.typeLabel?.textColor = UIColor.init(red: 0.5843, green: 0.7686, blue: 0.18, alpha: 1.0)
        case "Ghost":
            //rgb(84,105,173)
            cell.typeLabel?.textColor = UIColor.init(red: 0.3294, green: 0.4118, blue: 0.6784, alpha: 1.0)
        case "Steel":
            //rgb(83,136,156)
            cell.typeLabel?.textColor = UIColor.init(red: 0.3255, green: 0.5333, blue: 0.6118, alpha: 1.0)
        case "Dragon":
            //rgb(9,105,193)
            cell.typeLabel?.textColor = UIColor.init(red: 0.0353, green: 0.4118, blue: 0.7569, alpha: 1.0)
        case "Dark":
            //rgb(90,83,102)
            cell.typeLabel?.textColor = UIColor.init(red: 0.3529, green: 0.3216, blue: 0.4, alpha: 1.0)
        case "Fairy":
            //rgb(237,140,229)
            cell.typeLabel?.textColor = UIColor.init(red: 0.9294, green: 0.549, blue: 0.898, alpha: 1.0)
        default:
            cell.typeLabel?.textColor = UIColor.black
        }
       
        return cell
        
    }
    
    //In order to delete rows
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let pokemon = pokemonStore.allPokemon[indexPath.row]
            
            //Ask the user to confirm or cancel the deletion of an item.
            let title = "Delete \(pokemon.name)?"
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
                self.pokemonStore.removePokemon(pokemon)
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
        
    
    //In order to move rows
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        pokemonStore.movePokemon(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    //SEGUE TO DETAILVIEW - CONNECTING TO DETAIL VIEW
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showPokemonDetails"?:
        // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the item associated with this row and pass it along
                let pokemon = pokemonStore.allPokemon[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.pokemon = pokemon
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