//
//  API.swift
//  trialhack
//
//  Created by Amey Sunu on 21/02/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var language: String
    var regions: [Regions]
}

struct Regions: Codable {
    var boundingBox: String
    var lines: [Lines]
}

struct Lines: Codable {
    var boundingBox: String
    var words: [Words]
}

struct Words: Codable, Hashable {
    var boundingBox: String
    var text: String
}

var resultsFromAPI = [String]()
var words = [Words]()
var synthesizedText: String = ""

func postData(imageURL: String, completion: @escaping (success) -> Void) async {
    guard let url = URL(string: "https://westeurope.api.cognitive.microsoft.com/vision/v3.2/ocr?language=en&detectOrientation=true&model-version=latest") else {
        return
    }
    var request = URLRequest(url: url)
    let httpBody: [String: String] =  [
        "url":"\(imageURL)"]
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key": "80a2d70f307c4cfaa0d24bfe240c2e89"]
    request.httpBody = try! JSONSerialization.data(withJSONObject:httpBody)
    URLSession.shared.dataTask(with: request){ (data, response, error) in
        if data!.isEmpty{
            print(error as Any)
        } else{
            let str = String(decoding: data!, as: UTF8.self)
            print(response as Any)
            print(str)
            let jsonData = try! JSONDecoder().decode(Result.self, from: data!)
            for item in jsonData.regions {
                for value in item.lines{
                    for text in value.words{
                        print(text.text)
                        words = [Words(boundingBox: text.boundingBox, text: text.text)]
                        synthesizedText = text.text
                        print(words)
                    }
                }
            }
            //            let jsonData = try! JSONDecoder().decode(Result.self, from: str)
            //            print(jsonData)
            completion(true)
        }
    }.resume()
    
}

func translateData() async {
    guard let url = URL(string: "https://translateapitext.cognitiveservices.azure.com") else {
        return
    }
    var request = URLRequest(url: url)
    let httpBody: [String: String] =  [
        "text":"hello"]
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key": "fae826b208e64606a9b62ac3bb292fc0", "Ocp-Apim-Subscription-Region": "global"]
    request.httpBody = try! JSONSerialization.data(withJSONObject:httpBody)
    
    let parameters:[String:String] = [
        "api-version": "3.0",
            "to": "es"
    ]
    request.httpBody = try! JSONSerialization.data(withJSONObject:parameters)
    
    URLSession.shared.dataTask(with: request){ (data, response, error) in
        if data!.isEmpty{
            print(error as Any)
        } else {
            let str = String(decoding: data!, as: UTF8.self)
            //print(response as Any)
            print(str)
            
        }
        
    }
    .resume()
}
