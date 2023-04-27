//
//  UserViewModel.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 28/03/2023.
//


import Foundation
import Combine
import Alamofire
import CoreData
import SwiftUI


class ClasseViewModel: ObservableObject{
    var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated = false
    @Published var isRegistred = false
    private let baseURL = "http://localhost:5000/"
    
    
    
    func recupererId(iduser: String, onSuccess: @escaping (_ code: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL + "user/paswordforgot",
                   method: .post,
                   parameters: ["iduser": iduser],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<401)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let code = jsonData["token"] as? String else {
                    onFailure("Error", "There no user registred with this mail adress")
                    return
                }
                onSuccess(code)
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
}
