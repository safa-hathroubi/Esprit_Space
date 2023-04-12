import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @ObservedObject var viewModel = UserViewModel()
    @State private var isShowingHomeView = false
    @State private var isReset1Active = false

    
    
    
    var body: some View {
        NavigationView {
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
               
                    NavigationLink(destination: ForgetView()) {
                        Text("Forgot password?")
                    }
                  
                
                    NavigationLink(
                        destination: HomeView(),
                        isActive: $isShowingHomeView
                    ) {
                        EmptyView()
                    }
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.top, 300)
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
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


