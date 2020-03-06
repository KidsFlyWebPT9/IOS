//
//  DJErrorMessage.swift
//  KidsFly
//
//  Created by Enayatullah Naseri on 2/27/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation

enum KFError: String, Error {
    case emptyEmailAndPassword = "Please provide your email and password before trying to sign in."
    case incorrectEmail = "The email you entered was not correct. Please try again."
    case incorrectPassword = "The password you entered was not correct. Please try again."
    case generalWrongInfo = "The information you entered was not correct. Please enter your email and password."
    case emptyEmailAndPasswordSignUp = "Please provide your email address and a password before trying to sign up."
    case invalidEmail = "The email you entered is not valid. Please try again."
    case emailAlreadyInUse = "The email you entered is already in use. Please use a different email address."
    case generalSignUpError = "There was an issue trying to sign up. Please try again."
    case errorSigningOut = "There was an error signing out. Please try again."
    case signUpWasSuccessful = "You have signed up successfully"
    case doneTraveling = "We look forward to helping you soon! Safe Travels"
    case profileUpdated = "Your profile has been updated."
    
}
