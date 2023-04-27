//
//  NotesView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 13/4/2023.
//

//
//  NotesView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 12/4/2023.
//

import SwiftUI

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}


struct NotesView: View {
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
        ScrollView {
            VStack(spacing: 20) {
                // Credits section
                VStack {
                    if let user = user {
                        Text(user.matiere!)
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
             
                .padding(.top, 60)
                
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
                
               
                .padding(.bottom, 20)
                VStack {
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
                    
                }
                
                VStack {
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
                
                // PDF section
                VStack(spacing: 10) {
                    Text("Emplois").font(.title)
                    ScrollView(.vertical) {
                       
                    }
                }
                .padding(.bottom, 20)
                // PDF button
                                 NavigationLink(destination: TimePDFView()) {
                                     Text("View Latest PDF").font(.title2).bold()
                                         .frame(maxWidth: .infinity)
                                         .padding()
                                         .foregroundColor(.white)
                                         .background(Color.blue)
                                         .cornerRadius(10)
                                 }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
    }
}

struct CreditRowView: View {
    let credit: Credit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(credit.subject)
                    .font(.headline)
                Text("\(credit.credits) credits")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("Coeff: \(credit.coefficient)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(credit.date)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct AbsenceRowView: View {
    let absence: Absence
    
    var body: some View {
        HStack {
            Text(absence.date)
                .font(.subheadline)
            Spacer()
            Text(absence.justification)
                .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct Credit: Identifiable {
    let id = UUID()
    let subject: String
    let credits: Int
    let date: String
    let coefficient: Double
}

struct Absence: Identifiable {
    let id = UUID()
    let date: String
    let justification: String
}


/*



import SwiftUI

struct NotesView: View {
    @StateObject var viewModel = NotesViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).ignoresSafeArea()
                
                VStack {
                    Text("Affichage des notes iciiiii")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.top, 20)
                    
                    if viewModel.notes.isEmpty {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 20) {
                                ForEach(viewModel.notes, id: \.iduser) { note in
                                    NoteCard(note: note)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal, 20)
            }
            .navigationTitle("My Notes")
            .onAppear {
                viewModel.fetchNotes(forUserId: "YOUR_USER_ID_HERE")
            }
        }
    }
}

struct NoteCard: View {
    let note: Note
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.matiere)
                .font(.headline)
            Text("CC: \(note.cc) - Examen: \(note.examen)")
                .font(.subheadline)
            Text(note.iduser)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
*/
