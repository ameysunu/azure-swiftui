//
//  ImageUploader.swift
//  trialhack
//
//  Created by Amey Sunu on 19/02/22.
//

import SwiftUI
import UIKit
import FirebaseStorage
import Firebase

typealias success = Bool

func uploadImage(image: UIImage, completion: @escaping (success) -> Void){
    
    if let imageData = image.jpegData(compressionQuality: 1){
        
        let storageRef = Storage.storage().reference()
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.child(Auth.auth().currentUser!.uid).putData(imageData, metadata: metaData){
            (StorageMetadata, error) in
            if let e = error {
                print("an error has occurred - \(e.localizedDescription)")
            } else {
                print("successfully saved")
                completion(true)
            }
        }
        
    }
}
