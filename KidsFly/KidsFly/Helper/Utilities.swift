//
//  Utilities.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class Utilities {
    
    static func styleTextField(_ textfield: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 6, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48 / 255, green: 177 / 255, blue: 191 / 255, alpha: 1).cgColor
        textfield.borderStyle = .none
        textfield.layer.addSublayer(bottomLine)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        button.backgroundColor = UIColor.init(red: 48 / 255, green: 177 / 255, blue: 191 / 255, alpha: 1)
        button.layer.cornerRadius = 10.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.init(red: 48 / 255, green: 177 / 255, blue: 191 / 255, alpha: 1).cgColor
        button.layer.cornerRadius = 10.0
        button.setTitleColor(UIColor.init(red: 48 / 255, green: 177 / 255, blue: 191 / 255, alpha: 1), for: .normal)
    }
    
}
