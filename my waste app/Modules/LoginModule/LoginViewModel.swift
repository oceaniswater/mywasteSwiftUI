//
//  LoginViewModel.swift
//  my waste app
//
//  Created by Mark Golubev on 31/07/2023.
//

import CryptoKit
import AuthenticationServices
import Firebase

@MainActor
final class AuthViewModel: NSObject, ObservableObject {
    let helper = SignInAppleHelper()
    

    func signInApple() async throws {
        let helper = SignInAppleHelper()
        let tokens = try await helper.startingSigInWithAplleFlow()
        try await AuthenticationManager.shared.signInWithApple(tokens: tokens)
    }
  
}



