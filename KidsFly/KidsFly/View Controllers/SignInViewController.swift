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
        guard let username = emailSItext.text, let password = paswordSItext.text, let travelerController = travelerController else { return }
        
        let user = User(username: username, password: password)
        
        travelerController.signIn(user: user) { (error) in
            if let error = error {
                print("Error signing user in: \(error)")
            } else {
                DispatchQueue.main.async {
                    //temp navigate
                    guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
                    privateKidsFlyVC.travelerController = travelerController
                    self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
    
}
