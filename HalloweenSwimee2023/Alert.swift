//
//  Alert.swift
//  HalloweenSwimee2023
//
//  Created by 保坂篤志 on 2023/10/29.
//

import UIKit

struct Alert {
    
    func showAlert(title: String, message: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true)
    }
}
