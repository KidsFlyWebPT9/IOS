//
//  AccountViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 3/5/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var streetAdressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var numberOfKidsSeg: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
        func setupViews() {
            Utilities.styleTextField(firstNameTextField)
            Utilities.styleTextField(lastNameTextField)
            Utilities.styleTextField(streetAdressTextField)
            Utilities.styleTextField(cityTextField)
            Utilities.styleTextField(stateTextField)
            Utilities.styleTextField(zipcodeTextField)
            
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Save
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        self.presentKFAlertOnMainThread(title: "Thank you!", message: KFError.profileUpdated.rawValue, buttonTitle: "Ok")
        
        //temp navigate
        guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
        self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
        self.view.window?.makeKeyAndVisible()
        
    }
    

}
