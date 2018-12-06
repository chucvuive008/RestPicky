//
//  User.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import Foundation
import UIKit

public class User {
    var name : String
    var uid : String
    var email : String
    var restaurantsIdBookmark = [Int]()
    var image = UIImage()
    var address : String
    var bookmarks = [Bookmark]()
    var phone : String
    
    init() {
        name = ""
        uid = ""
        email = ""
        address = ""
        phone = ""
    }
}
