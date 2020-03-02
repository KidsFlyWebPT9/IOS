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
    let flightController = FlightController()

    func testCreateNewUser() {
        let expectation = self.expectation(description: "Waiting to create user")
        
        travelerController.registerNewUser(username: "testemail25@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testLogIn() {
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        
        travelerController.signIn(username: "testemail25@gmail.com", password: "PASSWORD123") { (error) in
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
        let expectation = self.expectation(description: "Attempting to sign in with user")
        let expectation2 = self.expectation(description: "Attempting to get all users")
        
        travelerController.signIn(username: "testemail25@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
            
            self.travelerController.getListOfAllTravellers() { (error) in
                XCTAssertNil(error)
                expectation2.fulfill()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testAmadeusAPIAuth() {
        let expectation = self.expectation(description: "Getting Amadeus API Access Token")
        
        flightController.getAccessToken { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 15, handler: nil)
    }
    
    func testAirportAPISearch() {
        let expectation = self.expectation(description: "Searching API for Airport")
        
        flightController.searchForAirport() { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
}
