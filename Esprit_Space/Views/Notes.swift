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
    // Sample data for credits and absences
  /*  let credits = [
        Credit(subject: "Math", credits: 3, date: "2022-09-01", coefficient: 1.5),
        Credit(subject: "English", credits: 2, date: "2022-09-01", coefficient: 1.0),
        Credit(subject: "Science", credits: 4, date: "2022-09-01", coefficient: 2.0),
        Credit(subject: "History", credits: 2, date: "2022-09-01", coefficient: 1.0),
    ]
    let absences = [
        Absence(date: "2023-01-01", justification: "Sick"),
        Absence(date: "2023-02-01", justification: "Family emergency"),
        Absence(date: "2023-03-01", justification: "Doctor appointment"),
        Absence(date: "2023-04-01", justification: "Vacation"),
    ]*/
    
    var body: some View {
       //ScrollView {
            HStack(spacing: 20) {
                // Credits section
                HStack {
                    if let user = user {
                        Text(user.matiere!) .foregroundColor(.black)
                            .font(.title)
                        Text(user.cc!) .foregroundColor(.black)
                            .font(.title)
                        
                        Text(user.examen!)

                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Notes")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Aucune note")
                            .foregroundColor(.black)
                        .font(.title)
                    }
                    
                }
                
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
                
              /*  VStack {
                    if let user = user {
                        Text(user.cc!)
                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Notes")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Aucune note")
                            .foregroundColor(.black)
                        .font(.title)
                    }
                    
                }
                
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
                
                VStack {
                    if let user = user {
                        Text(user.examen!)
                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Notes")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Aucune note")
                            .foregroundColor(.black)
                        .font(.title)
                    }
                    
                }
                
                
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
             */
                .padding(.bottom, 180)
                
                // Absences section
                /*VStack(spacing: 10) {
                    Text("Absences").font(.title)
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 10) {
                            ForEach(absences, id: \.date) { absence in
                                AbsenceRowView(absence: absence)
                            }
                        }
                    }
                }*/
                
               
                .padding(.bottom, 180)
               /* VStack {
                    if let user = user {
                        Text("Absences")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text(user.absences!)
                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Absences")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Aucune abs")
                            .foregroundColor(.black)
                        .font(.title)
                    }
                    
                }*/
                
                /*VStack {
                    if let user = user {
    
                        Text(user.dateabs!)
                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Absences")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("Aucune abs")
                            .foregroundColor(.black)
                        .font(.title)
                    }
                    
                }*/
                
                
                
                
               /* .onAppear {
                           if let data = UserDefaults.standard.data(forKey: "user") {
                               let decoder = JSONDecoder()
                               do {
                                   let decodedPerson = try decoder.decode(User.self, from: data)
                                   self.user = decodedPerson
                               } catch {
                                   print("Error decoding Person: \(error)")
                               }
                           }
                       }*/
                
                // PDF section
                /*VStack(spacing: 10) {
                    Text("Emplois").font(.title)
                    ScrollView(.vertical) {
                       
                    }
                }*/
                .padding(.bottom, 180)
                // PDF button
                                 /*NavigationLink(destination: TimePDFView()) {
                                     Text("View Latest PDF").font(.title2).bold()
                                         .frame(maxWidth: .infinity)
                                         .padding()
                                         .foregroundColor(.white)
                                         .background(Color.red)
                                         .cornerRadius(10)
                                 }*/
            }
            .padding()
      //  }
        //.background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
    }
}
