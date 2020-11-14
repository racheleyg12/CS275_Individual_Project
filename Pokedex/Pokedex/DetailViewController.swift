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
    
    var item: Item! {
        //TITLE ON NAV BAR IS THE NAME OF POKEMON
        didSet {
            navigationItem.title = item.name
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
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

        nameField.text = item.name
        typeField.text = item.type
        numberField.text = "\(item.number)"
        generationField.text = "\(item.generation)"
        genderField.text = item.gender
        heightField.text = "\(item.height)"
        weightField.text = "\(item.weight)"
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
    }
    
    //SAVE DATA WHEN SWITCHING SCREENS
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        // Clear first responder/ Getting rid of the keyboard
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.type = typeField.text ?? ""
        item.number = Int(numberField.text ?? "") ?? 0
        item.generation = Int(generationField.text ?? "") ?? 0
        item.gender = genderField.text ?? ""
        item.weight = Double(weightField.text ?? "") ?? 0
        item.height = Double(heightField.text ?? "") ?? 0
        
        //If I want to format number
//        if let valueText = valueField.text,
//            let value = numberFormatter.number(from: valueText) {
//            item.valueInDollars = value.intValue
//        } else {
//            item.valueInDollars = 0
//        }
        
    }
    
    //RETURNS KEYBOARD BACK BY RETURN BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    return true }
    
    //RETURNS KEYBOARD BACK BY TAPPING ANYWHERE
    @IBAction func backgroundTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
}

