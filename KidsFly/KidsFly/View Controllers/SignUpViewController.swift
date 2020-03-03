//
//  SignUpViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // Outlets
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
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
        Utilities.styleTextField(firstNameText)
        Utilities.styleTextField(lastNameText)
        Utilities.styleTextField(emailText)
        Utilities.styleTextField(passwordText)
        
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        // temp
        
        guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
        self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
        self.view.window?.makeKeyAndVisible()
    }
    
}
