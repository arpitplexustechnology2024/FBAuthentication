//
//  ViewController.swift
//  FBAuthentication
//
//  Created by Arpit iOS Dev. on 19/06/24.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacebookLoginButton()
    }
    
    func setupFacebookLoginButton() {
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.delegate = self
        loginButton.permissions = ["email"]
        view.addSubview(loginButton)
    }
}

extension ViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            if let error = error as NSError? {
                print("Failed to login: \(error.localizedDescription)")
                print("Error code: \(error.code)")
            }
            return
        }
        
        guard let accessToken = AccessToken.current else {
            print("Failed to get access token")
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase login failed: \(error.localizedDescription)")
                return
            }
            // User is signed in
            print("User is signed in")
            // Transition to another view controller
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User logged out of Facebook")
    }
}
