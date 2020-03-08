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

//    func testCreateNewUser() {
//        let expectation = self.expectation(description: "Waiting to create user")
//
//        travelerController.registerNewUser(username: "testemail29", password: "PASSWORD123") { (error) in
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//        waitForExpectations(timeout: 10, handler: nil)
//    }
//
//
//    func testLogIn() {
//        let expectation = self.expectation(description: "Attempting to Sign In With User")
//
//        travelerController.signIn(username: "testemail28", password: "PASSWORD123") { (error) in
//            XCTAssertNil(error)
//            expectation.fulfill()
//        }
//        self.waitForExpectations(timeout: 10, handler: nil)
//    }

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
        
        
        
        let trip = TripRepresentation(user_id: 6, airport_id: 6, departure_time: "11:27AM")

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
    
    func testUpdateTrip() {
        let expectation = self.expectation(description: "Attempting to update trip")
        let trip = TripRepresentation(id: 11, user_id: 6, airport_id: 8, departure_time: "12:04PM")
        
        tripController.updateTrip(trip) { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDeleteTrip() {
        // since core data not yet in use, need to first create a trip to add to local array in tripController
        let expectation = self.expectation(description: "Attempting to create trip")
        let expectation2 = self.expectation(description: "Attempting to delete trip")
        
        let trip = TripRepresentation(user_id: 6, airport_id: 25, departure_time: "9:05AM")
        
        tripController.createNewTrip(trip) { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
            
            let savedTrip = self.tripController.trips[0]
            self.tripController.deleteTrip(savedTrip) { (error) in
                XCTAssertNil(error)
                expectation2.fulfill()
            }
        }
        
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testDeleteSingleTrip() {
        let expectation = self.expectation(description: "Attempting to create trip")
        
        let trip = TripRepresentation(id: 1, user_id: 6, airport_id: 8, departure_time: "12:04PM")
        
        tripController.deleteTrip(trip) { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testGetSingleTripByID() {
        let expectation = self.expectation(description: "Attempting to get trip")
        
        let trip = TripRepresentation(id: 28, user_id: 6, airport_id: 6, departure_time: "11:27AM")
        
        tripController.getSingleTrip(trip: trip) { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetAirportDatabase() {
        let expectation = self.expectation(description: "Attempting to get airport database")
        
        flightController.getFullAirportDatabase { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetAirportDatabaseIndex() {
        flightController.getIndex(using: "SFO")
    }
    
    func testSearchAndFindAirportIndex() {
        let expectation = self.expectation(description: "Searching for airport and ID")
        
        flightController.searchForAirport(airportName: "Chicago Mid") { (error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
//   
    
}
