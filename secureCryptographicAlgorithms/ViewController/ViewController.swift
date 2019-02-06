//
//  ViewController.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 04/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import UIKit
import Security

final class ViewController: UIViewController {
    
    @IBOutlet weak var enterTextField: UITextField!
    @IBOutlet weak var encryptedTextFld: UITextView!
    @IBOutlet weak var decryptedTextFld: UITextView!
    
    var statusCode: OSStatus?
    var publicKey: SecKey?
    var privateKey: SecKey?
    
    let algorithm: SecKeyAlgorithm = .rsaEncryptionOAEPSHA512
    
    var encriptedData: CFData? {
        didSet {
            guard let encriptedData = encriptedData else {
                encryptedTextFld.text = nil
                return
            }
            decryptPressed()
            let str = (encriptedData as Data).base64EncodedString()
            encryptedTextFld.text = str + "    \(str.count)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let publicKeyAttr: [NSObject: NSObject] =
            [kSecAttrIsPermanent: true as NSObject,
             kSecAttrApplicationTag: "someTag".data(using: String.Encoding.utf8)! as NSObject]
        let privateKeyAttr: [NSObject: NSObject] =
            [kSecAttrIsPermanent: true as NSObject,
             kSecAttrApplicationTag: "someTag".data(using: String.Encoding.utf8)! as NSObject]
        var keyPairAttr = [NSObject: NSObject]()
        keyPairAttr[kSecAttrKeyType] = kSecAttrKeyTypeRSA
        keyPairAttr[kSecAttrKeySizeInBits] = 3072 as NSObject
        keyPairAttr[kSecPublicKeyAttrs] = publicKeyAttr as NSObject
        keyPairAttr[kSecPrivateKeyAttrs] = privateKeyAttr as NSObject
        statusCode = SecKeyGeneratePair(keyPairAttr as CFDictionary, &publicKey, &privateKey)
        if statusCode == noErr && publicKey != nil && privateKey != nil {
            print("Key pair generated OK")
            print("Public Key: \(publicKey!)")
            if let cfdata = SecKeyCopyExternalRepresentation(publicKey!, &error) {
                let data:Data = cfdata as Data
                let b64Key = data.base64EncodedString()
                print(b64Key)
            }
            print("Private Key: \(privateKey!)")
            if let cfdata = SecKeyCopyExternalRepresentation(privateKey!, &error) {
                let data:Data = cfdata as Data
                let b64Key = data.base64EncodedString()
                print(b64Key)
            }
        } else {
            print("Error generating key pair: \(String(describing: statusCode))")
        }
        if let path = Bundle.main.path(forResource: "text", ofType: "txt") {
            if let data = try? Data.init(contentsOf: URL(fileURLWithPath: path)) {
                encriptedData = data as CFData
            } else {
                print("no data")
            }
        } else {
            print("no file")
        }
    }
    
    // CODE
    @IBAction func encryptPressed() {
        enterTextField.resignFirstResponder()
        guard let publicKey = globalKey else { return }
        guard let sampleText = enterTextField.text else { return }
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else { return }
        guard let plainTextData = sampleText.data(using: .utf8) else { return }
        guard let encriptedData = SecKeyCreateEncryptedData(publicKey,
                                                         algorithm,
                                                         plainTextData as CFData,
                                                         nil) else { return }
        self.encriptedData = encriptedData
    }
    
    
    // DECODE
    @IBAction func decryptPressed() {
        guard let privateKey = globalPrivateKey else { return }
        guard SecKeyIsAlgorithmSupported(privateKey, .decrypt, algorithm) else { return }
        guard let plainTextData = encriptedData else { return }
        guard let cipherText = SecKeyCreateDecryptedData(privateKey,
                                                         algorithm,
                                                         plainTextData as CFData,
                                                         &error) else {
                                                            print(error.debugDescription)
                                                            return
        }
        let str = String(data: cipherText as Data, encoding: .utf8) ?? "nil"
        decryptedTextFld.text = str + "    \(str.count)"
    }
    @IBAction func resetPressed() {
        enterTextField.text = nil
        encriptedData = nil
        decryptedTextFld.text = nil
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        encryptPressed()
        return true
    }
}
extension ViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return false
    }
}
