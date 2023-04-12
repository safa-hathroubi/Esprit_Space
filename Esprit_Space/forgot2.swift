//
//  forgot2.swift
//  login
//
//  Created by Floki on 11/4/2023.
//

import SwiftUI

struct forgot2: View {
       var email: String
       @State private var isLoading = false
       @State private var code: String = ""
       @State private var isCodeComplete: Bool = false
       @State private var focusIndex = 0
       @State private var codeDict = [Int: String]()
       @State private var firstResponderIndex = 0
       @State private var isReset3Active = false
       @State private var isShowingAlert = false
    @ObservedObject var viewModel = UserViewModel()
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
       @Environment(\.presentationMode) var presentationMode
       
       var body: some View {
           ScrollView(showsIndicators: false) {
               VStack {
                 /*  Image("Enter OTP-rafiki")
                       .resizable()
                       .frame(width: 280, height: 280 , alignment: .center)
                       .padding(.horizontal, 20)*/
                   
                   Text("Enter the code")
                       .font(Font.system(size: 25))
                       .bold()
                       .padding(.top,10)
                   
                   
                   
                   Text("we sent you via your email")
                       .font(.headline)
                       .foregroundColor(.gray)
                       .padding(.top,10)
                   
                   /* HStack(spacing: 15) {
                    /*  OneTimeCodeInput(codeDict: $codeDict, firstResponderIndex: $firstResponderIndex)*/
                    
                    }
                    .padding(.horizontal,20)
                    .padding(.top,30)*/
                   
                   TextField("OTP", text: $code, onEditingChanged: { isEditing in
                       if !isEditing {
                          // isCodeComplete = code.count == 4
                       }
                   }, onCommit: {
                       //  isCodeComplete = code.count == 4
                   })
                   .font(.title2)
                   .keyboardType(.numberPad)
                   .frame(width: 120, height: 70)
                   .multilineTextAlignment(.center)
                   .foregroundColor(.black)
                   .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color.gray, lineWidth: 1))
                   .padding(.top, 30)
                   .disabled(isCodeComplete)
                   .onReceive(code.publisher.collect()) { newValue in
                       isCodeComplete = newValue.count == 6
                   }
                   
                   
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
                               
                                   Text("Verify")
                                       .padding(.horizontal, 110)
                                       .foregroundColor(.white)
                                       .padding()
                                       .background(isCodeComplete ? Color.red : Color.red.opacity(0.5))
                                       .cornerRadius(30)
                                       .frame(maxWidth: .infinity)
                               
                               .disabled(!isCodeComplete)

                               
                           }
                       }
                       .padding(.horizontal, 20)
                       .padding(.top, 40)
                   
                   Spacer()
               }
               .alert(isPresented: $isShowingAlert) {
                   Alert(title: Text("Wrong code").foregroundColor(.red), message: Text("Please check the code we sent you via your email"), dismissButton: .default(Text("OK")) {
                       code = ""
                   })
               }

              .background(
                              NavigationLink(
                                   destination: forgot3(email: email),
                                   isActive: $isReset3Active
                               ) { EmptyView() }
                               .hidden()
                           )
               
           }}
           
       
           
       
       private func send() {
          
               viewModel.verifyOTP(email: email, otp: code, onSuccess: {
               isReset3Active = true
                   // handle success case
               }, onFailure: { title, message in
                   errorTitle = title
                   errorMessage = message
                   showError = true
               })
          
       }
               
       }
           

   

struct forgot2_Previews: PreviewProvider {
    static var previews: some View {
        forgot2(email:"emna.ouenniche@esprit.tn")
    }
}
