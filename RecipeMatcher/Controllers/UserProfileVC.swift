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
    var displayNameTextBox: UITextField?
    
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
        //        showUserNameLabel()
        showUserEmailLabel()
        setDisplayName()
    }
    
    private func setDisplayName() {
        if let displayName = FirebaseAuthService.manager.currentUser?.displayName {
            self.userProfile.userNameLabel.text = displayName
        }
    }
    
    private func updateUserNameField(newDisplayName: String) {
        guard let userUID = currentUser?.uid else {
            return
        }
        FirestoreService.manager.updateAppUser(id: userUID, newDisplayName: newDisplayName)
        { (result) in
            switch result {
            case .success:
                print("Users profiles are updated")
            case .failure(let error):
                print(error)
            }
        }
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
    
    private func buttonsTapped() {
        userProfile.logOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        userProfile.editButton.addTarget(self, action: #selector(editProfileName), for: .touchUpInside)
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: -Objc Functions
    @objc func editProfileName() {
        //create alert
        let alert = UIAlertController(title: "What is your new profile name?", message: nil, preferredStyle: .alert)
        //create cancel option
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //create save option
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) -> Void in guard let newName = self.displayNameTextBox?.text, !newName.isEmpty else {
            self.showAlert(with: "Required", and: "please enter your profile name")
            return
            }
            FirebaseAuthService.manager.updateUserFields(userName: newName) { (result) in
                switch result {
                case .success:
                    self.showAlert(with: "Successful!", and: "your profile name has changed")
                    self.userProfile.userNameLabel.text = newName
                    self.updateUserNameField(newDisplayName: newName)
                case .failure(let error):
                    print(error)
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "What is the new profile name?"
            self.displayNameTextBox = textField
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func signOut() {
        let alert = UIAlertController(title: "Sign Out from this App?", message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .destructive, handler: .some({ (action) in
            DispatchQueue.main.async {
                FirebaseAuthService.manager.logoutUser()
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                    let sceneDelegate = windowScene.delegate as? SceneDelegate,
                    let window = sceneDelegate.window else {return}
                UIView.transition(with: window, duration: 0.6, options: .curveEaseInOut
                    , animations: {
                        window.rootViewController = LogInScreenVC()
                }, completion: nil)}
        }))
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated:true)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(userProfile)
        view.backgroundColor = .clear
        blurEffect()
        showUserProfile()
        buttonsTapped()
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
