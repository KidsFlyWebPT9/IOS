//
//  UIViewControllerExtention.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentKFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = KFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
}
