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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupViews() {
        Utilities.styleHollowButton(signInButton)
        Utilities.styleTextField(emailSItext)
        Utilities.styleTextField(paswordSItext)
        
    }
    
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
    }
    
}
