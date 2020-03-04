//
//  PrivateKidsFlyViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 3/2/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class PrivateKidsFlyViewController: UIViewController {

    // Outlets
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var upcomingTripButton: UIButton!
    @IBOutlet weak var newTripButton: UIButton!
    @IBOutlet weak var kidsButton: UIButton!
    @IBOutlet weak var quickCheckInButton: UIButton!
    
    // 🚙 Suv
    // 🚗 Sedan
    // 🚐 Van
    // 🚖 Taxi
    // 🚘 Wagon
    // 🔴 Red
    // ⚫️ Black
    // ⚪️ White
    // 🔵 Blue
    // 🟡 Yellow
    // 🌈 Other
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        Utilities.styleFilledButton(accountButton)
        Utilities.styleFilledButton(upcomingTripButton)
        Utilities.styleFilledButton(newTripButton)
        Utilities.styleFilledButton(kidsButton)
        Utilities.styleFilledButton(quickCheckInButton)
    }
    
// Sign out button 
    @IBAction func signOutButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
