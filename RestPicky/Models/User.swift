//
//  User.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import Foundation

public class User {
    var name : String
    var uid : String
    var email : String
    var restaurantsIdBookmark = [Int]()
    
    init() {
        name = ""
        uid = ""
        email = ""
    }
}
