//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Rachel Goldman on 11/14/20.
//  Copyright © 2020 Rachel Goldman. All rights reserved.
//
import UIKit
class DetailViewController: UIViewController {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var generationField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var heightField: UITextField!
    @IBOutlet var weightField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    var item: Item!
    
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
}

