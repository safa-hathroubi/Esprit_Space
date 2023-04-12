//
//  EditProfileView.swift
//  Esprit_Space
//
//  Created by safa hathroubi on 22/3/2023.
//

import SwiftUI


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}




struct EditProfileView: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmNewPassword = ""
    @State private var address = ""
    @State private var phoneNumber = ""

    var body: some View {
        Form {
            Text("Edit Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom,5)
            
            
            Section(header: Text("Change Password")) {
                SecureField("Old Password", text: $oldPassword)
                SecureField("New Password", text: $newPassword)
                SecureField("Confirm New Password", text: $confirmNewPassword)
            }
            Section(header: Text("Change Address")) {
                TextField("Address", text: $address)
            }
            Section(header: Text("Change Phone Number")) {
                TextField("Phone Number", text: $phoneNumber)
                    .keyboardType(.phonePad)
            }
            Button(action: {
                // Save changes
                if newPassword == confirmNewPassword {
                    // Code to update password goes here
                    oldPassword = ""
                    newPassword = ""
                    confirmNewPassword = ""
                } else {
                    // Display an error message to the user
                }
            }) {
                Text("Save Changes")
            }
        }
        .navigationTitle("Edit Profile")
    }
}
