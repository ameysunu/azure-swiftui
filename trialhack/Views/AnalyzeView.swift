//
//  AnalyzeView.swift
//  trialhack
//
//  Created by Amey Sunu on 23/02/22.
//

import SwiftUI
import AVFoundation

struct AnalyzeView: View {
    @State var isPlaying: Bool = false
    var body: some View {
        VStack(){
            HStack {
                Text("Analyzed Data")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            HStack{
                ForEach(words, id: \.self)  { item in
                    Text(item.text)
                }
                Spacer()
            }
            .padding()
            Spacer()
            Button(action:{
                speechSynthesize(utterance: synthesizedText){
                    (success) ->  Void in
                    if success{
                        self.isPlaying.toggle()
                    }
                }
            }){
                if isPlaying{
                    HStack{
                        Image(systemName: "arrow.clockwise")
                        Text("Hear again")
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
                
                else {
                    HStack{
                        Image(systemName: "speaker.wave.3")
                        Text("Hear me!")
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
        .padding()
        
    }
}

struct AnalyzeView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzeView()
    }
}
