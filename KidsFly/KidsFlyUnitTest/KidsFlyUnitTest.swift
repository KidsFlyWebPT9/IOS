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

    func testCreateNewUser() {
            
        let travelerController = TravelerController()
        
        let expectation = self.expectation(description: "Waiting to create user")
        
        travelerController.registerNewUser(email: "testemail@gmail.com", password: "PASSWORD123") { (error) in
            
            XCTAssertNil(error)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
    }
}
