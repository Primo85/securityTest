//
//  PassViewController.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 06/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func save() {
        KeyChainMenager().commonString = textField.text ?? "nil w textField"
    }
    
    @IBAction func get() {
        textField.text = KeyChainMenager().commonString
    }
}
