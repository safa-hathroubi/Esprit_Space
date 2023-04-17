//
//  User.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 28/03/2023.
//

struct Classe: Codable{
    let clas:String
    //let token: String
    let name:String
    let iduser:String
    private enum CodingKeys: String, CodingKey{
        case clas
        //case token
        case name
        case iduser
    }
    
}
