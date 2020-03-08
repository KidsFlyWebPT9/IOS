//
//  SignInViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    // Outlets
    @IBOutlet weak var emailSItext: UITextField!
    @IBOutlet weak var paswordSItext: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var travelerController: TravelerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    
    func setupViews() {
        Utilities.styleHollowButton(signInButton)
        Utilities.styleTextField(emailSItext)
        Utilities.styleTextField(paswordSItext)
        
    }
    
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        //temp navigate
        guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
        self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
        self.view.window?.makeKeyAndVisible()

    }
    
}
