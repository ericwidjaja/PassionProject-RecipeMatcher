//  LogInView.swift
//  RecipeMatcher

import UIKit

class LogInView: UIView {

//MARK: - Objects
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
        mainTitle.numberOfLines = 1
        mainTitle.font = UIFont.init(name: "Noteworthy-Bold", size: 50)
        mainTitle.textColor = UIColor.white
        mainTitle.text = " RECIPE   MATCHERS "
        mainTitle.textAlignment = NSTextAlignment.center
        return mainTitle
    }()
    
    lazy var loginIdTextField: UITextField = {
        let logIn = UITextField()
        logIn.placeholder = "enter email here"
        logIn.font = UIFont(name: "Noteworthy", size: 18)
        logIn.borderStyle = .roundedRect
        logIn.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        logIn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logIn.autocorrectionType = .no
        return logIn
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "enter your password"
        textField.font = UIFont(name: "Noteworthy", size: 18)
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var signInButton: UIButton = {
        let signIn = UIButton(type: .system)
        signIn.setTitle("SIGN  IN", for: .normal)
        signIn.layer.cornerRadius = 10
        signIn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        signIn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        signIn.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        return signIn
    }()
    
    lazy var createAcctButton: UIButton = {
        let createAcct = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Create a New Account?       ",attributes: [
            NSAttributedString.Key.font: UIFont(name: "Noteworthy", size: 20)!,
            NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Sign Up!",
        attributes: [NSAttributedString.Key.font: UIFont(name: "Noteworthy-Bold", size: 20)!,
        NSAttributedString.Key.foregroundColor:  UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)]))
        createAcct.setAttributedTitle(attributedTitle, for: .normal)
        createAcct.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        createAcct.layer.cornerRadius = 10
        createAcct.titleLabel?.font = UIFont(name: "Noteworthy-Bold", size: 20)
        return createAcct
    }()
    
    //to use app without signing in
    lazy var skipButton: UIButton = {
        let skip = UIButton()
        skip.setTitle("use app without personalization", for: .normal)
        skip.layer.cornerRadius = 8
        skip.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        skip.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
//        skip.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        return skip
    }()
    
    lazy var objectsViewArray = [self.backgroundImageView, self.titleLabel, self.loginIdTextField, self.passwordTextField, self.signInButton, self.skipButton, self.createAcctButton]
    
    
    //MARK:Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }

//MARK: - Constraints
    private func logInViewConstraints() {
        addViewsToSubView()
        backGroundImageConstraints()
        mainTitleConstraints()
        loginIdConstraints()
        passwordConstraints()
        signInConstraints()
        createAccountConstraints()
        skipButtonConstraints()
    }
        
    private func backGroundImageConstraints() {
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
    private func mainTitleConstraints() { NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 60), titleLabel.heightAnchor.constraint(equalToConstant: 70), titleLabel.widthAnchor.constraint(equalToConstant: 350)])
    }
    
    private func loginIdConstraints() {
        NSLayoutConstraint.activate([loginIdTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor), loginIdTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), loginIdTextField.heightAnchor.constraint(equalToConstant: 40), loginIdTextField.widthAnchor.constraint(equalToConstant: 250)])
    }
    
    private func passwordConstraints() {
        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: loginIdTextField.bottomAnchor, constant: 11), passwordTextField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), passwordTextField.heightAnchor.constraint(equalToConstant: 40), passwordTextField.widthAnchor.constraint(equalToConstant: 250)])
    }
    
    private func signInConstraints() {
        NSLayoutConstraint.activate([signInButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -90), signInButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), signInButton.heightAnchor.constraint(equalToConstant: 35), signInButton.widthAnchor.constraint(equalToConstant: 165)])
    }
    
    private func createAccountConstraints() {
        NSLayoutConstraint.activate([
            createAcctButton.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            createAcctButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            createAcctButton.heightAnchor.constraint(equalToConstant: 35),
            createAcctButton.widthAnchor.constraint(equalToConstant: 360)])
    }
    private func skipButtonConstraints() {
        NSLayoutConstraint.activate([skipButton.topAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -28), skipButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor), skipButton.heightAnchor.constraint(equalToConstant: 18), skipButton.widthAnchor.constraint(equalToConstant: 280)])
    }
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        logInViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
