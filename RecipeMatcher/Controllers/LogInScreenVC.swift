//  LogInScreenVC.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 12/1/19.
//  Copyright © 2019 Eric W. All rights reserved.


import UIKit
import Foundation

class LogInScreenVC : UIViewController {
    
    var logInEmail: UITextField?
    var logInPassword: UITextField?
    var logInScreen = LogInView()
    
    private func createMainTabBarController() -> UITabBarController {
        let navController = UINavigationController(rootViewController: SearchRecipesVC())
        
        let navController2 = UINavigationController(rootViewController: CollectionViewTabBarVC())

        navController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)

        navController2.tabBarItem = UITabBarItem(title: "COLLECTION", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 1)
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([navController,navController2], animated: false)
        return tabVC
    }
    
//    @objc func skipButtonPressed() {
//        //complete implementation
//       let destination = RecipeMatchTabBar()
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
//            else {
//                return
//        }
//        window.rootViewController = destination
//    }
    @objc func skipButtonPressed() {
        //complete implementation
//       let destination = RecipeMatchTabBar()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
                return }
        window.rootViewController = {
            let searchSetUpVC = RecipeMatchTabBar()
                searchSetUpVC.selectedIndex = 0
            return searchSetUpVC
        }()


    }
    
    
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logInScreen)
        logInEmail?.delegate = self
        logInPassword?.delegate = self
        logInScreen.skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        
//        logInScreen.signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
//        logInScreen.createNewAcctButton.addTarget(self, action: #selector(createAcctForm), for: .touchUpInside)
    }
}


//MARK: - Extensions
extension LogInScreenVC: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        logInScreen.loginIdTextField.clearsOnBeginEditing = true
        logInScreen.passwordTextField.clearsOnBeginEditing = true
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        logInPassword?.resignFirstResponder()
        logInEmail?.resignFirstResponder()
        return (true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

