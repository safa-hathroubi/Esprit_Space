//
//  Evenement.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 26/4/2023.
//
import SwiftUI
import Foundation

struct Evenement: Codable {
    let name: String
    let image: String
    let date: String
    let participants: Int?
    let organizer: String
    let description: String
    let price: String
    let iduser: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case date
        case participants
        case organizer
        case description
        case price
        case iduser = "iduser"
    }
}
