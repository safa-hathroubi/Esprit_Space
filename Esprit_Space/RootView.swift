//
//  RootView.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 17/05/2023.
//

import SwiftUI

struct RootView: View {

    @State private var showLogin: Bool = false
    @State private var showSignup: Bool = false
    @ObservedObject var viewModel = UserViewModel()
    
    
    
    
    var body: some View {
        ZStack {
            if viewModel.isAuthenticated {
                // Replace 'MainAppView()' with your actual main app view
                HomepageView()
            } else {
                LoginView(viewModel: viewModel)
            }
            
        }
    }
    
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

