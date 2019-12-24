//  LogInScreenVC.swift
//  RecipeMatcher

import UIKit
import FirebaseAuth

class LogInScreenVC: UIViewController {
    
    var logInEmail: UITextField?
    var logInPassword: UITextField?
    var logInScreen = LogInView()
    
    private func createMainTabBarController() -> UITabBarController {
        let navController = UINavigationController(rootViewController: SearchRecipesVC())
        let navController2 = UINavigationController(rootViewController: RecipesCollResultsVC())
        
        navController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)
        navController2.tabBarItem = UITabBarItem(title: "COLLECTION", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 1)
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([navController,navController2], animated: false)
        return tabVC
    }
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    //MARK: - OBJ-C Methods
    
    @objc func validateFields() {
        guard logInEmail!.hasText, logInPassword!.hasText else {
            logInScreen.signInButton.isEnabled = false
            return }
        logInScreen.signInButton.isEnabled = true
    }
    
    @objc func signInButtonPressed() {
        let signInButton = logInScreen.signInButton
        guard let email = logInScreen.loginIdTextField.text, !email.isEmpty,
            let password = logInScreen.passwordTextField.text, !password.isEmpty
            else {
                showAlert(with: "Required", and: "Please fill out all fields")
                return
        }
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in self.handleSignInResponse(with: result)
        }
    }
    //MARK: Firebase Authentication Methods
    private func handleSignInResponse(with result: Result<(), Error>) {
        switch result {
        case .failure(let error):
            print(error)
            self.showAlert(with: "Error", and: "Could not log in. Error: \(error)")
            
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                else { return }
            print("SignIn Successful")
            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromBottom, animations: {
                window.rootViewController = {
                    let mainVC = RecipeMatchTabBar()
                    return mainVC
                }()
                
            }, completion: nil)
        }
    }
    
    @objc func createAcctPressed() {
//        let createAcct = CreateAcctVC()
//        createAcct.modalPresentationStyle = .currentContext
//        present(createAcct, animated: true, completion: nil)
    print("createAcctIsPressed")
    }
    
    @objc func skipButtonPressed() {
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
        
        logInScreen.signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        logInScreen.createAcctButton.addTarget(self, action: #selector(createAcctPressed), for: .touchUpInside)
        logInScreen.skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
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

