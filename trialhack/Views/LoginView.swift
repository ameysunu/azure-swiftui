//
//  LoginView.swift
//  trialhack
//
//  Created by Amey Sunu on 18/02/22.
//

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Spacer()
                Image("login")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 250)
                    .padding()
                Spacer()
            }
            Text("Welcome")
                .font(.title)
                .fontWeight(.bold)
            Text("Hear everything, happening in realtime.")
            Spacer()
            Button(action:{viewModel.signIn()}){
                HStack(spacing: 10){
                    Image("googleLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 45)
                    Text("Sign in with Google")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                }
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2.0)
                            .shadow(color: .blue, radius: 10.0))
            }
            
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
