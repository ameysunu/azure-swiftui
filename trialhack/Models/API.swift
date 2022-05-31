//
//  API.swift
//  trialhack
//
//  Created by Amey Sunu on 21/02/22.
//

import Foundation
import Alamofire

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

//func translateData() async {
//    guard let url = URL(string: "https://translateapitext.cognitiveservices.azure.com") else {
//        return
//    }
//    var request = URLRequest(url: url)
//    let httpBody: [String: String] =  [
//        "text":"hello"]
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpMethod = "POST"
//    request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key": "fae826b208e64606a9b62ac3bb292fc0", "Ocp-Apim-Subscription-Region": "global"]
//    request.httpBody = try! JSONSerialization.data(withJSONObject:httpBody)
//
//    let parameters:[String:String] = [
//        "api-version": "3.0",
//            "to": "es"
//    ]
//    request.httpBody = try! JSONSerialization.data(withJSONObject:parameters)
//
//    URLSession.shared.dataTask(with: request){ (data, response, error) in
//        if data!.isEmpty{
//            print(error as Any)
//        } else {
//            let str = String(decoding: data!, as: UTF8.self)
//            //print(response as Any)
//            print(str)
//
//        }
//
//    }
//    .resume()
//}

func translateData() async {
    var language = "zh-Hans"
    
//    curl -X POST "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=zh-Hans" -H "Ocp-Apim-Subscription-Key: 5ff24a1101af43ca982874d5b0b02749" -H "Ocp-Apim-Subscription-Region: westeurope" -H  "Content-Type: application/json; charset=UTF-8" -d "[{'Text':'Hello, what is your name?'}]"
    
//    guard let url = URL(string: "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&") else {
//        return
//    }
//    var request = URLRequest(url: url)
//    let httpBody: [String: String] =  [
//        "to":"\(language)"]
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpMethod = "POST"
//    request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key": "5ff24a1101af43ca982874d5b0b02749", "Ocp-Apim-Subscription-Region" : "westeurope"]
//    request.httpBody = try! JSONSerialization.data(withJSONObject:httpBody)
//    URLSession.shared.dataTask(with: request){ (data, response, error) in
//        if data!.isEmpty{
//            print(error as Any)
//        } else{
//            let str = String(decoding: data!, as: UTF8.self)
//            print(response as Any)
//            print(str)
//            let jsonData = try! JSONDecoder().decode(Result.self, from: data!)
//            for item in jsonData.regions {
//                for value in item.lines{
//                    for text in value.words{
//                        print(text.text)
//                        words = [Words(boundingBox: text.boundingBox, text: text.text)]
//                        synthesizedText = text.text
//                        print(words)
//                    }
//                }
//            }
//            //            let jsonData = try! JSONDecoder().decode(Result.self, from: str)
//            //            print(jsonData)
//            completion(true)
//        }
//    }.resume()
    
    let url = URL(string: "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=zh-Hans")!
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = ["Ocp-Apim-Subscription-Key": "5ff24a1101af43ca982874d5b0b02749", "Ocp-Apim-Subscription-Region" : "westeurope"]
    
    let headers = ["Ocp-Apim-Subscription-Key": "5ff24a1101af43ca982874d5b0b02749", "Ocp-Apim-Subscription-Region" : "westeurope", "Content-Type": "application/json"]
    
    let parameters = ["to" : "zh-Hans"]
    let body = [{"text" : "hello"}]
    AF.request("https://api.cognitive.microsofttranslator.com/translate?api-version=3.0", method: .post, parameters: parameters, encoding: BodyStringEncoding(body: body), headers: ["Ocp-Apim-Subscription-Key": "5ff24a1101af43ca982874d5b0b02749", "Ocp-Apim-Subscription-Region" : "westeurope", "Content-Type": "application/json"])
        .responseJSON { response in
            print(response)
        }
}

struct BodyStringEncoding: ParameterEncoding {

    private let body: String

    init(body: String) { self.body = body }

    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard var urlRequest = urlRequest.urlRequest else { throw Errors.emptyURLRequest }
        guard let data = body.data(using: .utf8) else { throw Errors.encodingProblem }
        urlRequest.httpBody = data
        return urlRequest
    }
}

extension BodyStringEncoding {
    enum Errors: Error {
        case emptyURLRequest
        case encodingProblem
    }
}

extension BodyStringEncoding.Errors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyURLRequest: return "Empty url request"
            case .encodingProblem: return "Encoding problem"
        }
    }
}

