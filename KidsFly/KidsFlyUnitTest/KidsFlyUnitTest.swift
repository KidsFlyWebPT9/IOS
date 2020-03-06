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
    let tripController = TripController()

    func testCreateNewUser() {
        let expectation = self.expectation(description: "Waiting to create user")
        
        travelerController.registerNewUser(username: "testemail28@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testLogIn() {
        let expectation = self.expectation(description: "Attempting to Sign In With User")
        
        travelerController.signIn(username: "testemail28@gmail.com", password: "PASSWORD123") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }

    func testGetUser() {
        let expectation = self.expectation(description: "Getting welcome message")

        travelerController.getUserInfo() { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    
    // This test only worked on the original API that was abonded due to BackEnd not coming through
//    func testGetAllUsers() {
//        let expectation = self.expectation(description: "Attempting to sign in with user")
//        let expectation2 = self.expectation(description: "Attempting to get all users")
//
//        travelerController.signIn(username: "testemail26@gmail.com", password: "PASSWORD123") { (error) in
//            XCTAssertNil(error)
//            expectation.fulfill()
//
//            self.travelerController.getListOfAllTravellers() { (error) in
//                XCTAssertNil(error)
//                expectation2.fulfill()
//            }
//        }
//        self.waitForExpectations(timeout: 10, handler: nil)
//    }
    
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
        
        flightController.searchForAirport(airportName: "San Fran"){ (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testCreateNewTrip() {
        let expectation = self.expectation(description: "Attempting to create a trip")
        
        let trip = TripRepresentation(user_id: 6, airport_id: 16, departure_time: "11:27AM")

        tripController.createNewTrip(trip) { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetAllTrips() {
        let expectation = self.expectation(description: "Attempting to get all trips")
        
        tripController.getAllTrips { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
}
