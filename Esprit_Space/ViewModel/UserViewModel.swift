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


class UserViewModel: ObservableObject{
    var currentUser: User?
    @Published var isLoading: Bool = false
    @Published var isAuthenticated = false
    @Published var isRegistred = false
    private let baseURL = "http://172.17.10.95:5000/"
    
    
    func login(email: String, password: String, onSuccess:@escaping (_ email: String)->Void , onFailure:@escaping(_ titre:String,_ message:String)->Void){
            isLoading = true
            AF.request(baseURL+"user/login" ,
                       method: .post,
                       parameters: [ "email" : email, "password" : password ],
                       encoding: JSONEncoding.default)
            .validate(statusCode: 200..<403)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    guard let jsonData = data as? [String: Any],
                          let statusCode = response.response?.statusCode else {
                        onFailure("Error", "Invalid response format11")
                        return
                    }
                    
                    switch statusCode {
                    case 200:
                        guard let email = jsonData["email"] as? String else {
                            onFailure("Error", "Invalid response format22")
                            return
                        }
                        AF.request("http://172.17.10.95:5000/user/\(email)")
                            .validate(statusCode: 200..<300)
                            .responseDecodable(of: User.self) { response in
                                switch response.result {
                                case .success(let user):
                                    self.currentUser = user
                                    let encoder = JSONEncoder()
                                    if let encodedPerson = try? encoder.encode(user) {
                                        UserDefaults.standard.set(encodedPerson, forKey: "user")
                                    }
                                    self.isAuthenticated = true
                                    onSuccess(email)
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    onFailure("Error", "Network request failed")
                                }
                            }
                    case 400:
                        onFailure("Login failed", "Invalid password")
                    case 402:
                        onFailure("Account not activated", "Your email address has not been verified")
                    default:
                        onFailure("User not found", "This email address is not associated with any account")
                    }
                case .failure(let error):
                    print(error)
                    onFailure("Error", "Network request failed")
                }
                self.isLoading = false
            }
        }
    
    
    
   /* func login(email: String, password: String, onSuccess:@escaping (_ email: String)->Void , onFailure:@escaping(_ titre:String,_ message:String)->Void){
        AF.request(baseURL+"user/login" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<403)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format11")
                    return
                }
                
                switch statusCode {
                case 200:
                    guard let email = jsonData["email"] as? String,
                          let password = jsonData["password"] as? String,
                            let UserClasse = jsonData["UserClasse"] as? String,
                          let UserName = jsonData["UserName"] as? String,
                          let UserAbsences = jsonData["UserAbsences"] as? String,
                          let UserDateabs = jsonData["UserDateabs"] as? String,
                          let UserMatiere = jsonData["UserMatiere"] as? String,
                          let Usercc = jsonData["Usercc"] as? String,
                          let UserExamen = jsonData["UserExamen"] as? String





                    else {
                        onFailure("Error", "Invalid response format22")
                        return
                    }
                    let user = User(email: email,password: password,UserClasse: nil, UserName: nil ,UserAbsences: nil , UserDateabs: nil , UserMatiere:nil , Usercc: nil, UserExamen: nil)
                    self.currentUser = user
                    // Store token in UserDefaults
                    // UserDefaults.standard.set(token, forKey: "token")
                    
                    
                    let user2 = User(email: email, password: password, UserClasse: UserClasse, UserName: UserName ,UserAbsences: UserAbsences ,UserDateabs: UserDateabs , UserMatiere: UserMatiere, Usercc: Usercc ,UserExamen: UserExamen)
                    
                    let encoder = JSONEncoder()

                    if let encodedPerson = try? encoder.encode(user2) {
                        // Stocker les données encodées dans UserDefaults
                        UserDefaults.standard.set(encodedPerson, forKey: "user")
                        
                        
                    }
                    
                    if let data = UserDefaults.standard.data(forKey: "user") {
                        // Décoder les données en utilisant JSONDecoder
                           let decoder = JSONDecoder()
                           if let decodedPerson = try? decoder.decode(User.self, from: data) {
                               // Utiliser l'instance de Person décoder
                               print(decodedPerson.email) // Output: "Alice"
                               print(decodedPerson.UserClasse) // Output: 25
                               print(decodedPerson.UserName) // Output: 25
                               print(decodedPerson.UserAbsences) // Output: 25
                               print(decodedPerson.UserDateabs) // Output: 25
                               print(decodedPerson.UserMatiere) // Output: 25
                               print(decodedPerson.Usercc) // Output: 25
                               print(decodedPerson.UserExamen) // Output: 25
                           }
                       }


                  /*  UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(classe, forKey: "classe")
                    UserDefaults.standard.synchronize()

                    let email2 = UserDefaults.standard .data(forKey: "email")
                    UserDefaults.standard.synchronize()
                    print(email2)
                    let password2 = UserDefaults.standard .data(forKey: "password")*/
                    // Set isAuthenticated to true and navigate to home page
                    self.isAuthenticated = true
                    print(self.isAuthenticated)
                    onSuccess(email)
                    
                case 400:
                    onFailure("Login failed", "Invalid password")
                case 402:
                    onFailure("Account not activated", "Your email address has not been verified")
                default:
                    onFailure("User not found", "This email address is not associated with any account")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
        
        
        
    }*///OLD LOGIN FUNCTION
    
    func verifyOTP(email: String, otp: String, onSuccess: @escaping () -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"user/verifyotp",
                   method: .post,
                   parameters: ["email": email ,"otp": otp],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<406)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    print("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                    onSuccess()
                case 404:
                    onFailure("message", "User doesn't exist" )
                case 400:
                    onFailure("message", "incorrect OTP" )
                default:
                    onFailure("User not found", "This email address is not associated with any account")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    
    
    func Signup(email: String, password: String, onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"user/signup" ,
                   method: .post,
                   parameters: [ "email" : email, "password" : password],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<401)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                    self.isRegistred = true
                    onSuccess("Welcome", "Thanks for joining our comunity please check the email  sent to you to activate your account")
                case 400:
                    onFailure("Register failed", "This email is already associated to an account . please use another one or reset your password")
                default:
                    onFailure("Error", "something went wrong please try again")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    
    
    
    func resetPasswordEmail(email: String, onSuccess: @escaping (_ code: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL + "user/paswordforgot",
                   method: .post,
                   parameters: ["email": email],
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
    
    func resetPassword(email: String, password: String,  onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL + "user/resetpassword",
                   method: .post,
                   parameters: ["email": email ,"newPassword" : password ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<405)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "something went wrong please try again")
                    return
                }
                
                switch statusCode {
                case 200:
                    self.isRegistred = true
                    onSuccess("Done", "your password has been successfully changed")
                case 400:
                    onSuccess("Error", "something went wrong please try again")
                default:
                    onFailure("Error", "user not found")
                    
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    func updateUserMail(token: String, username: String , onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL + "user/updateUsername",
                   method: .put,
                   parameters: ["token":token ,"username":username ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<402)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let name = jsonData["name"] as? String else {
                    onFailure("Error", "There no user registred with this mail adress")
                    return
                }
                onSuccess("Done", "Username updated successfully")
                UserDefaults.standard.set(name, forKey: "username")
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    func updatepassword(email: String, password: String ,newpassword: String , onSuccess: @escaping (_ title: String, _ message: String) -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL + "user/updatePassword",
                   method: .put,
                   parameters: ["token":email ,"password":password,"newpassword":newpassword ],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<403)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    onFailure("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                    self.isRegistred = true
                    onSuccess("Done", "your password has been successfully changed")
                case 402:
                    onFailure("Error", "Incorrect password")
                default:
                    onFailure("Error", "something went wrong please try again")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    
    
    func forgotPassword(email: String, onSuccess: @escaping () -> Void, onFailure: @escaping (_ title: String, _ message: String) -> Void) {
        AF.request(baseURL+"user/forgotPassword",
                   method: .post,
                   parameters: ["email": email],
                   encoding: JSONEncoding.default)
        .validate(statusCode: 200..<406)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                guard let jsonData = data as? [String: Any],
                      let statusCode = response.response?.statusCode else {
                    print("Error", "Invalid response format")
                    return
                }
                
                switch statusCode {
                case 200:
                    onSuccess()
                case 404:
                    onFailure("message", "User doesn't exist" )
                default:
                    onFailure("User not found", "This email address is not associated with any account")
                }
            case .failure(let error):
                print(error)
                onFailure("Error", "Network request failed")
            }
        }
    }
    
    

    }
