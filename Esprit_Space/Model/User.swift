//
//  User.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 28/03/2023.
//

struct User: Codable{
    let email:String
    //let token: String
    let password:String
    private enum CodingKeys: String, CodingKey{
        case email
        //case token
        case password
    }
    
}
