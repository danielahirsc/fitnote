//
//  FitNoteApp.swift
//  FitNote
//
//  Created by Daniela Hirsch on 23/07/2025.
//

import SwiftUI
import AuthenticationServices

@main
struct FitNoteApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            if authManager.isAuthenticated {
                ContentView()
                    .environmentObject(authManager)
            } else {
                LoginView()
                    .environmentObject(authManager)
            }
        }
    }
}

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var userID: String?
    @Published var userEmail: String?
    @Published var userName: String?
    
    init() {
        // Check if user is already signed in
        checkExistingSignIn()
    }
    
    func checkExistingSignIn() {
        // Check for existing Apple ID sign in
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: UserDefaults.standard.string(forKey: "appleUserID") ?? "") { [weak self] state, error in
            DispatchQueue.main.async {
                switch state {
                case .authorized:
                    self?.isAuthenticated = true
                    self?.userID = UserDefaults.standard.string(forKey: "appleUserID")
                    self?.userEmail = UserDefaults.standard.string(forKey: "userEmail")
                    self?.userName = UserDefaults.standard.string(forKey: "userName")
                case .revoked, .notFound:
                    self?.signOut()
                default:
                    break
                }
            }
        }
    }
    
    func signOut() {
        isAuthenticated = false
        userID = nil
        userEmail = nil
        userName = nil
        UserDefaults.standard.removeObject(forKey: "appleUserID")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userName")
    }
}
