//
//  GoogleSignInButton.swift
//  trialhack
//
//  Created by Amey Sunu on 19/02/22.
//

import SwiftUI
import GoogleSignIn

struct GoogleSignInButton: UIViewRepresentable {
  @Environment(\.colorScheme) var colorScheme
  
  private var button = GIDSignInButton()

  func makeUIView(context: Context) -> GIDSignInButton {
    button.colorScheme = colorScheme == .dark ? .dark : .light
    return button
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {
    button.colorScheme = colorScheme == .dark ? .dark : .light
  }
}
