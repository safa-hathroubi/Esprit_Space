//
//  aaaa.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 17/05/2023.
//

import SwiftUI
import LocalAuthentication

struct aaaa: View {
    @State private var unlocked = false
    VStack{
               if unlocked{
                   Text("tay")
               }else{
                   Text("mech tay")
                   }
               }
           .onAppear(perform: Authent )
       }
       func Authent(){
           let context = LAContext()
           var error: NSError?
           if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
           {
               let reason = "We Need to scan your face. "
               context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
               localizedReason: reason)
               {success, AuthenticationError in
                   if success{
                       //authent success
                       unlocked = true
                   }else{
                       //there was a problem
                   }
               }
           }else{
               //no biometrics
           }
       }
   }


struct aaaa_Previews: PreviewProvider {
    static var previews: some View {
        aaaa()
    }
}
