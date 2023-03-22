//
//  LoginView.swift
//  Esprit_Space
//
//  Created by Mac2021 on 14/3/2023.
//

import SwiftUI



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
            ZStack {
                Image("HD-wallpaper-simple-abstract-design-black-flat-modern-red-shapes-waves-white")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
        VStack(spacing: 10) {
            Text("Log in")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 20)
            
            Button(action: login) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            NavigationLink(destination: SignupView()) {
                Text("Don't have an account? Sign up")
            }
        }.padding()
                //.frame(maxWidth: .infinity)
                //.background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 300)
                .padding(.bottom, 30)
            }
    }
    
    func login() {
        // TODO: Send login request to Node
    }
}
