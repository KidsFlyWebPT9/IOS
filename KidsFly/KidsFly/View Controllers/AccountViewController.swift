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
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var streetAdressTextField: UITextField!
    @IBOutlet weak var homeAirportTextField: UITextField!
    @IBOutlet weak var numberOfKidsSeg: UISegmentedControl!
    
    var travelerController: TravelerController?
    var flightController = FlightController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(streetAdressTextField)
        Utilities.styleTextField(homeAirportTextField)
        
        guard let travelerController = travelerController else { return }
        
        guard let currentUser = travelerController.currentUser else { return }
        
        nameTextField.text = currentUser.name
        usernameTextField.text = currentUser.username
        streetAdressTextField.text = currentUser.address
        
        guard let airportId = currentUser.airport_id else { return }
        let airportInt = Int(airportId)
        if let airportCode = flightController.getAirportCode(using: airportInt) {
            flightController.searchForAirport(airportName: airportCode) { (error) in
                if let error = error {
                    print("Error getting airport data: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.homeAirportTextField.text = self.flightController.airport?.name
                }
            }
        }
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
        self.navigationController?.popViewController(animated: true)
//        //temp navigate
//        guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
//        self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
//        self.view.window?.makeKeyAndVisible()
    }
    

}
