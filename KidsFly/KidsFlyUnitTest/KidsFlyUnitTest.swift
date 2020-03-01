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
        
        travelerController.registerNewUser(username: "testemail20@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testLogIn() {
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        
        travelerController.signIn(username: "testemail20@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    
//    func testWelcomeMessage() {
//        let expectation = self.expectation(description: "Getting welcome message")
//
//        travelerController.getUserWelcomeNotification(uId: 4, uToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWJqZWN0IjoidGhpc3VzZXIiLCJpZCI6NCwidXNlcm5hbWUiOiJ0ZXN0ZW1haWwyMEBnbWFpbC5jb20iLCJpYXQiOjE1ODMwOTI1MjUsImV4cCI6MTU4MzA5NjEyNX0.gItmXXwKqYBlM504seIjIgVT0lABcKUv8momoV68ZSk") { (error) in
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 30, handler: nil)
//    }
    
    func testGetAllUsers() {
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        let expectation2 = self.expectation(description: "Attempting to get all users")
        
        travelerController.signIn(username: "testemail20@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
            
            if let token = self.travelerController.token {
                print(token)
                self.travelerController.getListOfAllTravellers(token: "\(token)") { (error) in
                XCTAssertNil(error)
                expectation2.fulfill()
            }
        }
    }
    self.waitForExpectations(timeout: 10, handler: nil)
}



}
