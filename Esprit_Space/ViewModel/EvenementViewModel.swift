//
//  EvenementViewModel.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 26/4/2023.
//

import Foundation

import Combine
import Alamofire

class EventViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var events = [Evenement]()
    @Published var isLoading = false
    
    private let baseURL = "http://172.17.15.240:5000/"
    
    // MARK: - Public Methods
    
    /* //OLD RETRIEVE EVENTS FUNCTION
    func retrieveEvents(iduser: String, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        let parameters: [String: String] = ["iduser": iduser]
        AF.request(baseURL + "event/getUserEv",
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Evenement].self) { response in
                self.isLoading = false
                switch response.result {
                case .success(let events):
                    self.events = events
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }*/
    
    /* OLD RETRIEVE EVENTS FUNCTION WITH USERID
     func retrieveEvents(completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        AF.request(baseURL + "event/getUserEv")
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Evenement].self) { response in
                self.isLoading = false
                switch response.result {
                case .success(let events):
                    self.events = events
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }*/
    
    
   /* NEWEST OLD RETRIEVE FUNCTIOJN
    func retrieveEvents(completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        AF.request(baseURL + "event/getAllEv",
                   method: .get,
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [Evenement].self) { response in
                self.isLoading = false
                switch response.result {
                case .success(let events):
                    self.events = events
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }*/
    
    func retrieveEvents() {
           guard let url = URL(string: "http://172.17.15.240:5000/event/getAllEv") else {
               return
           }
           
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let error = error {
                   print(error.localizedDescription)
                   return
               }
               
               guard let data = data else {
                   print("No data received")
                   return
               }
               
               do {
                   let decoder = JSONDecoder()
                   decoder.dateDecodingStrategy = .iso8601 // Set the date decoding strategy for ISO 8601 dates
                   let events = try decoder.decode([Evenement].self, from: data)
                   
                   DispatchQueue.main.async {
                       self.events = events
                   }
               } catch {
                   print(error.localizedDescription)
               }
           }.resume()
       }
   

    
    
    
    func createEvent(event: Evenement, completion: @escaping (Result<Evenement, Error>) -> Void) {
        isLoading = true
        AF.request(baseURL + "events",
                   method: .post,
                   parameters: event,
                   encoder: JSONParameterEncoder.default)
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: Evenement.self) { response in
                self.isLoading = false
                switch response.result {
                case .success(let createdEvent):
                    completion(.success(createdEvent))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func deleteEvent(event: Evenement, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        AF.request(baseURL + "events/\(event.iduser ?? "")",
                   method: .delete)
            .validate(statusCode: 200..<401)
            .validate(contentType: ["application/json"])
            .response { response in
                self.isLoading = false
                switch response.result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
