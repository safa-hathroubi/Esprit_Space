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
    let classe :String?
    let name :String?
    let absences :String?
    let dateabs :String?
    let matiere :String?
    let cc :String?
    let examen: String?
    private enum CodingKeys: String, CodingKey{
        case email
        //case token
        case password
        case classe
        case name
        case absences
        case dateabs
        case matiere
        case cc
        case examen
    }
    
}
