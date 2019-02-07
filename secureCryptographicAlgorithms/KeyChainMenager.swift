//
//  KeyChainMenager.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 06/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import Foundation

final class KeyChainMenager {
    var defaults: UserDefaults? = UserDefaults(suiteName: "group.secure.test.primo")
    
    var commonString: String {
        get {
            return defaults?.object(forKey: "commonString") as? String ?? "nil"
        }
        set {
            defaults?.set(newValue, forKey: "commonString")
            defaults?.synchronize()
        }
    }
}

