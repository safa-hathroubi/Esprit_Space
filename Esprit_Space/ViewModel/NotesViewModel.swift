//
//  NotesViewModel.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 13/4/2023.
//

import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes = [Note]()
    
    func fetchNotes(forUserId userId: String) {
        guard let url = URL(string: "http://172.17.3.28:5500/notes/AllNotes") else { return }
        
        let body: [String: Any] = ["iduser": userId]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching notes: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data found.")
                return
            }
            
            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                DispatchQueue.main.async {
                    self.notes = notes
                }
            } catch {
                print("Error decoding notes: \(error.localizedDescription)")
            }
        }.resume()
    }
}




/*
    CODE ISNT DESIGNED TO DISPLAY CUSTOM NOTES FOR THE CURRENT USER BUT RATHER DISPLAYS ALL THE NOTES OF ALL THE USERS
 
 import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    func fetchNotes() {
        guard let url = URL(string: "http://172.17.3.62:5000/notes/AllNotes") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                print("No data returned from server")
                return
            }

            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                DispatchQueue.main.async {
                    self.notes = notes
                }
            } catch let error {
                print("Error decoding notes:", error)
            }
        }.resume()
    }
}

*/
