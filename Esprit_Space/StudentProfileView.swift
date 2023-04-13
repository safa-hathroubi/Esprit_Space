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
    
    @State private var isReset4Active = false

    @State private var email: String = ""
    var body: some View {
        VStack(spacing: 20) {
           
            Image(systemName: "person.crop.circle")
                .font(.system(size: 120))
                .foregroundColor(.red)
                .padding(.top, 5 )
            
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
                        .font(.title)}
                VStack {
                    Text("Class")
                        .foregroundColor(.black)
                        .font(.headline)
                        .padding(.bottom, 5)
                    Text("4SIM2")
                        .foregroundColor(.black)
                        .font(.title)}}
            Button(action: {}) {
                Text("Edit Profile")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)}
            .background(
                            NavigationLink(
                                 destination: EditProfileView(),
                                 isActive: $isReset4Active
                             ) { EmptyView() }
                             .hidden()
                         )
            
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


    
