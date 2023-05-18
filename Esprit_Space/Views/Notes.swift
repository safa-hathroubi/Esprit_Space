//
//  Notes.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 06/05/2023.
//

import SwiftUI
struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}


struct Notes: View {
    @State private var user: User?
    
    var body: some View {
        VStack {
            if let user = user {
                HStack {
                    Text("Matière").foregroundColor(.white).bold()
                    Text("CC").foregroundColor(.white).bold()
                    Text("Examen").foregroundColor(.white).bold()
                }.padding(.horizontal)
                    .background(Color.red)
                Divider()
                HStack {
                    Text(user.matiere ?? "-").foregroundColor(.black).padding(10)
                    Text(user.cc ?? "-").foregroundColor(.black).padding(10)
                    Text(user.examen ?? "-").foregroundColor(.black).padding(10)
                }.background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
            } else {
                Text("Aucune donnée à afficher").foregroundColor(.white).padding()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding()
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: "user") {
                let decoder = JSONDecoder()
                do {
                    let decodedPerson = try decoder.decode(User.self, from: data)
                    self.user = decodedPerson
                } catch {
                    print("Error decoding Person: \(error)")
                }
            }
        }
    }
}
