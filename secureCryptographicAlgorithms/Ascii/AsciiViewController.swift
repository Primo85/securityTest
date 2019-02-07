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
        data = inputTextField.text?.data(using: String.Encoding.ascii)
//        data = Data.init(base64Encoded: inputTextField.text ?? "")
        print(data)
    }
    
    var data: Data? {
        didSet {
            let stringOf01 = data?.reduce("") { $0 + $1.asBinay + " " }
            dataBinTextView.text = stringOf01
            let stringOfDec = data?.reduce("") { $0 + $1.asDec + " " }
            dataDecTextView.text = stringOfDec
        }
    }
    
    var dataStringOf01: String = "" {
        didSet {
            
        }
    }
}

extension UInt8 {
    var asBinay: String {
        var str = String(self, radix: 2)
        while str.count < 8 {
            str = "0" + str
        }
        return str
    }
    var asDec: String {
        return "\(self)"
    }
}
