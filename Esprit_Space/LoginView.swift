import SwiftUI
import LocalAuthentication


struct LoginView: View {
    @State private var unlocked = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingHomeView = false
    @State private var isReset1Active = false
    @AppStorage("stored_User") var user = "emna.ouenniche@esprit.tn"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image("logo-esprit")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 100)
                        .padding(.top, 20)
                    Spacer()
                }
                
                VStack {
                    Image("aa")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 280)
                        .ignoresSafeArea()
                    Spacer()
                }
                .padding(.top, 120) // add some padding to the top of the VStack
                
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
                    
                    HStack {
                        Button(action: {
                            viewModel.login(email: email, password: password, onSuccess: { email in
                                isShowingHomeView = true // navigate to HomeView
                            }, onFailure: { title, message in
                                // Show dialog with title and message
                                errorTitle = title
                                errorMessage = message
                                showError = true
                            })
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                      
                        if getBioMetricStatus() {
                            Button(action: Authent) {
                                Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    
                    NavigationLink(destination: SignupView(), label: {
                        Text("Don't have an account? Sign up").foregroundColor(.black)
                    }).navigationBarBackButtonHidden(true)
               
                    NavigationLink(destination: ForgetView(), label: {
                        Text("Forgot password?").foregroundColor(.black)
                    }).navigationBarBackButtonHidden(true)
                  
                
                    NavigationLink(
                        destination: HomepageView(),
                        isActive: $isShowingHomeView
                    ){
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 400)
                .padding(.bottom, 30)
                
                // Show error message
                .alert(isPresented: $showError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .onAppear {/*
            viewModel.login(email: email, password: password, onSuccess: { email in
                isShowingHomeView = true // navigate to HomeView
            }, onFailure: { title, message in
                // Show dialog with title and message
                errorTitle = title
                errorMessage = message
                showError = true
            })*/
        }
    }
    
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        if email == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func Authent(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We Need to scan your face. "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, AuthenticationError in
                if success{
                    //authent success
                    unlocked = true
                    isShowingHomeView = true
                }else{
                    //there was a problem
                }
            }
        } else {
            //no biometrics
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}




/*
struct LoginView: View {
    @State private var unlocked = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingHomeView = false
    @State private var isReset1Active = false
    @AppStorage("stored_User") var user = "emna.ouenniche@esprit.tn"
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                                   Image("logo-esprit")
                                       .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(height: 100)
                                       .padding(.top, 20)
                                   Spacer()
                               }
                               
                
                
                VStack {
                   
                    
                    Image("aa")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 280)
                        .ignoresSafeArea()
                    Spacer()
                }
                .padding(.top, 120) // add some padding to the top of the VStack
                
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
                    
                    
                     
//                    Button(action: login) {
//                        Text("Login")
//                            .foregroundColor(.white)
//                            .padding(.vertical, 10)
//                            .frame(maxWidth: .infinity)
//                            .background(Color.red)
//                            .cornerRadius(10)
//                    }
                    HStack {
                        Button(action: login) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        if getBioMetricStatus() {
                            Button(action: Authent) {
                                Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .clipShape(Circle())
                            }
                        }
                    }
                    
                    NavigationLink(destination: SignupView(), label: {
                        Text("Don't have an account? Sign up").foregroundColor(.black)
                    }).navigationBarBackButtonHidden(true)
               
                    NavigationLink(destination: ForgetView(), label: {
                        Text("Forgot password?").foregroundColor(.black)
                    }).navigationBarBackButtonHidden(true)
                  
                
                    NavigationLink(
                        destination: HomepageView(),
                        isActive: $isShowingHomeView
                    ){
                        EmptyView()
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 400)
                .padding(.bottom, 30)
                
                // Show error message
                .alert(isPresented: $showError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func login() {
        viewModel.login(email: email, password: password, onSuccess: { email in
            isShowingHomeView = true // navigate to HomeView
        }, onFailure: { title, message in
            // Show dialog with title and message
            errorTitle = title
            errorMessage = message
            showError = true
        })
    }
    
    func getBioMetricStatus()->Bool{
        let scanner = LAContext()
        if email == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        return false
    }
    
    func Authent(){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We Need to scan your face. "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {success, AuthenticationError in
                if success{
                    //authent success
                    unlocked = true
                    isShowingHomeView = true
                }else{
                    //there was a problem
                }
            }
        } else {
            //no biometrics
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
*/
