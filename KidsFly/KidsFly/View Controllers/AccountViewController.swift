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
    // Number of kids not provided in backend but can use number of kids in the "special_needs" variable
    @IBOutlet weak var numberOfKidsSeg: UISegmentedControl!
    
    var airportID: Int?
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
        
        nameTextField.text = currentUser.name?.capitalized
        usernameTextField.text = currentUser.username.capitalized
        streetAdressTextField.text = currentUser.address?.capitalized
        
        guard let airportId = currentUser.airport_id else { return }
        let airportInt = Int(airportId)
        self.airportID = airportInt
        if let airportCode = flightController.getAirportCode(using: airportInt) {
            flightController.searchForAirport(airportName: airportCode) { (error) in
                if let error = error {
                    print("Error getting airport data: \(error)")
                    return
                }
                
                guard let airport = self.flightController.airport else { return }
                let airportNameString = "\(airport.name.capitalized) - \(airport.address.cityName.capitalized), \(airport.address.stateCode)"
                
                DispatchQueue.main.async {
                    self.homeAirportTextField.text = airportNameString
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
        guard let travelerController = travelerController,
            let airportID = airportID,
            let name = nameTextField.text,
            let address = streetAdressTextField.text,
            var userToEdit = travelerController.currentUser else { return }
        

        if name.count != 0 {
            userToEdit.name = name
        }
        if address.count != 0 {
            userToEdit.address = address
        }
        
        let airportInt = Int16(airportID)
        userToEdit.airport_id = airportInt
        
        travelerController.updateUser(user: userToEdit) { (error) in
            if let error = error {
                print("Error updating user: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.presentKFAlertOnMainThread(title: "Thank you!", message: KFError.profileUpdated.rawValue, buttonTitle: "Ok")
                self.navigationController?.popViewController(animated: true)
            }
        }
//        //temp navigate
//        guard let privateKidsFlyVC = self.storyboard?.instantiateViewController(withIdentifier: "PrivateKidsFlyVC") as? PrivateKidsFlyViewController else { return }
//        self.navigationController?.pushViewController(privateKidsFlyVC, animated: true)
//        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func searchForAirportTapped(_ sender: Any) {
        guard let searchTerm = homeAirportTextField.text, !searchTerm.isEmpty else { return }
        
        flightController.searchForAirport(airportName: searchTerm) { (error) in
            self.airportID = self.flightController.airportID
            guard let airport = self.flightController.airport else { return }
            let airportNameString = "\(airport.name.capitalized) - \(airport.address.cityName.capitalized), \(airport.address.stateCode)"
            
            DispatchQueue.main.async {
                self.homeAirportTextField.text = airportNameString
            }
        }
        
    }
    
}
