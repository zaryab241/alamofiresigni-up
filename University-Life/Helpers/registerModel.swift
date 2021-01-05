//
//  registerModel.swift
//  University-Life
//
//  Created by Zaryab on 1/5/21.
//

import Foundation

struct registerModel: Encodable{
    let FirstName: String
    let LastName: String
    let Email: String
    let Password: String
}

struct loginModel: Encodable{
    
    let txtEmailID: String
    let txtPassword: String
}

struct loginResponseModel: Codable{
    let messagetype:String
}
