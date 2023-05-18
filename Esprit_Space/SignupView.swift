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
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""
    @State private var showingAlert = false
    @State private var errorTitle = ""
    @State private var showError = false
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingLoginView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                                   Image("logo-esprit")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(height: 80)
                                       .padding(.top, 20)
                                   Spacer()
                               }
                               
                
                
                VStack {
                   
                    
                    Image("register")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 220)
                        .ignoresSafeArea()
                    Spacer()
                }
                .padding(.top, 120) // add some padding to the top of the VStack
                
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
                    
                    Button(action: {
                        if isValidEmail(email) {
                            signup()
                        } else {
                            errorMessage = "Invalid email format"
                            showingAlert = true
                        }
                    }) {
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Already have an account? Login").foregroundColor(.black)
                    }
                    
                    NavigationLink(
                        destination: LoginView(),
                        isActive: $isShowingLoginView
                    ) {
                        EmptyView()
                    }
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 350)
                .padding(.bottom, 30)
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@esprit\\.tn"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func signup() {
        viewModel.Signup(email: email, password: password, onSuccess: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        }, onFailure: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        })
    }
}
