//
//  NotesView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 12/4/2023.
//


struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}


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
