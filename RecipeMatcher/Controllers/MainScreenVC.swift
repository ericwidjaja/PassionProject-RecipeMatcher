//
//  MainScreenVC.swift
//  RecipeMatcher
//
//  Created by Eric Widjaja on 11/3/19.
//  Copyright © 2019 Eric W. All rights reserved.
//

import UIKit

class MainScreenVC : UIViewController {
    
    lazy var backgroundImageView : UIImageView = {
        let mainImage = UIImageView()
        mainImage.image = #imageLiteral(resourceName: "SplashScreen")
        mainImage.contentMode = .scaleAspectFill
        mainImage.clipsToBounds = true
        return mainImage
    }()
    
    lazy var titleLabel : UILabel = {
        let mainTitle = UILabel()
        mainTitle.adjustsFontSizeToFitWidth = true
        mainTitle.font = UIFont.init(name: "Noteworthy-Bold", size: 50)
        mainTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mainTitle.text = " RECIPE   MATCHERS "
        mainTitle.textAlignment = NSTextAlignment.center
        return mainTitle
    }()
    
    
    lazy var signInButton : UIButton = {
        let signIn = UIButton()
        signIn.setTitle("Sign In", for: .normal)
        signIn.layer.cornerRadius = 5
        signIn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        signIn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return signIn
    }()
    
    lazy var createAcctButton : UIButton = {
        let createAcct = UIButton()
        createAcct.setTitle("Create Account", for: .normal)
        createAcct.layer.cornerRadius = 5
        createAcct.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        createAcct.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return createAcct
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainViewConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func setMainViewConstraints() {
        backGroundImageConstraints()
        mainTitleConstraints()
        signInConstraints()
        createAccountConstraints()
    }
    
    private func backGroundImageConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    private func mainTitleConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40), titleLabel.heightAnchor.constraint(equalToConstant: 70), titleLabel.widthAnchor.constraint(equalToConstant: 350)])
    }
    
    private func signInConstraints() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([signInButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 425), signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), signInButton.heightAnchor.constraint(equalToConstant: 24), signInButton.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    private func createAccountConstraints() {
        view.addSubview(createAcctButton)
        createAcctButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([createAcctButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10), createAcctButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), createAcctButton.heightAnchor.constraint(equalToConstant: 24), createAcctButton.widthAnchor.constraint(equalToConstant: 150)])
    }
}
