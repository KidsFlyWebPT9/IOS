//
//  QuickCheckInViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class QuickCheckInViewController: UIViewController {

    // Outlets
    @IBOutlet weak var carSegment: UISegmentedControl!
    @IBOutlet weak var colorSegment: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    
    
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
        Utilities.styleHollowButton(doneButton)
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        self.presentKFAlertOnMainThread(title: "Thank you!", message: KFError.doneTraveling.rawValue, buttonTitle: "Ok")
        
        //temp navigate
        navigationController?.popViewController(animated: true)
    }
    

}
