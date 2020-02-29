//
//  KidsFlyUnitTest.swift
//  KidsFlyUnitTest
//
//  Created by Dillon P on 2/28/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import XCTest
@testable import KidsFly

class KidsFlyUnitTest: XCTestCase {
    
    let travelerController = TravelerController()

    func testCreateNewUser() {
        
        let expectation = self.expectation(description: "Waiting to create user")
        
        travelerController.registerNewUser(username: "testemail3@gmail.com", password: "PASSWORD123") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
    
    func testLogIn() {
        
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        
        
        travelerController.signIn(username: "testemail3@gmail.com", password: "PASSWORD123") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
    }
    
}
