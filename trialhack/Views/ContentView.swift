//
//  ContentView.swift
//  trialhack
//
//  Created by Amey Sunu on 18/02/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    var body: some View {
        switch viewModel.state {
        case .signedIn: HomeView()
        case .signedOut: LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
