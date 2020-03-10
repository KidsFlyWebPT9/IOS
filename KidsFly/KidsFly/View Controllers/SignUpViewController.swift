//
//  SignUpViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit
//import SwiftUI

class SignUpViewController: UIViewController {

    // Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var travelerController: TravelerController?
    
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
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleTextField(fullNameTextField)
        Utilities.styleTextField(emailText)
        Utilities.styleTextField(passwordText)
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let fullName = fullNameTextField.text, let username = emailText.text, let password = passwordText.text, let travelerController = travelerController else { return }
        
        let newUser = User(username: username, password: password, name: fullName)
        
        travelerController.registerNewUser(user: newUser, completion: { (error) in
            if let error = error {
                print("Error registering new user: \(error)")
                return
            } else {
                print("Successfully created user")
                travelerController.signIn(user: newUser) { (error) in
                    if let error = error {
                        print("Error signing newly created user in: \(error)")
                    } else {
                        //temp navigate
                        DispatchQueue.main.async {
                            guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
                            privateKidsFlyVC.travelerController = travelerController
                            self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
                            self.view.window?.makeKeyAndVisible()
                        }
                    }
                }
            }
        })
    }
        
        
    
    
}
