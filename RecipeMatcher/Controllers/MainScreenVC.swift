import UIKit
import Foundation

class MainScreenVC : UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = #imageLiteral(resourceName: "SplashScreen")
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        return mainImage
    }()
    
    lazy var titleLabel: UILabel = {
        let mainTitle = UILabel()
        mainTitle.adjustsFontSizeToFitWidth = true
        mainTitle.font = UIFont.init(name: "Noteworthy-Bold", size: 50)
        mainTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mainTitle.text = " RECIPE   MATCHERS "
        mainTitle.textAlignment = NSTextAlignment.center
        return mainTitle
    }()
    
    lazy var loginIdTextField: UITextField = {
        let logIn = UITextField()
        logIn.placeholder = "Enter Email"
        logIn.font = UIFont(name: "Noteworthy", size: 18)
        logIn.borderStyle = .roundedRect
        logIn.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        logIn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logIn.autocorrectionType = .no
//        logIn.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return logIn
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Password"
        textField.font = UIFont(name: "Noteworthy", size: 16)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
//        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton()
        signIn.setTitle("Sign In", for: .normal)
        signIn.layer.cornerRadius = 10
        signIn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        signIn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return signIn
    }()
    
    lazy var createAcctButton: UIButton = {
        let createAcct = UIButton()
        createAcct.setTitle("Create Account", for: .normal)
        createAcct.layer.cornerRadius = 10
        createAcct.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        createAcct.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return createAcct
    }()
    
    //to use app without signing in
    lazy var skipButton: UIButton = {
        let skip = UIButton()
        skip.setTitle("use app without personalization", for: .normal)
        skip.layer.cornerRadius = 10
        skip.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        skip.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        skip.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return skip
    }()
    
    private func createMainTabBarController() -> UITabBarController {
        let navController = UINavigationController(rootViewController: MainScreenVC())
        
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
