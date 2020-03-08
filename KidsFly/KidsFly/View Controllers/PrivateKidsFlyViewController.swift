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
    @IBOutlet weak var nameLabel: UILabel!
    
    var travelerController: TravelerController?
    var tripController = TripController()
    
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
        guard let travelerController = travelerController else { return }
        travelerController.getUserInfo { (error) in
            if let error = error {
                print("Couldn't load current user data: \(error)")
                return
            }
            print("Loaded current user data")
            return
        }
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "EditAccountInfo" {
            if let editAccountVC = segue.destination as? AccountViewController, let travelerController = travelerController {
                editAccountVC.travelerController = travelerController
            }
        } else {
            // if segue identifier is something else do it here
        }
        
        
    }
    
    func setupViews() {
        Utilities.styleFilledButton(accountButton)
        Utilities.styleFilledButton(upcomingTripButton)
        Utilities.styleFilledButton(newTripButton)
        Utilities.styleFilledButton(kidsButton)
        Utilities.styleHollowButton(quickCheckInButton)
    }
    
// Sign out button 
    @IBAction func signOutButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func accountButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "EditAccountInfo", sender: self)
    }
    
    
    
    
}
