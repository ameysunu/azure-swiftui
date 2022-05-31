//
//  SpeechSynthesizer.swift
//  trialhack
//
//  Created by Amey Sunu on 07/03/22.
//

import Foundation
import AVFoundation

func speechSynthesize(utterance: String, completion: @escaping (success) -> Void){
    let utterance = AVSpeechUtterance(string: "\(utterance)")
    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    utterance.rate = 0.5
    let synthesizer = AVSpeechSynthesizer()
    synthesizer.speak(utterance)
    completion(true)
}
