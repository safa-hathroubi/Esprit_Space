//
//  SignupView.swift
//  Esprit_Space
//
//  Created by Mac2021 on 14/3/2023.
//

import SwiftUI


struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}





struct SignupView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("HD-wallpaper-simple-abstract-design-black-flat-modern-red-shapes-waves-white")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
                
                
                
                VStack(spacing: 10) {
                    Text("Create an Account")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 10)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 20)
                    
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                    
                    Button(action: signup) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Already have an account? Login")
                    }
                }
                .padding()
                //.frame(maxWidth: .infinity)
                //.background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 300)
                .padding(.bottom, 30)
            }}
    }
    
    func signup() {
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address"
            showingAlert = true
            return /*{ NavigationLink(destination: HomeView())}*/
            
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            showingAlert = true
            return
        }
        
        // TODO: Send signup request to Node.js server
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
