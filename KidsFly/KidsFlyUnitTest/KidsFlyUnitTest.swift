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
        
        travelerController.registerNewUser(username: "testemail19@gmail.com", password: "PASSWORD123") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
    
    
    func testLogIn() {
        
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        
        
        travelerController.signIn(username: "testemail19@gmail.com", password: "PASSWORD123") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }

    
    func testWelcomeMessage() {
    
        let expectation = self.expectation(description: "Getting welcome message")
        
        travelerController.getUserWelcomeNotification(uId: 5, uToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWJqZWN0IjoidGhpc3VzZXIiLCJpZCI6NSwidXNlcm5hbWUiOiJ0ZXN0ZW1haWwxOUBnbWFpbC5jb20iLCJpYXQiOjE1ODMwMjEwODcsImV4cCI6MTU4MzAyNDY4N30.JSumb0j_aUgriIZFkxxJiKRPydLXiKlarjojYLM48hk") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30, handler: nil)
        
        
    }
    
}
