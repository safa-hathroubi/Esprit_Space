//
//  ForgetViw.swift
//  login
//
//  Created by Apple Esprit on 15/3/2023.
//

import Foundation

import SwiftUI

struct ForgetView: View {
    @State private var email: String = ""
       @State private var isLoading = false
       @ObservedObject var viewModel = UserViewModel()
       @State private var showError = false
       @State private var errorTitle = ""
       @State private var errorMessage = ""
       @State private var token: String?
       @State private var isReset2Active = false
       @State private var isPresentingReset2 = false
       @Environment(\.presentationMode) var presentationMode
       
       var body: some View {
          
           VStack {
             /*  Image("Envelope-rafiki")
                   .resizable()
                   .frame(width: 300, height: 300 , alignment: .center)
                   .padding(.horizontal, 20)*/
               
               Text("Forgot Password?")
                   .font(Font.system(size: 25))
                   .bold()
                   
                                   
               
               Text("Enter your email")
                                   .font(.headline)
                                   .foregroundColor(.gray)
                                   .padding(.top,10)
               TextField("Email", text: $email)
                   .frame(height: 50)
                   .foregroundColor(.black)
                   .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 15))
                   .textFieldStyle(PlainTextFieldStyle())
                   .background(Color(.systemGray6).opacity(0.7))
                   .cornerRadius(30)
                   .padding(.horizontal,20)
                   .padding(.top,30)
               
             
                   
               
               
               Button(
                   action: {
                       // Perform sign up action
                       withAnimation {
                           isLoading = true
                           DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                               isLoading = false
                               send()
                           }
                       }
                   }) {
                       if isLoading {
                           ProgressView()
                               .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                               .scaleEffect(2)
                               .padding()
                       } else {
                               Text("Send")
                                   .padding(.horizontal,110)
                                   .foregroundColor(.white)
                                   .padding()
                                   .background(Color.red)
                                   .cornerRadius(30)
                                   .frame(maxWidth: .infinity)
                       }
                   }
                   .padding(.horizontal, 20)
                   .padding(.top, 40)
               
               Spacer()
           }
           .alert(isPresented: $showError) {
               Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
           }
           .background(
                               NavigationLink(
                               destination: forgot2(email: email),
                               isActive: $isReset2Active
                           ) { EmptyView() }
                           .hidden()
                       )
           .navigationBarHidden(true)
       
       }
       
       private func send() {
           viewModel.forgotPassword(email: email, onSuccess: {
               isReset2Active = true
           }, onFailure: { title, message in
               errorTitle = title
               errorMessage = message
               showError = true
           })
       }
       

   }


struct ForgetView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetView()
    }
}
