//
//  UserModel.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - API: https://jsonplaceholder.typicode.com

// MARK: - User API Model 
struct User: Decodable {
    
    var id          : Int?
    var name        : String?
    var username    : String?
    var email       : String?
    var address     : Address?
    var phone       : String?
    var website     : String?
    var company     : Company?
}

struct Address: Decodable {
    
    var street      : String?
    var suite       : String?
    var city        : String?
    var zipcode     : String?
    var geo         : Geo?
}

struct Geo: Decodable {
    
    var lat         : String?
    var lng         : String?
}

struct Company: Decodable {
    
    var name        : String?
    var catchPhrase : String?
    var bs          : String?
}


