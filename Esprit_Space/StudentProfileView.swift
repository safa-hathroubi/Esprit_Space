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
    @State private var email: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle")
                .font(.system(size: 120))
                .foregroundColor(.red)
                .padding(.top, 30)
            
            Text("Safa Hathroubi")
                .font(.title)
                .foregroundColor(.black)
                .fontWeight(.bold)
            
            Text("Mobile development Student")
                .foregroundColor(.black)
                .padding(.bottom, 30)
            
            HStack(spacing: 30) {
                VStack {
                    Text("Courses Taken")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("12")
                        .foregroundColor(.black)
                        .font(.title)
                }
                
                VStack {
                    Text("Class")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("4SIM2")
                        .foregroundColor(.black)
                        .font(.title)
                }
            }
            
            
            Button(action: {}) {
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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


/*
struct StudentProfileView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var age: Int = 0
    @State private var major: String = ""
    
    var body: some View {
        VStack {
            Text("Student Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 150, height: 150)
                .padding(.bottom, 30)
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            TextField("Last Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            /*
             Stepper(value: $age, in: 0...100) {
                Text("Age: \(age)")
            }
            .padding(.bottom, 10)
             */
            
            TextField("Date of Birth", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            TextField("Major", text: $major)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
            Button(action: updateProfile) {
                Text("Update Profile")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
    }
    
    func updateProfile() {
        // TODO: Send update profile request to Node.js server
    }
}
*/
