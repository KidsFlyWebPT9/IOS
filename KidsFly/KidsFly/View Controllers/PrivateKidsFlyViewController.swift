//
//  PrivateKidsFlyViewController.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 3/2/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class PrivateKidsFlyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func signOutButtonTapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
