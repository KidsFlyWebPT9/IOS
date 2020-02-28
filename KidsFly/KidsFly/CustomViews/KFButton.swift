//
//  DJButton.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation
import UIKit

class KFButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
        
    }
    
    private func configure() {
        
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
}
