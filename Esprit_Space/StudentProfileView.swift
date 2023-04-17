//
//  StudentProfileView.swift
//  Esprit_Space
//
//  Created by Mac2021 on 14/3/2023.
//

import SwiftUI



struct StudentProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StudentProfileView()
        
    }
}



struct StudentProfileView: View {
    //@State private var isShowingEditProfileView = false
    
    @State private var isShowingEditProfileView = false
    @State private var user: User?

    @State private var email = String(decoding: UserDefaults.standard.data(forKey: "email") ?? Data(), as: UTF8.self)
    
    

    var body: some View {
        

 
        VStack(spacing: 20) {
           
            Image(systemName: "person.crop.circle")
                .font(.system(size: 120))
                .foregroundColor(.red)
                .padding(.top, 5 )
            
         /*   Text("Safa Hathroubi")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)*/
            VStack {
                if let user = user {
                    Text(user.name!)
                        .foregroundColor(.black)
                    .font(.title)
                    
                }
                else {
                    Text("Class")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("4SIM2")
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
            
        /*    Text("email \(user.email)")
                .foregroundColor(.black)
                .padding(.bottom, 30)*/
            
            VStack {
                if let user = user {
                    Text(user.email)
                        .foregroundColor(.black)
                    .font(.title)
                    
                }
                else {
                    Text("Class")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("4SIM2")
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
            
            HStack(spacing: 30) {
                VStack {
                    Text("Courses Taken")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("12")
                        .foregroundColor(.black)
                    .font(.title)}
                VStack {
                    if let user = user {
                        Text("Classe")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text(user.classe!)
                            .foregroundColor(.black)
                        .font(.title)
                        
                    }
                    else {
                        Text("Class")
                            .foregroundColor(.black)
                            .font(.headline)
                            .padding(.bottom, 5)
                        Text("4SIM2")
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
                
            }
            
            
            Button(action: {
                isShowingEditProfileView = true
                print(UserDefaults.standard.data(forKey: "email"))
            })
            
            
            {
                NavigationLink(
                    destination: EditProfileView(email:email),
                    isActive: $isShowingEditProfileView,
                    label: {
                        Text("Edit Profile")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    })

            }


 
            
            
         

            
            /* Button(action: {}) {
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                
                    .background(
                                    NavigationLink(
                                         destination: EditProfileView(),
                                         isActive: $isReset4Active
                                     ) { EmptyView() }
                                     .hidden()
                                 )
                    
            }*/
           
      /* }.padding
            .frame(maxWidth: .infinity, maxHeight: .infinity) */
                }.padding()
         .frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity)

            .background(
            LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color.red,
                        Color.white,
                        Color.gray
                    ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }

}


    
