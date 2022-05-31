//
//  HomeView.swift
//  trialhack
//
//  Created by Amey Sunu on 19/02/22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import GoogleSignIn
import FirebaseInstallations

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @State var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State var userPressed: Bool = false
    private let user = GIDSignIn.sharedInstance.currentUser
    @State var genImageURL: String = ""
    @State var isUploaded: Bool = false
    @State var progressTriggered: Bool = false
    @State var isAnalyzed: Bool = false
    //    @State var dataResponse = [Words(boundingBox: "Text", text: "89101")]
    @State var analyzeProgress: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                if image.size.width != 0 {
                    Image(uiImage: self.image)
                        .resizable()
                        .scaledToFit()
                    Button(action:{
                        progressTriggered = true
                        uploadImage(image: image){
                            (success) -> Void in
                            if success {
                                let storageRef = Storage.storage().reference(withPath: "\(Auth.auth().currentUser!.uid)")
                                storageRef.downloadURL{ (url, error) in
                                    if error != nil {
                                        print((error?.localizedDescription)!)
                                        isUploaded = false
                                        return
                                    }
                                    print(url!.absoluteString)
                                    genImageURL = url!.absoluteString
                                    isUploaded.toggle()
                                }
                            }
                            progressTriggered = false
                        }
                    }){
                        Text("Upload and Generate")
                    }
                    .padding()
                } else {
                    Spacer()
                    HStack{
                        Text("Select a photo to get started")
                            .font(.title2)
                            .padding()
                        Image(systemName: "arrow.down")
                    }
                }
                Spacer()
                if isUploaded{
                    Button{
                        async {
                            analyzeProgress.toggle()
                            await postData(imageURL: genImageURL){
                                (success) -> Void in
                                if success {
                                    self.isAnalyzed = true
                                    analyzeProgress.toggle()
                                }
                            }
                        }
                    } label: {
                        if analyzeProgress{
                            ProgressView()
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding(10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 2.0)
                                            .shadow(color: .blue, radius: 10.0))
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        } else {
                            HStack{
                                Image(systemName: "qrcode")
                                Text("Analyze")
                            }
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
                }
                Button(action:{
                    self.isShowPhotoLibrary = true
                }){
                    HStack{
                        Image(systemName: "camera")
                        Text("Select a photo")
                    }
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
            .navigationBarTitle("Home")
            .overlay(
                Group{
                    if progressTriggered {
                        ProgressView("Uploading")
                    }
                }
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UserView(userName: user?.profile?.name ?? ""), isActive: $userPressed){
                        Button("My Account") {
                            self.userPressed = true
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowPhotoLibrary){
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
            }
            .sheet(isPresented: $isAnalyzed){
                AnalyzeView()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
