//
//  AsciiViewController.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 06/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import UIKit

class AsciiViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var dataBinTextView: UITextView!
    @IBOutlet weak var dataDecTextView: UITextView!
    
    @IBAction func getData() {
//        data = inputTextField.text?.data(using: String.Encoding.ascii)
        data = Data.init(base64Encoded: inputTextField.text ?? "")
        print(data)
    }
    
    var data: Data? {
        didSet {
            let stringOf01 = data?.reduce("") { (acc, byte) -> String in
                acc + String(byte, radix: 2) + " "
            }
            dataBinTextView.text = stringOf01
            let stringOfDec = data?.reduce("") { (acc, byte) -> String in
                acc + String(byte) + " "
            }
            dataDecTextView.text = stringOfDec
        }
    }
}
