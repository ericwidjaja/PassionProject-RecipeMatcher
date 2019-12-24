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
        let alert = UIAlertController(title: "Sign In", message: "Create an account", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel)
        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) -> Void in
            
            guard let email = self.logInEmail?.text, !email.isEmpty, let password = self.logInPassword?.text, !password.isEmpty else {
                self.showAlert(with: "Required", and: "Fill both fields")
                return
            }
            FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { (result) in
                switch result {
                case .failure(let error):
                    self.showAlert(with: "Couldn't create user", and: "Error: \(error)")
                case .success(let newUser):
                    FirestoreService.manager.createAppUser(user: AppUser.init(from: newUser)) { (result) in self.handleSignInResponse(with: result)
                    }
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter email address"
            self.logInEmail = textField
        })
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter password"
            textField.isSecureTextEntry = true
            self.logInPassword = textField
        })
        
        self.present(alert, animated: true, completion: nil)
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

