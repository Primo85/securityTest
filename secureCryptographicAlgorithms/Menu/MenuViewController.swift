//
//  MenuViewController.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 06/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBAction private func goToASCII() {
        let vc = AsciiViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func goToKeys() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func goToPass() {
        let vc = PassViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
