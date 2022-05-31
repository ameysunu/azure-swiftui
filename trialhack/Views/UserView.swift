//
//  UserView.swift
//  trialhack
//
//  Created by Amey Sunu on 20/02/22.
//

import SwiftUI
import GoogleSignIn

struct UserView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var userName: String
    private let user = GIDSignIn.sharedInstance.currentUser
    
    var body: some View {
        VStack{
            HStack {
                NetworkImage(url: user?.profile?.imageURL(withDimension: 200))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text(user?.profile?.name ?? "")
                        .font(.headline)
                    
                    Text(user?.profile?.email ?? "")
                        .font(.subheadline)
                }
                
            }
            .navigationBarTitle("Hello!")
            Spacer()
//            Button{
//                async {
//                    await translateData()
//                }
//            } label: {
//                Text("Hello")
//            }
            Button(action:{
                viewModel.signOut()
            }){
                Text("Logout")
                    .padding(8)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(10)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2.0)
                                .shadow(color: .blue, radius: 10.0))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
        }
        .padding()
    }
    
    struct NetworkImage: View {
        let url: URL?
        
        var body: some View {
            if let url = url,
               let data = try? Data(contentsOf: url),
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
    
    struct UserView_Previews: PreviewProvider {
        static var previews: some View {
            UserView(userName: "Glenn")
        }
    }
}
