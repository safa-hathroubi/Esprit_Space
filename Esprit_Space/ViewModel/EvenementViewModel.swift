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
    
    private let baseURL = "http://172.17.10.95:5000/"
    
    // MARK: - Public Methods
    

    func retrieveEvents() {
        guard let url = URL(string: baseURL + "event/getAllEv") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let events = try decoder.decode([Evenement].self, from: data)
                DispatchQueue.main.async {
                    self.events = events
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }
 
    
    
   
  /*
   func addEvent(name: String, image: String, date: String, organizer: String, description: String, price: String, iduser: String) {
            let url = URL(string: "http://localhost:5000/event/createEv")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = JSONEncoder()
            let eventData = Evenement(name: name, image: image, date: date, organizer: organizer, description: description, price: price, iduser: iduser)
            do {

                let data = try encoder.encode(eventData)
                request.httpBody = data
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print("Error adding event: \(error.localizedDescription)")
                        print("checkpoint3")
                        return
                    }
                    guard let data = data else {
                        print("Error adding event: No data received")
                        return
                    }
                    if let decodedResponse = try? JSONDecoder().decode(Evenement.self, from: data) {
                        let iduser = decodedResponse.iduser ?? "644a41000e704acac2c6a765"
                        print("Event added with ID: \(iduser)")
                        //print("Event added with ID: \(decodedResponse.iduser)")
                    } else {print("checkpoint6")
                        print("Error adding event: Invalid response from server")
                    }
                }.resume()
            } catch {
                print("Error adding event: \(error.localizedDescription)")
            }
        }*/
    
    func addEvent(name: String, image: UIImage, date: Date, organizer: String, description: String, price: String, iduser: String) {

        let url = URL(string: "http://172.17.10.95:5000/event/createEv")!
        let headers: HTTPHeaders = ["Content-type": "multipart/form-data"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(name.data(using: .utf8)!, withName: "name")
            multipartFormData.append(dateString.data(using: .utf8)!, withName: "date")
            multipartFormData.append(organizer.data(using: .utf8)!, withName: "organizer")
            multipartFormData.append(description.data(using: .utf8)!, withName: "description")
            multipartFormData.append(price.data(using: .utf8)!, withName: "price")
            multipartFormData.append(iduser.data(using: .utf8)!, withName: "iduser")

            if let imageData = image.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
            }
        }, to: url, headers: headers)
        .validate()
        .responseDecodable(of: Evenement.self) { response in
            switch response.result {
            case .success(let evenement):
                let iduser = evenement.iduser ?? "644a41000e704acac2c6a765"
                print("Event added with ID: \(iduser)")
            case .failure(let error):
                print("Error adding event: \(error.localizedDescription)")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    // MARK: - OLD CODE

    
    // BOTH NON FUNCTIONAL
    
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






extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
}
