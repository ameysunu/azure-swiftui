//
//  trialhackApp.swift
//  trialhack
//
//  Created by Amey Sunu on 18/02/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct trialhackApp: App {
    @StateObject var viewModel = AuthenticationViewModel()
    init() {
        setupAuthentication()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

extension trialhackApp {
    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
