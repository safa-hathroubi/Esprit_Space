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
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = userViewModel.currentUser {
                    HStack {
                        Text("Matière").foregroundColor(.white).bold()
                        Text("Date").foregroundColor(.white).bold()
                    }
                    .padding(.horizontal)
                    .background(Color.red)
                    
                    Divider()
                    
                    HStack {
                        Text(user.UserAbsences ?? "-").foregroundColor(.black).padding(10)
                        Text(user.UserDateabs ?? "-").foregroundColor(.black).padding(10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else {
                    Text("Aucune donnée à afficher").foregroundColor(.white).padding()
                }
                
                NavigationLink(destination: Notes().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                    Text("Consultez vos notes").font(.title2).bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .disabled(userViewModel.isLoading)
                .opacity(userViewModel.isLoading ? 0.5 : 1)
                .padding(.top, 10)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Absences")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



/*
struct NotesView: View {
    @State private var user: User?
    @StateObject var viewModel = UserViewModel()

    
    var body: some View {
        NavigationView {
            VStack {
                if let user = user {
                    HStack {
                        Text("Matière").foregroundColor(.white).bold()
                        Text("Date").foregroundColor(.white).bold()
                    }
                    .padding(.horizontal)
                    .background(Color.red)
                    
                    Divider()
                    
                    HStack {
                        Text(user.UserAbsences ?? "-").foregroundColor(.black).padding(10)
                        Text(user.UserDateabs ?? "-").foregroundColor(.black).padding(10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                } else {
                    Text("Aucune donnée à afficher").foregroundColor(.white).padding()
                }
                
                NavigationLink(destination: Notes().navigationBarBackButtonHidden(true).navigationBarHidden(true)) {
                    Text("Consultez vos notes").font(.title2).bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            
            //.navigationBarTitle("Mes absences")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
*/
