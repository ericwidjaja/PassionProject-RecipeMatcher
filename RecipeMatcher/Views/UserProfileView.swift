//  UserProfileView.swift
//  RecipeMatcher
//  Created by Eric Widjaja on 9/19/20.
//  Copyright © 2020 Eric W. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth


class UserProfileView: UIView {
    
    //MARK: - Objects
    
    lazy var contentView: UIView = {
        let profileView = UIView()
        profileView.backgroundColor = #colorLiteral(red: 0.1504360437, green: 0.006763501558, blue: 0.5917420983, alpha: 0.7002622003)
        profileView.alpha = 0.4
        return profileView
    }()
    
    lazy var backgroundImageView: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.layer.cornerRadius = 20
        backgroundImage.image = #imageLiteral(resourceName: "MainScreen")
        backgroundImage.contentMode = .scaleToFill
        return backgroundImage
    }()
    
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "person.circle")
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "eric"
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        return nameLabel
    }()
    
    lazy var emailLabel: UILabel = {
        let emailLabel = UILabel()
        emailLabel.text = "e-mail"
        emailLabel.textAlignment = .center
        emailLabel.textColor = UIColor.white
        return emailLabel
    }()
    
    lazy var objectsViewArray = [self.backgroundImageView, self.userImageView, self.userNameLabel, self.emailLabel]
    
    
    //MARK: - Add ViewsToSubviews
    func addViewsToSubView() {
        for aView in objectsViewArray {
            self.addSubview(aView)
            aView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    
}
