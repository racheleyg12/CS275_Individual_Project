//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/14/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var generationField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var heightField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    //To Pass data in
    var row: Int = 0;
    
    var pokemon : Pokemon! {
        //TITLE ON NAV BAR IS THE NAME OF POKEMON
        didSet {
            navigationItem.title = pokemon.name
        }
    }
    
    //May be format number like: 002 & 087
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    //LOAD VIEW
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        nameField.text = pokemon.name
        typeField.text = pokemon.type
        numberField.text = "\(pokemon.number)"
        generationField.text = "\(pokemon.generation)"
        genderField.text = pokemon.gender
        heightField.text = "\(pokemon.height)"
        weightField.text = "\(pokemon.weight)"
        dateLabel.text = dateFormatter.string(from: pokemon.dateCreated)
    }
    
    //SAVE DATA WHEN SWITCHING SCREENS
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        // Clear first responder/ Getting rid of the keyboard
        view.endEditing(true)
        
        // "Save" changes to item
        pokemon.name = nameField.text ?? ""
        pokemon.type = typeField.text ?? ""
        pokemon.number = Int(numberField.text ?? "") ?? 0
        pokemon.generation = Int(generationField.text ?? "") ?? 0
        pokemon.gender = genderField.text ?? ""
        pokemon.weight = Double(weightField.text ?? "") ?? 0
        pokemon.height = Double(heightField.text ?? "") ?? 0
            
    }
    
    //RETURNS KEYBOARD BACK BY RETURN BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    return true }
    
    //RETURNS KEYBOARD BACK BY TAPPING ANYWHERE
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    //TRASH BAR BUTTON
    @IBAction func deleteItem(_ sender: UIBarButtonItem) {
        //Deletes the Pokemon
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let pokemonStore = appDelegate.pokemonStore
        pokemonStore.removePokemon(pokemon)
        //Goes back to Pokemon View
        self.performSegue(withIdentifier: "unwindToPokemonViewController", sender: self)
    }
    

}

