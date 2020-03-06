//
//  KidsFlyUITests.swift
//  KidsFlyUITests
//
//  Created by Enayatullah Naseri on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import XCTest
@testable import KidsFly

class KidsFlyUITests: XCTestCase {

    
    func signUpTest() {
//        XCUIApplication().launch()
        let app = XCUIApplication()
        app.launch()
        
        let signUpButton = XCUIApplication().buttons["Sign Up"]
        signUpButton.tap()
        signUpButton.tap()
    }
}
