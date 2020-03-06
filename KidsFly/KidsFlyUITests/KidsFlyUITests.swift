//
//  KidsFlyUITests.swift
//  KidsFlyUITests
//
//  Created by Enayatullah Naseri on 3/4/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import XCTest

class KidsFlyUITests: XCTestCase {

    private var app: XCUIApplication {
        return XCUIApplication()
    }
    
    func testSignUpTest() {
//        XCUIApplication().launch()
        let app = XCUIApplication()
        app.launch()
        
        let signUpButton = XCUIApplication().buttons["Sign Up"]
        signUpButton.tap()
        
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("Email@test.com")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        //        passwordField.typeText("test1234")
        
        signUpButton.tap()
        
    }
    
    func testSignIn() {
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Sign In"].tap()
        
        let emailField = app.textFields["Email"]
            emailField.tap()
        emailField.typeText("Email@test.com")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
//        passwordField.typeText("test1234")
//        testPasswrodText()
        
        
        app.buttons["Sing In"].tap()
        
        
    }
    
    
    func testSignOut() {
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Sign In"].tap()
        
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("Email@test.com")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        //        passwordField.typeText("test1234")
        
        app.buttons["Sing In"].tap()
        app.navigationBars["KidsFly.PrivateKidsFlyView"].buttons["Sign Out"].tap()
        
        
    }
    
    func testQuickCheckIn() {
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Sign In"].tap()
        
        let emailField = app.textFields["Email"]
        emailField.tap()
        emailField.typeText("Email@test.com")
        
        let passwordField = app.secureTextFields["Password"]
        passwordField.tap()
        //        passwordField.typeText("test1234")
        
        app.buttons["Sing In"].tap()
        app.buttons["Quick Check In"].tap()
        
        let app2 = app
        app2/*@START_MENU_TOKEN@*/.buttons["🔵 Blue"]/*[[".segmentedControls.buttons[\"🔵 Blue\"]",".buttons[\"🔵 Blue\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2/*@START_MENU_TOKEN@*/.buttons["🚐 Van"]/*[[".segmentedControls.buttons[\"🚐 Van\"]",".buttons[\"🚐 Van\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Done"].tap()
        app.buttons["Ok"].tap()
        app.navigationBars["KidsFly.PrivateKidsFlyView"].buttons["Sign Out"].tap()
        
        
    }
    
    func firstNameAccount() {
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.typeText("Firstname")
    }
    
    func lastNameAccount() {
        let lastNameTextField = app.textFields["TextFieldLastName"]
        lastNameTextField.tap()
        testLastnameTyping()
//        lastNameTextField.typeText("Lastname")
    }
    
    func addressAccount() {
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("12345 Address")
    }
    
    func cityAccount() {
        let cityTextField = app.textFields["City"]
        cityTextField.tap()
        cityTextField.typeText("city")
    }
    
    func stateAccount() {
        
       let stateTextField = app.textFields["State"]
        stateTextField.tap()
        stateTextField.typeText("OR")
        
    }
    
    func zipcodeAccount () {
        let zipCodeTextField = app.textFields["Zip Code"]
        zipCodeTextField.tap()
        zipCodeTextField.typeText("12345")
    }
    
    
    func testAccountUpdate() {
        
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Sign In"].tap()
        app.buttons["Sing In"].tap()
        app.buttons["Account"].tap()
        
        firstNameAccount()
        
        lastNameAccount()

        addressAccount()
        
        cityAccount()
        
        stateAccount()
        
        zipcodeAccount()
        
        
        app/*@START_MENU_TOKEN@*/.buttons["4"]/*[[".segmentedControls.buttons[\"4\"]",".buttons[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Create Profile"].buttons["Save"].tap()
        app.buttons["Ok"].tap()
        app.navigationBars["KidsFly.PrivateKidsFlyView"].buttons["Sign Out"].tap()
        
        
    }
    
    func testLastnameTyping() {
        
    
        
        let lKey = app.keys["l"]
        lKey.tap()
        
        let aKey = app.keys["a"]
        aKey.tap()
        
        let sKey = app.keys["s"]
        sKey.tap()
        
        let tKey = app.keys["t"]
        tKey.tap()
        
        
    }
    
    func testPasswrodText() {
        
        let pKey = app.keys["p"]
        pKey.tap()
        
        let aKey = app.keys["a"]
        aKey.tap()
        
        let sKey = app.keys["s"]
        sKey.tap()
        
        let sKey1 = app.keys["s"]
        sKey1.tap()
    }
    
    
}
