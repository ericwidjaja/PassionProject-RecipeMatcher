import UIKit
import Foundation

class LogInScreenVC : UIViewController {
    
    var logInScreen = LogInScreenView()
    
    private func createMainTabBarController() -> UITabBarController {
        let navController = UINavigationController(rootViewController: LogInScreenVC())
        
        let navController2 = UINavigationController(rootViewController: CollectionViewTabBarVC())

        navController.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass.circle"), tag: 0)

        navController2.tabBarItem = UITabBarItem(title: "COLLECTION", image: UIImage(systemName: "folder.fill.badge.plus"), tag: 1)
        
        let tabVC = UITabBarController()
        tabVC.setViewControllers([navController,navController2], animated: false)
        return tabVC
    }
    
    @objc func skipButtonPressed() {
        //complete implementation
       let destination = RecipesTabBar()
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
            else {
                
                return
        }
    
        window.rootViewController = destination 
    }
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setMainViewConstraints() {
        backGroundImageConstraints()
        mainTitleConstraints()
        loginIdConstraints()
        passwordConstraints()
        signInConstraints()
        createAccountConstraints()
        skipButtonConstraints()
    }
    
    private func backGroundImageConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    private func mainTitleConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60), titleLabel.heightAnchor.constraint(equalToConstant: 70), titleLabel.widthAnchor.constraint(equalToConstant: 350)])
    }
    
    private func loginIdConstraints() {
        view.addSubview(loginIdTextField)
        loginIdTextField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([loginIdTextField.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.centerYAnchor), loginIdTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), loginIdTextField.heightAnchor.constraint(equalToConstant: 35), loginIdTextField.widthAnchor.constraint(equalToConstant: 250)])
    }
    
    private func passwordConstraints() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: loginIdTextField.bottomAnchor, constant: 11), passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), passwordTextField.heightAnchor.constraint(equalToConstant: 35), passwordTextField.widthAnchor.constraint(equalToConstant: 250)])
    }
    
    private func signInConstraints() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([signInButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -85), signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), signInButton.heightAnchor.constraint(equalToConstant: 25), signInButton.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    private func createAccountConstraints() {
        view.addSubview(createAcctButton)
        createAcctButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([createAcctButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -54), createAcctButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), createAcctButton.heightAnchor.constraint(equalToConstant: 25), createAcctButton.widthAnchor.constraint(equalToConstant: 150)])
    }
    private func skipButtonConstraints() {
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([skipButton.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40), skipButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), skipButton.heightAnchor.constraint(equalToConstant: 20), skipButton.widthAnchor.constraint(equalToConstant: 300)])
    }
}
