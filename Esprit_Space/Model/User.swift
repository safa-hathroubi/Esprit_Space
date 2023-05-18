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
    let UserClasse :String?
    let UserName :String?
    let UserAbsences :String?
    let UserDateabs :String?
    let UserMatiere :String?
    let Usercc :String?
    let UserExamen: String?
    
    
    
    private enum CodingKeys: String, CodingKey{
        case email
        //case token
        case password
        case UserClasse
        case UserName
        case UserAbsences
        case UserDateabs
        case UserMatiere
        case Usercc
        case UserExamen
    }
    
}
