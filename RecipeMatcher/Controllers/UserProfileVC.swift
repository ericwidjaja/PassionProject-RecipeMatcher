//
//  UserProfileVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 9/19/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth

class UserProfileVC: UIViewController {
    
    
    //MARK: - Properties
    
    var userProfile = UserProfileView()
    var currentUser = FirebaseAuthService.manager.currentUser
    
    //MARK: - Functions
    
    private func blurEffect() {
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        self.view.insertSubview(blurEffectView, at: 0)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "MainScreen")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func showUserProfile() {
        showUserNameLabel()
        showUserEmailLabel()
    }
    
    private func showUserNameLabel() {
        FirestoreService.manager.getUserInfo(userID: FirebaseAuthService.manager.currentUser?.uid ?? "") {result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let user):
                self.userProfile.userNameLabel.text = user.userName
            }
        }
        
    }
    private func showUserEmailLabel() {
        if let userEmail = FirebaseAuthService.manager.currentUser?.email {
            self.userProfile.emailLabel.text = "\(userEmail)"
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userProfile)
        view.backgroundColor = .clear
        blurEffect()
        showUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
}
