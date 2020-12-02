//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/1/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit

var loopThur = 0

class Pokemon: NSObject, NSCoding {
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
            let names:[String] = ["Zigzagoon", "Vulpix", "Poliwag", "Bulbasaur", "Rookidee",  "Timburr", "Nidoran", "Pachirisu", "Sandshrew", "Rockruff", "Espeon", "Snorunt", "Caterpie", "Misdreavus", "Meltan", "Axew", "Umbreon", "Togepi"]
            let types:[String] = ["Normal", "Fire", "Water", "Grass", "Flying", "Fighting", "Poison", "Electric", "Ground", "Rock", "Psychic", "Ice", "Bug", "Ghost", "Steel", "Dragon", "Dark", "Fairy"]
            let numbers:[Int] = [263, 037, 060, 001, 821, 532, 032, 417, 027, 744, 196, 361, 010, 200, 808, 610, 197, 175]
            let generations:[Int] = [3, 1, 1, 1, 8, 5, 1, 4, 1, 7, 2, 3, 1, 2, 7, 4, 2, 2]
            
            //Loops thur 18 different types of pokemon
            if (loopThur == 18) {
                loopThur = 0
            }
            let idx = loopThur
            let randomName:String = names[Int(idx)]
            let randomType:String = types[Int(idx)]
            let randomNumber:Int = numbers[Int(idx)]
            let randomGen:Int = generations[Int(idx)]
            
            loopThur += 1
            
            self.init(name: randomName, type: randomType, number: randomNumber, generation: randomGen, gender: "none", weight: 0.5, height: 0.5)
        } else {
            let num: Int = 0
            self.init(name: "Name", type: "Type", number: num, generation: 0, gender: "none", weight: 0.5, height: 0.5) }
        }
    
    //Required to implement Archiving (1)
    //NSCoder writes out a stream of data in key-value pairs to be stored in the filesystem
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(number, forKey: "number")
        aCoder.encode(generation, forKey: "generation")
        aCoder.encode(gender, forKey: "gender")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(height, forKey: "height")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        print("Put data in key-value pairs to be stored")
    }
    //Required to implement Archiving (2)
    //Objects being loaded from an archive are sent the message init(coder:)
    //added convenience
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        type = aDecoder.decodeObject(forKey: "type") as! String
        number = aDecoder.decodeInteger(forKey: "number")
        generation = aDecoder.decodeInteger(forKey: "generation")
        gender = aDecoder.decodeObject(forKey: "gender") as! String?
        weight = aDecoder.decodeDouble(forKey: "weight")
        height = aDecoder.decodeDouble(forKey: "height")
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
        super.init()
        print("Objects loaded from an archive")
    }
}

class PokemonViewController: UITableViewController {
    
    var pokemonStore: PokemonStore!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        //Functionality is now to a segue
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

    
    //numberOfRowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pokemonStore.allPokemon.count
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
        
        cell.typeLabel?.text = pokemon.type
        // Format Number
        if(pokemon.number < 10){
            cell.numberLabel?.text = "00\(pokemon.number)"
        } else if (9 < pokemon.number && pokemon.number < 100){
            cell.numberLabel?.text = "0\(pokemon.number)"
        } else {
            cell.numberLabel?.text = "\(pokemon.number)"
        }
        
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
            
            //ACTUALLY REMOVING THE ITEM/POKEMON
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
    
    //SEGUE TO DETAILVIEW - CONNECTING TO DETAIL VIEW -ON POKEMONCELL & ADD BUTTON
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showPokemonDetailsFromCell"?:
        // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let pokemon = pokemonStore.allPokemon[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.pokemon = pokemon
                //PASS IN INDEX
                detailViewController.row = row
                //print("Tapped on a cell")
            }
        case "showPokemonDetailsFromAdd"?:
            // Create a new Pokemon and add it to the Pokedex
            let newPokemon = pokemonStore.createPokemon()
            //print("Created a new Pokemon and add it to the Pokedex")
            
            // Figure out where that item is in the array
            if let index = pokemonStore.allPokemon.firstIndex(of: newPokemon) {
                let indexPath = IndexPath(row: index, section: 0)
                // Insert this new row into the table
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
            //INFO GIVEN TO DETAILVIEW
            // Pokemon are added to the last row
            let index = pokemonStore.allPokemon.count - 1
            let pokemon = pokemonStore.allPokemon[index]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.pokemon = pokemon
            //PASS IN INDEX
            detailViewController.row = index
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        //Excutes self.performSegue (withIdentifier: "unwindToPokemonViewController", sender: self)
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

//For debugging constraint errors
extension NSLayoutConstraint {
    override public var description: String {
        let id = identifier ?? ""
        return "id: \(id), constant: \(constant)" //you may print whatever you want here
    }
}
