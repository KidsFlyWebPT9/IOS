//
//  ViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var gifView: UIImageView!
    
    var travelerController = TravelerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        self.viewWillAppear(animated)
        gifView.loadGif(name: "giphy")
        setupViews() // load custom design
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SignUpSegue" {
            if let signUpVC = segue.destination as? SignUpViewController {
                signUpVC.travelerController = travelerController
            }
        } else if segue.identifier == "LogInSegue" {
            if let signInVC = segue.destination as? SignInViewController {
                signInVC.travelerController = travelerController
            }
        }
    }
    
    //MARK: - UI Set-Up
    // custom design - sign in and sign up
    func setupViews() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(signInButton)
        
    }

    //MARK: - Button Actions
    
    
    @IBAction func signUpButton(_ sender: Any) {
        self.performSegue(withIdentifier: "SignUpSegue", sender: self)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        self.performSegue(withIdentifier: "LogInSegue", sender: self)
    }
    

}

