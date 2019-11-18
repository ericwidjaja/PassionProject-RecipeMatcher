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
        mainImage.image = #imageLiteral(resourceName: "Image")
        mainImage.contentMode = .scaleToFill
        return mainImage
    }()
    
    lazy var titleLabel : UILabel = {
        let mainTitle = UILabel()
        mainTitle.adjustsFontSizeToFitWidth = true
        mainTitle.font = UIFont.init(name: "Noteworthy-Bold", size: 40)
        mainTitle.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        mainTitle.text = " RECIPE   MATCHERS "
        mainTitle.textAlignment = NSTextAlignment.center
        return mainTitle
    }()
    
    lazy var createAcctButton : UIButton = {
        let createAcct = UIButton()
        createAcct.setTitle("Create Account", for: .normal)
        createAcct.layer.cornerRadius = 20
       
        return createAcct
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.darkGray
        configureBackgroundImageConstraints()
        configureMainTitleConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func configureBackgroundImageConstraints() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor), backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), backgroundImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
    }
    private func configureMainTitleConstraints() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor), titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350), titleLabel.heightAnchor.constraint(equalToConstant: 60), titleLabel.widthAnchor.constraint(equalToConstant: 350)])
    }
}
